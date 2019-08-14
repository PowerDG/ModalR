layui.use(['element', 'form', 'table'], function () {
    var form = layui.form
        , element = layui.element
        , table = layui.table;

    var taskStatusArray = ["未开始", "研究", "实施", "测试", "上线", "完成"];
    table.render({
        elem: '#taskTable'
        , id: 'taskTable'
        , url: '/TaskScheduleBoard/Plan/GetNotRelateTask'
        , page: true
        , defaultToolbar: []
        , cols: [[
            { type: 'checkbox' }
            , { type: 'numbers', title: '编号', width: 50 }
            , { field: 'taskName', title: '名称' }
            , {
                field: 'taskStatus', title: '状态', width: 80, templet: function (d) {
                    var style = getTaskStatusColumnStyle(d.taskStatus, d.deadLineTime, taskStatusArray);
                    return '<div class="layui-btn layui-btn-xs" style="cursor: default;color: #000;' + style + '">' + d.taskStatus + '</div>';
                }
            }
        ]]
    });

    $('#saveRelateTask').on('click', function () {
        var checkStatus = table.checkStatus('taskTable')
            , data = checkStatus.data;
        var tasksId = '';
        for (var i = 0; i < data.length; i++) {
            tasksId += data[i].Id + ',';
        }
        tasksId = tasksId.trim(',');
        if (tasksId === '') {
            layer.msg('请选择要关联的任务');
        }
        else {
            $.ajax({
                url: '/TaskScheduleBoard/Plan/SetRelateTaskByPlanId?planId=' + $('#planId').attr('data-planId') + '&tasksId=' + tasksId,
                success: function (d) {
                    if (d.result) {
                        parent.layer.msg('关联成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                            function () { parent.layer.closeAll(); });
                    }
                    else {
                        parent.layer.msg(d.message, { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                            function () { parent.layer.closeAll(); });
                    }
                }
            });
        }
    });
});

String.prototype.trim = function (char, type) {
    if (char) {
        if (type == 'left') {
            return this.replace(new RegExp('^\\' + char + '+', 'g'), '');
        } else if (type == 'right') {
            return this.replace(new RegExp('\\' + char + '+$', 'g'), '');
        }
        return this.replace(new RegExp('^\\' + char + '+|\\' + char + '+$', 'g'), '');
    }
    return this.replace(/^\s+|\s+$/g, '');
};

function getTaskStatusColumnStyle(taskStatus, taskDeadLineTime, taskStatusArray) {
    var style;
    switch (taskStatus) {
        case taskStatusArray[0]:
            style = 'background-color: #FFCC99;';
            break;
        case taskStatusArray[1]:
        case taskStatusArray[2]:
        case taskStatusArray[3]:
        case taskStatusArray[4]:
            var deadLineTime = new Date(Date.parse(taskDeadLineTime));
            var now = new Date();
            var after15 = new Date(now.setDate(now.getDate() + 15));
            console.log(deadLineTime, new Date(), after15);

            if (deadLineTime < (new Date())) {
                style = 'background-color: #FF6666;';
            }
            else if (deadLineTime < after15) {
                style = 'background-color: #9999FF;';
            }
            else {
                style = 'background-color: #CCCCFF;';
            }
            break;
        case taskStatusArray[5]:
            style = 'background-color: #66CCCC;';
            break;
        default:
            style = 'background-color: #EEEEEE;';
            break;
    }
    return style;
}