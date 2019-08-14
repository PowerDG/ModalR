var titleChangeListlimitPage;
$(document).ready(function () {
    //loadTitlechangesTable();

    $("#titlechangesContent").change(function (e) {
        titleChangeListlimitPage = $(e.target).find("option:selected").attr('value');
    });
});

function loadTitlechangesTable() {
    layui.use(['table', 'layer'], function () {
        var table = layui.table;
        var columns = [
            { type: 'numbers', title: '序号', width: 50 },
            { field: 'ChangedTime', title: '时间', width: 191, templet: '<p>{{toDateString(d.ChangedTime,"YYYY-MM-DD HH:mm")}}</p>' },
            { field: 'OldTitle', title: '旧职位', width: 246 },
            { field: 'NewTitle', title: '新职位', width: 246 },
            { field: 'CreatedMemberName', title: '操作人', width: 221, templet: '#titleChangeTable' }];
        table.render({
            elem: '#table_titlechanges'
            , width: 960
            , url: '/introduction/title/gettitlechanges?id=' + $("#memberPageId").val()
            , page: true
            , limit: titleChangeListlimitPage === undefined ? 5 : titleChangeListlimitPage
            , limits: [5, 10, 20, 30, 100]
            , cols: [columns]
        });
    });
}

function editTitle(_memberPageId, recordId) {
    layer.open({
        resize: false,
        title: '职位变更',
        type: 2,
        area: ['350px', '300px'],//宽高
        content: "/introduction/title/titlechange?memberId=" + _memberPageId + "&recordId=" + recordId,
        end: function () {
            loadTitlechangesTable();
            loadNewTitle();
        }
    });
}

function deleterecord(id) {
    layer.confirm('确定要删除吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/title/delete", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                loadTitlechangesTable();
                loadNewTitle();
            };
        });
    }, function () { });
}


function loadNewTitle() {
    $.get("/introduction/member/GetNewTitle?id=" + $("#memberPageId").val(), function (data) {
        $("#now_title").text(data.title);
    });
}
