var teamDoingTableCols = [
    { field: 'Index', width: 60, title: '序号', align: 'center'}
    //,{ field: 'Id', width: 70, title: '序号', sort: true }
    , { field: 'Name', title: '名称' }
    , { field: 'Score', width: 60, title: '分数', align: 'center'}
    , { field: 'Status', width: 80, title: '状态', align: 'center'}
    , { field: 'MemberName', width: 80, title: '负责人', align: 'center'}
    , { field: 'LastUpdateTime', width: 280, title: '更新时间', templet: '#teamDoingTableLastUpdateTime'}
];

var teamDoingSortData = { field: "StartTime", type: "" };

function loadTeamDoingData() {
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
                elem: '#teamDoingTable',
                url: '/TaskScheduleBoard/TaskSchedule/GetTeamDoingTaskData',
                page: false,
                cols: [teamDoingTableCols],
                where: {
                    sortField: teamDoingSortData.field,
                    sortType: teamDoingSortData.type
                },
                done: function (res) {
                    layer.closeAll('loading');
                    setTableIndex("teamDoingContent");
                    setSortStyle("teamDoingTable", teamDoingSortData);
                    $('#teamDoingTaskContentCount').html(res.data === null ? 0 : res.data.length);
                }
            });
        };

        renderTable();


        //监听工具条
        table.on('tool(teamDoingTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'showDetail') {
                showTaskDetail(data.Id, data.Status, layer, function () { LoadPage(); });
            } else if (obj.event === 'communicationTask') {
                taskCommunication(data.Id, data.Status, function () { LoadPage(); });
            } else if (obj.event === 'showTaskPartner') {
                taskParner(data.Id);
            } else if (obj.event === 'changeTask') {
                changeTask(data.Id);
            } else if (obj.event === 'removeTask') {
                removeTask(data.Id);
            }
        });

    });

}