var taskPoolCols = [
    { field: 'Index', width: 60, title: '序号', align: 'center'}
    //,{ field: 'Id', width: 70, title: '序号', sort: true }
    , { field: 'Name', title: '名称' }
    , { field: 'Score', width: 60, title: '分数', align: 'center'}
    , { field: 'Status', width: 80, title: '状态', align: 'center' }
    , { field: 'MemberName', width: 80, title: '负责人', align: 'center'}
    , { field: 'LastUpdateTime', width: 280, title: '更新时间', templet: '#taskPoolLastUpdateTime'}
];

var taskPoolSortData = { field: "CreatedTime", type: "desc" };

function loadTaskPoolData() {
    layui.config({
        base: '/lib/'
    }).extend({
        treetable: 'treetable-lay/treetable'
    }).use(['layer', 'table', 'treetable'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var treetable = layui.treetable;

        // 渲染表格
        var renderTable = function () {
            layer.load(2);
            treetable.render({
                treeColIndex: 1,
                treeSpid: 0,
                treeIdName: 'Id',
                treePidName: 'ParentId',
                treeDefaultClose: true,
                treeLinkage: false,
                elem: '#taskPool',
                url: '/TaskScheduleBoard/TaskSchedule/GetTaskPoolData',
                page: false,
                cols: [taskPoolCols],
                where: {
                    sortField: taskPoolSortData.field,
                    sortType: taskPoolSortData.type
                },
                done: function (res) {
                    layer.closeAll('loading');
                    setTableIndex("taskPoolContent");
                    setSortStyle("taskPool", taskPoolSortData);
                    $('#taskPoolContentCount').html(res.data === null ? 0 : res.data.length);
                }
            });
        };

        renderTable();


        //监听工具条
        table.on('tool(taskPoolFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'showDetail') {
                showTaskDetail(data.Id, data.Status, layer);
            } else if (obj.event === 'getTask') {
                layer.confirm('确定领取任务?', function (index) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "/TaskScheduleBoard/TaskDeal/RecieveTask",
                        data: { taskId: data.Id },
                        success: function (data) {
                            if (data.data)
                                layer.msg("任务领取成功!", { icon: 6, shift: -1, time: 1000 }, function () {
                                    LoadPage();
                                    $('#taskPoolToolPanl').css("display", "none");
                                });
                            else if (data.code === 1) {
                                layer.msg(data.msg, { icon: 5, shift: -1, time: 1000 }, function () {
                                    LoadPage();
                                    $('#taskPoolToolPanl').css("display", "none");
                                });
                            } else {
                                layer.msg(data.msg, { icon: 5, shift: -1, time: 1000 });
                            }
                        }
                    });
                });
            } else if (obj.event === 'showTaskPartner') {
                taskParner(data.Id);
            } else if (obj.event === 'changeTask') {
                changeTask(data);
            } else if (obj.event === 'removeTask') {
                removeTask(data.Id);
            }
            else if (obj.event === 'addSubTask') {
                addSubTask(data.Id);
            }
        });

    });

}