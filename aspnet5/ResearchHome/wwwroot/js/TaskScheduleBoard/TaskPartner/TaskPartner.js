var taskPartnerCols = [
    { field: 'Id' }
    , { field: 'PartnerName', width: 170, title: '姓名', sort: true }
    , { field: 'CreatedTime', title: '加入时间', width: 170, templet: '#createdTime', sort: true }
    , { field: 'Description', title: '说明', toolbar: '#decription', width: 355 }
];

var taskPartnerTableSortData = { field: "CreatedTime", type: "DESC" };
var taskData;
window.onload = function () {
    getPartnerTaskInfo();
    loadTaskPartnerData();
}

function getPartnerTaskInfo() {
    layui.use('laytpl', function () {
        var laytpl = layui.laytpl;
        $.ajax({
            type: "POST",
            dataType: "json",
            data: { taskId: GetQueryString("taskId") },
            url: "/TaskScheduleBoard/TaskPartner/GetPartnerTaskInfo",
            success: function (data) {
                taskData = data;
                var optionMenuMaster = document.getElementById('optionMenuMaster');
                var getTpl = optionMenuMaster.innerHTML;
                var optionMenu = document.getElementById('optionMenu');
                laytpl(getTpl).render(data, function (html) {
                    optionMenu.innerHTML = html;
                });
            }
        });
    });
}

var choosedpartnerId = 0;

//表格点击变色
$(document).on('click', '.layui-table>tbody>tr', function () {
    $('.layui-table>tbody>tr').removeClass("tableClick");
    $('.layui-table>tbody>tr').removeClass("layui-table-click");
    $($('.layui-table').find('.layui-table-hover')[0]).addClass("tableClick").siblings().removeClass("tableClick");
    var chooseDisVisibleDocument = $($('.layui-table').find('.layui-table-hover')[0]).find(".DisVisibleKeyStyle>div");
    choosedpartnerId = parseInt($(chooseDisVisibleDocument[0]).html());
});

$(document).mousedown(function (e) {
    if (!e) {
        var e = window.event;
    }
    var target = e.target;
    if (target.id === 'removePartner' || target.id === 'removePartnerImg') {
        return false;
    } else {
        $('.layui-table>tbody>tr').removeClass("tableClick");
        $('.layui-table>tbody>tr').removeClass("layui-table-click");
        choosedpartnerId = 0;
    }
});

function loadTaskPartnerData() {
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#taskPartnerTable'
            , url: '/TaskScheduleBoard/TaskPartner/GetPartnerData'
            , height: 'full'
            , method: 'post'
            , page: false
            , cols: [taskPartnerCols]
            , where: {
                taskId: GetQueryString("taskId"),
                sortField: taskPartnerTableSortData.field,
                sortType: taskPartnerTableSortData.type
            }
            , done: function (res) {
                $("[data-field='Id']").addClass('DisVisibleKeyStyle');
                setSortStyle("taskPartnerTable", taskPartnerTableSortData);
            }
        });

        //排序事件
        table.on('sort(taskPartnerTableFilter)', function (data) {
            taskPartnerTableSortData = data;
            loadTaskPartnerData();
        });
    });
}

function addPartner() {
    if (taskData.MemberId === 0) {
        layer.msg("请先给任务指定负责人,可在任务修改中重新指定!", { shift: -1, time: 1000, shade: 0.3 });
        return;
    }
    var index = layer.open({
        type: 2,
        title: " ",
        area: ['500px', '300px'],
        shadeClose: true,
        async: false,
        content: "/TaskScheduleBoard/TaskPartner/DealTaskPartner?taskId=" + GetQueryString("taskId")
            + '&taskPrincipalPersonId=' + taskData.MemberId,
        end: function () {
            loadTaskPartnerData();
        }
    });
}

function removePartner(choosedpartnerId) {
    if (choosedpartnerId === 0) {
        layer.msg("请在列表中选择移除人!", { shift: -1, time: 500, shade: 0.3 });
        return;
    }
    layer.confirm('确认移除?', { icon: 3, title: '移除参与人' }, function (index) {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: "/TaskScheduleBoard/TaskPartner/DeleteTaskPartner",
            data: {
                partnerId: choosedpartnerId
            },
            success: function (data) {
                if (data) {
                    layer.msg("移除成功!", { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () { loadTaskPartnerData(); });
                } else {
                    layer.msg("移除失败,请重试!", { icon: 5, shift: -1, time: 500, shade: 0.3 });
                }
            }
        });
        layer.close(index);
    });
}