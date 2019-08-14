window.onload = function () {
    loadToolMenuShow();
    loadTaskTracking();
}

function loadTaskTracking() {
    layui.use('laytpl', function () {
        var laytpl = layui.laytpl;
        $.ajax({
            type: "POST",
            dataType: "json",
            url: "/TaskScheduleBoard/TaskDeal/GetTaskTrackings",
            data: { taskId: GetQueryString("taskId") },
            success: function (data) {
                var taskProcessData = document.getElementById('taskProcessData');
                var getTpl = taskProcessData.innerHTML;
                var taskProcess = document.getElementById('taskProcess');
                laytpl(getTpl).render(data, function (html) {
                    taskProcess.innerHTML = html;
                });
            }
        });
    });
}

function loadToolMenuShow() {
    layui.use('laytpl', function () {
        var laytpl = layui.laytpl;
        $.ajax({
            type: "POST",
            dataType: "json",
            url: "/TaskScheduleBoard/TaskDeal/GetTaskTrackingsPersonTask",
            data: { taskId: GetQueryString("taskId") },
            success: function (data) {
                var taskToolMenuMaster = document.getElementById('taskToolMenuMaster');
                var getTpl = taskToolMenuMaster.innerHTML;
                var taskToolMenu = document.getElementById('taskToolMenu');
                laytpl(getTpl).render(data, function (html) {
                    taskToolMenu.innerHTML = html;
                });
            }
        });
    });
}

function trackTask() {
    var index = layer.open({
        type: 2,
        title: "任务跟进",
        area: ['500px', '400px'],
        shadeClose: true,
        async: false,
        content: "/TaskScheduleBoard/TaskDeal/DealTask?taskId=" + GetQueryString("taskId") + "&dealType=" + escape("跟进"),
        end: function () {
            loadTaskTracking();
        }
    });
}

function finishTask() {
    var index = layer.open({
        type: 2,
        title: "任务完成",
        area: ['500px', '250px'],
        shadeClose: true,
        async: false,
        content: "/TaskScheduleBoard/TaskDeal/DealTask?taskId=" + GetQueryString("taskId") + "&dealType=" + escape("完成"),
        end: function () {
            loadToolMenuShow();
            loadTaskTracking();
        }
    });
}