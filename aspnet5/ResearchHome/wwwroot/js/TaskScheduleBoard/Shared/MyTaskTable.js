var myTaskTableCols = [
    { field: 'Index', width: 60, title: '序号', align: 'center'}
    //,{ field: 'Id', width: 70, title: '序号', sort: true }
    , { field: 'Name', title: '名称', toolbar: '#nameTips'}
    , { field: 'Score', width: 60, title: '分数',  align: 'center'}
    , { field: 'Status', width: 80, title: '状态', align: 'center'}
    , { field: 'MemberName', width: 80, title: '负责人', align: 'center' }
    , { field: 'LastUpdateTime', width: 280, title: '更新时间', templet: '#myTaskLastUpdateTime'}
];

var myTaskTableSortData = { field: "StartTime", type: "DESC" };

function loadMyTaskData() {
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#myTaskTable'
            , url: '/TaskScheduleBoard/TaskSchedule/GetMyTaskData'
            , height: 'full'
            , method: 'post'
            , page: false
            //, async: false
            , cols: [myTaskTableCols]
            , where: {
                sortField: myTaskTableSortData.field,
                sortType: myTaskTableSortData.type
            }
            , done: function (res) {
                setTableIndex("myTaskContent");
                setSortStyle("myTaskTable", myTaskTableSortData);
                $('#myTaskContentCount').html(res.data === null ? 0 : res.data.length);
            }
        });

        //排序事件
        table.on('sort(myTaskTableFilter)', function (data) {
            myTaskTableSortData = data;
            loadMyTaskData();
            setScrollPositon();
        });

        //监听工具条
        table.on('tool(myTaskTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'showDetail') {
                showTaskDetail(data.Id, data.Status, layer, function () { LoadPage(); });
            } else if (obj.event === 'trackTask') {
                var index = layer.open({
                    type: 2,
                    title: "任务跟进",
                    area: ['500px', '400px'],
                    shadeClose: true,
                    async: false,
                    content: "/TaskScheduleBoard/TaskDeal/DealTask?taskId=" + data.Id + "&dealType=" + escape("跟进"),
                    end: function () {
                        loadMyTaskData();
                        loadTeamDoingData();
                    }
                });
            } else if (obj.event === 'showTaskPartner') {
                taskParner(data.Id);
            } else if (obj.event === 'finishTask') {
                var index = layer.open({
                    type: 2,
                    title: "任务完成",
                    area: ['500px', '250px'],
                    shadeClose: true,
                    async: false,
                    content: "/TaskScheduleBoard/TaskDeal/DealTask?taskId=" + data.Id + "&dealType=" + escape("完成"),
                    end: function () {
                        //LoadPage();
                        loadMyTaskData();
                        loadTeamDoingData();
                        loadFinishTaskTableData();
                    }
                });
            }
        });
    });
}