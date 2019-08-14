function btnSubmit() {
    var url = "";
    switch (unescape(GetQueryString("dealType"))) {
        case "跟进":
            url = "/TaskScheduleBoard/TaskDeal/TrackingTask";
            break;
        case "完成":
            url = "/TaskScheduleBoard/TaskDeal/FinishTask";
            break;
        case "作废":
            url = "/TaskScheduleBoard/TaskDeal/RemoveTask";
            break;
    }
    $.ajax({
        type: "POST",
        dataType: "json",
        url: url,
        data: { taskId: GetQueryString("taskId"), description: $('#Description').val() },
        success: function (data) {
            if (data.data)
                layer.msg("操作成功!", { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () {
                    parent.layer.closeAll();
                });
            else if (data.code === 1) {
                layer.msg(data.msg, { icon: 5, shift: -1, time: 500 }, function () {
                    parent.LoadPage();
                    parent.layer.closeAll();
                });
            }

            else layer.msg(data.msg, { icon: 5, shift: -1, time: 500, shade: 0.3 });
        }
    });
}