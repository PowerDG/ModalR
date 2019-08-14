function LoadPage() {
    loadTeamDoingData();
    loadMyTaskData();
    loadTaskPoolData();
    loadFinishTaskTableData();
    setScrollPositon();
    $(document).on('click', '.layui-table>tbody>tr', function () {
        $('.layui-table>tbody>tr').removeClass("tableClick");
        $('.layui-table>tbody>tr').removeClass("layui-table-click");
        $('.layui-table>tbody>tr').css("background-color", "");
        $($('.layui-table').find('.layui-table-hover')[0]).addClass("tableClick").siblings().removeClass("tableClick");
        $($('.layui-table').find('.layui-table-hover')[0]).css("background-color", "lightgreen");
    });
    $(document).on('mouseenter', '.layui-table>tbody>tr', function (event) {
        $(this).find('.toolPanl').css("display", "block");
    }).on('mouseleave', '.layui-table>tbody>tr', function (event) {
        $(this).find('.toolPanl').css("display", "none");
    });
}

function addTask(callBack) {
    var index = layer.open({
        type: 2,
        title: "新增任务",
        resize: false,
        area: ['500px', '680px'],
        shadeClose: true,
        async: false,
        content: '/TaskScheduleBoard/TaskSchedule/OptionsTask?optionTaskType=add',
        end: function () {
            loadTaskPoolData();
            if (callBack !== undefined)
                callBack();
        }
    });
}

function addSubTask(parentTaskId,callBack) {
    var index = layer.open({
        type: 2,
        title: "新增子任务",
        resize: false,
        area: ['500px', '680px'],
        shadeClose: true,
        async: false,
        content: '/TaskScheduleBoard/TaskSchedule/OptionsTask?optionTaskType=add&parentTaskId=' + parentTaskId,
        end: function () {
            loadTaskPoolData();
            if (callBack !== undefined)
                callBack();
        }
    });
}

function changeTask(data, callBack) {
    var index = layer.open({
        type: 2,
        title: "修改任务",
        resize: true,
        area: ['500px', '600px'],
        shadeClose: true,
        async: false,
        content: '/TaskScheduleBoard/TaskSchedule/OptionsTask?optionTaskType=edit&taskId=' + data.Id + '&parentTaskId=' + data.ParentId,
        end: function () {
            LoadPage();
            if (callBack !== undefined)
                callBack();
        }
    });
}

function removeTask(taskId, callBack) {
    var index = layer.open({
        type: 2,
        title: "任务作废",
        area: ['500px', '250px'],
        shadeClose: true,
        async: false,
        content: "/TaskScheduleBoard/TaskDeal/DealTask?taskId=" + taskId
            + "&dealType=" + escape("作废"),
        end: function () {
            LoadPage();
            if (callBack !== undefined)
                callBack();
        }
    });
}

function taskCommunication(taskId, taskStatus, callBack) {
    var index = layer.open({
        type: 2,
        title: "任务交流",
        area: ['650px', '90%'],
        shadeClose: true,
        async: false,
        content: "/TaskScheduleBoard/TaskCommunication/Index?taskId=" + taskId
            + "&taskStatus=" + escape(taskStatus),
        end: function () {
            if (callBack !== undefined)
                callBack();
        }
    });
}

function taskParner(taskId, callBack) {
    var index = layer.open({
        type: 2,
        title: "任务参与者",
        area: ['700px', '600px'],
        shadeClose: true,
        async: false,
        resize: false,
        content: "/TaskScheduleBoard/TaskPartner/TaskPartner?taskId=" + taskId,
        end: function () {
            if (callBack !== undefined)
                callBack();
        }
    });
}