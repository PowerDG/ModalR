var finishTaskTableCols = [
    { field: 'Index', width: 60, title: '序号', align: 'center' }
    //{ tpye: 'numbers', width: 60, title: '序号', align: 'center' }
    //,{ field: 'Id', width: 70, title: '序号', sort: true }
    , { field: 'Name', title: '名称' }
    , { field: 'Score', width: 60, title: '分数', align: 'center' }
    , { field: 'Status', width: 80, title: '状态', align: 'center'}
    , { field: 'MemberName', width: 80, title: '负责人', align: 'center'}
    , { field: 'ScoreApportioned', width: 90, templet: '#ScoreApportioned', title: '分值分配', align: 'center'}
    //, { field: 'StartTime', width: 160, title: '开始时间', templet: '#finishTaskStartTime', sort: true }
    , { field: 'EndTime', width: 280, title: '结束时间', templet: '#finishTaskEndTime' }
];

var finishTaskTableSortData = { field: "EndTime", type: "DESC" };

function loadFinishTaskTableData() {
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
                elem: '#finishTaskTable',
                method: 'post',
                url: '/TaskScheduleBoard/TaskSchedule/GetTaskOverData',
                //limit: limitPage === undefined ? 10 : limitPage,
                //limits: [10, 20, 30, 100, 200, 500],
                //page: true,
                cols: [finishTaskTableCols],
                where: {
                    sortField: finishTaskTableSortData.field,
                    sortType: finishTaskTableSortData.type
                },
                done: function (res) {
                    layer.closeAll('loading');
                    setTableIndex("finishTaskContent");
                    //setPageTableIndex("finishTaskContent");
                    setSortStyle("finishTaskTable", finishTaskTableSortData);
                    $('#finishTaskContentCount').html(res.count);
                }
            });
        };

        renderTable();


        //监听工具条
        table.on('tool(finishTaskTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'showDetail') {
                showTaskDetail(data.Id, data.Status, layer);
            } else if (obj.event === 'communicationFinishTask') {
                taskCommunication(data.Id, data.Status);
            } else if (obj.event === 'fabulousTask') {
                var taskId = data.Id;
                var fabulousType = $('#finishTaskFabulousImg_' + taskId).attr("src") === "/images/PromptImg/Like.png";
                var fabulousCount = $('#finishTaskFabulousSpan_' + taskId).html();
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: "/TaskScheduleBoard/TaskCommunication/SetFabulousTask",
                    data: { taskId: taskId, fabulousType: fabulousType },
                    success: function (data) {
                        $("#finishTaskFabulousImg_" + taskId).attr("src", fabulousType ? "/images/PromptImg/LikeChoosed.png"
                            : "/images/PromptImg/Like.png");
                        $("#finishTaskFabulousSpan_" + taskId).html(fabulousType ? parseInt(fabulousCount) + 1 : parseInt(fabulousCount) - 1);
                    }
                });
            } else if (obj.event === 'TaskScoreApportione') {
                var index = layer.open({
                    type: 2,
                    title: "分配分值",
                    area: ['800px', ''],
                    shadeClose: true,
                    async: false,
                    id: 'taskScoreApportioneLayer',
                    content: "/TaskScheduleBoard/TaskPartner/TaskScoreApportione?taskId=" + data.Id + '&scoreStatus=' + data.ScoreApportioned
                        + '&taskScore=' + data.Score + '&taskName=' + escape(data.Name),
                    end: function () {
                        loadFinishTaskTableData();
                        setScrollPositon();
                    }
                });
            } else if (obj.event === 'showTaskPartner') {
                taskParner(data.Id);
            }
        });

    });

}

//var limitPage;
//$('#finishTaskContent').change(function (e) {
//    limitPage = $(e.target).find('option:selected').attr('value');
//});