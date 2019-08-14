function showTaskDetail(taskId, taskStatus, showlayer, callBack) {
    var index = showlayer.open({
        type: 2,
        resize: true,
        title: false,
        area: ['600px', '500px'],
        shadeClose: true,
        async: false,
        success: function (layero, index) {
            layero.css("overflow-y","visible");
        },
        content: '/TaskScheduleBoard/TaskDeal/TaskProcess?taskId=' + taskId,
        end: function () {
            if (callBack !== undefined)
                callBack();
        }
    });
}