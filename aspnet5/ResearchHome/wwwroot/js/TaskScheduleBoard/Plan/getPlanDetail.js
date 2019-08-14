layui.use(['element', 'form', 'layer', 'table', 'util'], function () {
    var form = layui.form
        , layer = layui.layer
        , element = layui.element
        , table = layui.table
        , util = layui.util;

    $('.layui-fixbar').remove();
    util.fixbar({
        bar1: '&#xe65c'
        , bgcolor: '#009688'
        , css: { right: 15, bottom: 30 }
        , click: function (type) {
            if (type === 'bar1') {
                (goBackClick.pop())();
            }
        }
    });

    if ($('#isAdmin').attr('data-isadmin') != '1') {
        $('#planStatus').attr('disabled', 'disabled');
        $('#planName').attr('disabled', 'disabled');
        $('#remark').attr('disabled', 'disabled');
        $('#savePlan').css('display', 'none');
        form.render();
    }

    SelectBind("GetPlanStatus", "planStatus", "StatusId", "StatusName", $('#tempPlanStatus').val(), "150px", form);

    form.on('submit(savePlan)', function (data) {
        $.post("/TaskScheduleBoard/Plan/SavePlan", data.field, function (d) {
            if (d.result) {
                layer.msg('保存成功!', { icon: 6, shift: -1, time: 1000, shade: 0.3 });
                $("#closedTime").text('关闭时间：' + toDateString(d.plan.ClosedTime, 'YYYY-MM-DD HH:mm:ss'));
                if (d.plan.Status === '关闭') {
                    $('#planStatus').attr('disabled', 'disabled');
                    $('#planName').attr('disabled', 'disabled');
                    $('#remark').attr('disabled', 'disabled');
                    $('#savePlan').css('display', 'none');
                    form.render();
                }
            }
            else {
                layer.msg(d.message, { icon: 5, shift: -1, time: 1000 });
            }
        });

        return false;
    });

    var taskStatusArray = ["未开始", "研究", "实施", "测试", "上线", "完成"];
    table.render({
        elem: '#taskTable'
        , id: 'taskTable'
        , url: '/TaskScheduleBoard/Plan/GetTasksByPlanId'//数据接口
        , where: {
            planId: $('input[name=planId]').val()
        }
        , page: true
        , toolbar: '#taskTableToolbar'
        , defaultToolbar: []
        , cols: [[
            { type: 'numbers', title: '编号', width: 50 }
            , {
                field: 'taskName', title: '名称', templet: function (d) {
                    return '<a class="taskNameColumn" data-taskid="' + d.taskId + '">' + d.taskName + '</a>';
                }
            }
            , {
                field: 'taskStatus', title: '状态', width: 80, templet: function (d) {
                    var style = getTaskStatusColumnStyle(d.taskStatus, d.deadLineTime, taskStatusArray);
                    return '<div class="layui-btn layui-btn-xs" style="cursor: default;color: #000;' + style + '">' + d.taskStatus + '</div>';
                }
            }
            , {
                field: 'members', title: '参与人', width: 180, templet: function (d) {
                    //在单元格里放入成员图片
                    var memberDiv = $('<div></div>');
                    for (var i = 0; i < d.members.length; i++) {
                        var imgClick = '$(".layui-table-tips").remove();pageToUrl("nagiveBar_introduction", "/introduction/member/memberrecord?id=' + d.members[i].memberId + '");';
                        var picDiv = $('<img style="width:36px;heigh:36px;cursor:pointer" src="' + d.members[i].photo + '"></img>');
                        picDiv.attr('onclick', imgClick);
                        memberDiv.append(picDiv);
                    }
                    return memberDiv.html();
                }
            }
            , {
                field: 'createdTime', title: '创建时间', width: 105, templet: function (d) {
                    //return moment(d.createdTime);
                    console.log(toDateString(d.createdTime, 'YYYY-MM-DD'));
                    return toDateString(d.createdTime, 'YYYY-MM-DD') 
                }//toDateString(d.createdTime, 'YYYY-MM-DD') }
            }
            , {
                field: 'endTime', title: '关闭时间', width: 105, templet: function (d) { return toDateString(d.endTime, 'YYYY-MM-DD') }
             }
            , {
                field: 'tracks', title: '最后一天跟进', templet: function (d) {
                    var tracksDiv = $('<div></div>');
                    for (var i = 0; i < d.tracks.length; i++) {
                        var singleTrackDiv = $('<p>' + d.tracks[i] + '</p>');
                        tracksDiv.append(singleTrackDiv);
                    }
                    return tracksDiv.html();
                }
            }
            , { field: 'toolUnit', title: '操作', width: 96, toolbar: '#taskToolUnitTemplet' }
        ]]
        , done: function () {
            $('.layui-table tbody a[data-taskid]').on('click', function () {
                var taskId = $(this).data('taskid');
                var planId = $('input[name=planId]').val();
                goBackClick.push(function () {
                    pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/Plan/GetPlanDetail?planId=' + planId);
                });
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/GetTaskDetail?taskId=' + taskId);
            });
        }
    });

    table.on('toolbar(taskTable)', function (obj) {
        if (obj.event === "createTask") {
            layer.open({
                type: 2,
                title: "添加任务",
                resize: false,
                area: ['616px', '550px'],
                shadeClose: true,
                async: false,
                content: '/TaskScheduleBoard/Tasks/CreateTask?planId=' + $('input[name=planId]').val(),
                end: function () {
                    table.reload('taskTable');
                }
            });
        }
        else if (obj.event === "relateTask") {
            layer.open({
                type: 2,
                title: "关联任务",
                resize: false,
                area: ['616px', '570px'],
                shadeClose: true,
                async: false,
                content: '/TaskScheduleBoard/Plan/RelateTask?planId=' + $('input[name=planId]').val(),
                end: function () {
                    table.reload('taskTable');
                }
            });
        }
    });
    table.on('tool(taskTable)', function (obj) {
        var data = obj.data;
        if (obj.event === 'receiveTask') {
            layer.confirm('确定领取该任务?', function (index) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: "/TaskScheduleBoard/Tasks/RecieveTask",
                    data: { taskId: data.taskId },
                    success: function (data) {
                        if (data.result)
                            layer.msg("任务领取成功!", { icon: 6, shift: -1, time: 1000 }, function () {
                                table.reload('taskTable');
                            });
                        else {
                            layer.msg(data.msg, { icon: 5, shift: -1, time: 1000 });
                        }
                    }
                });
            });
        } else if (obj.event === 'reviewTask') {
            goBackClick.push(function () {
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks'
                    , function () {
                        $('#taskView').click();//返回至之前的tab页
                        $('button[lay-event=' + currentButtonEvent + ']').click();//返回至之前的tab中点击的筛选按钮页
                    });
            });
            pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/ReviewTask?taskId=' + data.taskId);
        } else if (obj.event === 'addTrack') {
            trackTask(data.taskId);
        }
        else if (obj.event === 'deleteTask') {
            layer.confirm('确定删除该任务?', function (index) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: "/TaskScheduleBoard/Tasks/DeleteTask",
                    data: { taskId: data.taskId },
                    success: function (data) {
                        if (data.result)
                            layer.msg("任务删除成功!", { icon: 6, shift: -1, time: 1000 }, function () {
                                table.reload('taskTable');
                            });
                        else {
                            layer.msg(data.msg, { icon: 5, shift: -1, time: 1000 });
                        }
                    }
                });
            });
        }
        else if (obj.event === 'removeRelateTask') {
            layer.confirm('确定解除关联该任务?', function (index) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    url: "/TaskScheduleBoard/Plan/RemoveRelateTaskByPlan",
                    data: {
                        taskId: data.taskId, planId: $('input[name=planId]').val()
                    },
                    success: function (data) {
                        if (data.result)
                            layer.msg("任务解除关联成功!", { icon: 6, shift: -1, time: 1000 }, function () {
                                table.reload('taskTable');
                            });
                        else {
                            layer.msg(data.msg, { icon: 5, shift: -1, time: 1000 });
                        }
                    }
                });
            });
        }
    });
});

function trackTask(taskId) {
    layer.open({
        type: 2,
        resize: false,
        title: "任务跟进",
        area: ['545px', '332px'],
        scrollbar: false,
        shadeClose: true,
        content: "/TaskScheduleBoard/Tasks/TrackingTask?taskId=" + taskId,
        end: function () {
            table.reload('taskTable');
        }
    });
}

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