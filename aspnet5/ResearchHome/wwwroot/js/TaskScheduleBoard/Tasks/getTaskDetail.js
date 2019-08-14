var switchMyTodos = false;
var switchEffectiveTodos = false;
var onlyMyTracks = false;

layui.config({
    base: '/lib/layui/lay/extends/'
});
layui.use(['form', 'selectM', 'layer', 'laypage', 'laytpl', 'util', 'laydate'], function () {
    var form = layui.form,
        selectM = layui.selectM,
        layer = layui.layer,
        laypage = layui.laypage,
        laytpl = layui.laytpl,
        util = layui.util,
        laydate = layui.laydate;

    var taskId = $('#taskId').attr('data-taskid');
    //---------------任务详情----------------------------------
    SelectBind("GetMembersList", "principal", "Id", "Name", $('#principalId').attr('data-principalid'), "150px", form);
    SelectBind("GetTaskStatus", "taskStatus", "statusId", "statusName", $('#status').attr('data-status'), "150px", form);
    SelectBind("GetTaskPriority", "taskPriority", "id", "name", $('#priority').attr('data-priority'), "150px", form);

    laydate.render({
        elem: '#deadLineTime'
        , value: $('#deadline').attr('data-deadline')
    });

    var participants = eval("([" + $('#participantArry').attr('data-participantarry') + "])");
    var participant = selectM({
        elem: '#participants'
        , data: '/Select/GetMembersList'
        , selected: participants                                
        , max: 6
        , tips: '请选择'
        //input的name 不设置与选择器相同(去#.)
        //, name: 'participant'
        //值的分隔符
        , delimiter: ','
        //候选项数据的键名
        , field: { idName: 'Id', titleName: 'Name' }
    });

    if ($('#status').attr('data-status') === '关闭') {
        disabledHtmlTag();
        $('#addTaskTrack').css('display', 'none');
        $('#addFeedback').css('display', 'none');

    }
    else if ($('#canEdit').attr('data-canedit') === '0') {
        disabledHtmlTag();
    }

    var isStatusOK = $('#status').attr('data-status') === '关闭' || $('#status').attr('data-status') === '完成';
    var isCurrentUserOK = $('#isAdmin').attr('data-isadmin') === '1' || ($('#isReview').attr('data-isreview') === '1');
    if (isStatusOK && isCurrentUserOK) {
        $('#reviewTask').parent().css('display', 'block');
        $('#reviewTask').click(function () {
            goBackClick.push(function () {
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/GetTaskDetail?taskId=' + taskId);
            });
            pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/ReviewTask?taskId=' + taskId);
        });
    }

    form.on('submit(saveTask)', function (data) {
        $.ajax({
            url: '/TaskScheduleBoard/Tasks/SaveTask?taskId=' + taskId,
            method: 'post',
            data: data.field,
            success: function (d) {
                if (d.result) {
                    layer.msg('保存成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 });
                    if (data.field['taskStatus'] === '关闭') {
                        disabledHtmlTag();
                    }
                    if (data.field['taskStatus'] === '关闭' || data.field['taskStatus'] === '完成') {
                        $('#reviewTask').parent().css('display', 'block');
                        $('#reviewTask').click(function () {
                            goBackClick.push(function () {
                                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/GetTaskDetail?taskId=' + taskId);
                            });
                            pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/ReviewTask?taskId=' + taskId);
                        });
                    }
                    loadTaskTracking(laytpl, laypage, onlyMyTracks);
                }
                else {
                    layer.msg(d.message, { icon: 5, shift: -1, time: 1500, shade: 0.3 });
                }
            }
        });
        return false;
    });

    //---------------跟进------------------------------------------
    form.on('switch(switchTrackings)', function (data) {
        onlyMyTracks = data.elem.checked;
        loadTaskTracking(laytpl, laypage, onlyMyTracks);
    });

    $('#addTaskTrack').click(function () {
        trackTask(laytpl, laypage, onlyMyTracks);
    }); 
    $('#addFeedback').click(function () {
        trackTaskFeedback(laytpl, laypage);
    });
    loadTaskTracking(laytpl, laypage, onlyMyTracks);
    loadTaskFeedBack(laytpl, laypage);

    //---------------Todos------------------------------------------
    $('#addTodo').click(function () {
        layer.open({
            type: 2,
            title: '添加Todo',
            resize: false,
            area: ['649px', '446px'],
            scrollbar: false,
            shadeClose: true,
            //async: false,
            content: '/TaskScheduleBoard/Todo/CreateTodo?taskId=' + taskId,
            end: function () {
                loadTodosSummary();
                loadTaskTodos(form, laytpl, laypage, switchMyTodos, switchEffectiveTodos);
                loadTaskTracking(laytpl, laypage, onlyMyTracks);
            }
        });
    });

    form.on('switch(switchMyTodos)', function (data) {
        switchMyTodos = data.elem.checked;
        loadTaskTodos(form, laytpl, laypage, switchMyTodos, switchEffectiveTodos);
    });
    form.on('switch(switchEffectiveTodos)', function (data) {
        switchEffectiveTodos = data.elem.checked;
        loadTaskTodos(form, laytpl, laypage, switchMyTodos, switchEffectiveTodos);
    });
    loadTodosSummary();
    loadTaskTodos(form, laytpl, laypage, false, false);

    //---------------关键结果------------------------------------------
    $('#addKeyResult').click(function () {
        layer.open({
            type: 2,
            title: '添加关键结果',
            resize: false,
            area: ['649px', '446px'],
            scrollbar: false,
            shadeClose: true,
            //async: false,
            content: '/TaskScheduleBoard/KeyResult/CreateKeyResult?taskId=' + taskId,
            end: function () {
                loadKeyResultsSummary();
                loadTaskKeyResults(form, laytpl, laypage);
                loadTaskTracking(laytpl, laypage, onlyMyTracks);
            }
        });
    });

    loadKeyResultsSummary();
    loadTaskKeyResults(form, laytpl, laypage);

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
});

function loadTaskFeedBack(laytpl, laypage) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/TaskFeedback/GetTaskFeedBackCount",
        data: { taskId: $('#taskId').attr('data-taskid')},
        success: function (data) {
            var count = data.feedbackCount;
            laypage.render({
                elem: 'feedBackPaging'
                , count: count
                , limit: 5
                , groups: 2
                , layout: ['prev', 'page', 'next', 'count']
                , prev: '<i class="layui-icon layui-icon-left"></i>'
                , next: '<i class="layui-icon layui-icon-right"></i>'
                , jump: function (obj) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "/TaskScheduleBoard/TaskFeedback/GetTaskFeedbacks",
                        data: { taskId: $('#taskId').attr('data-taskid'), page: obj.curr, limit: obj.limit },
                        success: function (data) {
                            var taskProcessData = document.getElementById('taskFeedbackData');
                            var getTpl = taskProcessData.innerHTML;
                            var taskProcess = document.getElementById('taskProcessFeedback');
                            laytpl(getTpl).render(data, function (html) {
                                taskProcess.innerHTML = html;
                            });
                        }
                    });
                }
            });
        }
    });
}

function loadTaskTracking(laytpl, laypage, onlyMyTracks) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/Tasks/GetTaskTrackingsCount",
        data: { taskId: $('#taskId').attr('data-taskid'), onlyMy: onlyMyTracks },
        success: function (data) {
            var count = data.trackingsCount;
            laypage.render({
                elem: 'trackPaging'
                , count: count
                , limit: 5
                , groups: 2
                , layout: ['prev', 'page', 'next', 'count']
                , prev: '<i class="layui-icon layui-icon-left"></i>'
                , next: '<i class="layui-icon layui-icon-right"></i>'
                , jump: function (obj) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "/TaskScheduleBoard/Tasks/GetTaskTrackings",
                        data: { taskId: $('#taskId').attr('data-taskid'), onlyMy: onlyMyTracks, page: obj.curr, limit: obj.limit },
                        success: function (data) {
                            var taskProcessData = document.getElementById('taskProcessData');
                            var getTpl = taskProcessData.innerHTML;
                            var taskProcess = document.getElementById('taskProcess');
                            laytpl(getTpl).render(data, function (html) {
                                taskProcess.innerHTML = html;
                            });
                        }
                    });
                }
            });
        }
    });
}

function trackTaskFeedback(laytpl, laypage) {
    layer.open({
        type: 2,
        resize: true,
        title: "添加反馈",
        area: ['550px', '390px'],
        scrollbar: false,
        shadeClose: true,
        async: false,
        content: "/TaskScheduleBoard/TaskFeedback/TrackTaskFeedback?taskId=" + $('#taskId').attr('data-taskid'),
        end: function () {
            loadTaskFeedBack(laytpl, laypage);
        }
    });
}

function trackTask(laytpl, laypage, onlyMyTracks) {
    var index = layer.open({
        type: 2,
        resize: true,
        title: "任务跟进",
        area: ['545px', '332px'],
        scrollbar: false,
        shadeClose: true,
        async: false,
        content: "/TaskScheduleBoard/Tasks/TrackingTask?taskId=" + $('#taskId').attr('data-taskid'),
        end: function () {
            loadTaskTracking(laytpl, laypage, onlyMyTracks);
        }
    });
}
function loadTodosSummary() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/Todo/GetTaskTodosSummary",
        data: { taskId: $('#taskId').attr('data-taskid') },
        success: function (data) {
            $('#todosSummary').html('共' + data.todosTotalCount + '个 完成' + data.todosCompleteCount + '个');
        }
    });
}
function loadTaskTodos(form, laytpl, laypage, onlyMy, onlyEffective) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/Todo/GetTaskTodosCount",
        data: { taskId: $('#taskId').attr('data-taskid'), onlyMy: onlyMy, onlyEffective: onlyEffective },
        success: function (data) {
            var count = data.todosCount;
            laypage.render({
                elem: 'todoPaging'
                , count: count
                , limit: 20
                , groups: 2
                , layout: ['prev', 'page', 'next']
                , prev: '<i class="layui-icon layui-icon-left"></i>'
                , next: '<i class="layui-icon layui-icon-right"></i>'
                , jump: function (obj) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "/TaskScheduleBoard/Todo/GetTaskTodos",
                        data: {
                            taskId: $('#taskId').attr('data-taskid'), onlyMy: onlyMy, onlyEffective: onlyEffective,
                            page: obj.curr, limit: obj.limit
                        },
                        success: function (data) { 
                            var taskTodoList = document.getElementById('taskTodoList');
                            var getTpl = taskTodoList.innerHTML;
                            var taskTodos = document.getElementById('taskTodos');
                            laytpl(getTpl).render(data, function (html) {
                                taskTodos.innerHTML = html;
                            });
                            form.render();

                            form.on('checkbox(completeTodo)', function (data) {
                                var currentCheckbox = data.elem;
                                if ($('#canEdit').attr('data-canedit') === '0') {
                                    $(currentCheckbox).removeAttr('checked');
                                    form.render('checkbox');
                                    return;
                                }
                                layer.open({
                                    content: '确定关闭该TODO吗？', icon: 3, title: '提示'
                                    , btn: ['确定', '取消']
                                    , yes: function (index) {
                                        $.ajax({
                                            type: "POST",
                                            dataType: "json",
                                            url: "/TaskScheduleBoard/Todo/FinishTodo",
                                            data: { todoId: $(currentCheckbox).attr('data-todoid') },
                                            success: function (data) {
                                                if (data.result) {
                                                    loadTodosSummary();
                                                    loadTaskTodos(form, laytpl, laypage, onlyMy, onlyEffective);
                                                    loadTaskTracking(laytpl, laypage, onlyMy);
                                                }
                                            }
                                        });
                                        layer.close(index);
                                    }
                                    , btn2: function (index) {
                                        $(currentCheckbox).removeAttr('checked');
                                        layer.close(index);
                                        form.render('checkbox');
                                    }
                                    , cancel: function (index) {
                                        $(currentCheckbox).removeAttr('checked');
                                        layer.close(index);
                                        form.render('checkbox');
                                    }
                                });
                            });
                        }
                    });
                }
            });
        }
    });
}

function disabledHtmlTag() {
    $('#taskName').attr('disabled', 'disabled');
    $('#taskStatus').attr('disabled', 'disabled');
    $('#taskPriority').attr('disabled', 'disabled');
    $('#principal').attr('disabled', 'disabled');
    $("#participants").unbind();
    $('#taskRemark').attr('disabled', 'disabled');
    $('#deadLineTime').attr('disabled', 'disabled');

    $('#saveTask').css('display', 'none');
    $('#addKeyResult').css('display', 'none');
    //$('#addTaskTrack').css('display', 'none');
    $('#addTodo').css('display', 'none');
}

function editTodo(currentButton) {
    var todoId = $(currentButton).attr('data-todoid');
    layer.open({
        type: 2,
        title: '修改Todo',
        resize: true,
        area: ['577px', '499px'],
        scrollbar: false,
        shadeClose: true,
        //async: false,
        content: '/TaskScheduleBoard/Todo/EditTodo?type=edit&todoId=' + todoId,
        end: function () {
            loadTodosSummary();
            loadTaskTodos(layui.form, layui.laytpl, layui.laypage, switchMyTodos, switchEffectiveTodos);
            loadTaskTracking(layui.laytpl, layui.laypage, onlyMyTracks);
        }
    });
}

function viewTodo(currentButton) {
    var todoId = $(currentButton).attr('data-todoid');
    layer.open({
        type: 2,
        title: '查看Todo',
        resize: true,
        area: ['577px', '453px'],
        scrollbar: false,
        shadeClose: true,
        content: '/TaskScheduleBoard/Todo/EditTodo?type=view&todoId=' + todoId
    });
}

function deleteTodo(currentButton) {
    var todoId = $(currentButton).attr('data-todoid');
    layer.confirm('确定删除该Todo吗？', { icon: 3, title: '提示' }, function (index) {
        $.ajax({
            url: '/TaskScheduleBoard/Todo/DeleteTodo'
            , type: 'post'
            , async: false
            , data: { todoId: todoId }
            , success: function (d) {
                if (d.result) {
                    parent.layer.msg('删除成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                        function () { parent.layer.closeAll(); });
                    loadTodosSummary();
                    loadTaskTodos(layui.form, layui.laytpl, layui.laypage, switchMyTodos, switchEffectiveTodos);
                    loadTaskTracking(layui.laytpl, layui.laypage, onlyMyTracks);
                }
                else {
                    parent.layer.msg(d.message, { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                        function () { parent.layer.closeAll(); });
                }
            }
        });
    });
}
function loadKeyResultsSummary() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/KeyResult/GetTaskKeyResultsSummary",
        data: { taskId: $('#taskId').attr('data-taskid') },
        success: function (data) {
            $('#keyResultsSummary').html('共' + data.keyResultsTotalCount + '个 完成' + data.keyResultsClosedCount + '个');
        }
    });
}
function loadTaskKeyResults(form, laytpl, laypage) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/KeyResult/GetTaskKeyResultsCount",
        data: { taskId: $('#taskId').attr('data-taskid') },
        success: function (data) {
            var count = data.keyResultsCount;
            laypage.render({
                elem: 'keyResultPaging'
                , count: count
                , limit: 15
                , layout: ['prev', 'page', 'next', 'count']
                , prev: '<i class="layui-icon layui-icon-left"></i>'
                , next: '<i class="layui-icon layui-icon-right"></i>'
                , jump: function (obj) {
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "/TaskScheduleBoard/KeyResult/GetTaskKeyResults",
                        data: { taskId: $('#taskId').attr('data-taskid'), page: obj.curr, limit: obj.limit },
                        success: function (data) {
                            var taskKeyResultsList = document.getElementById('taskKeyResultsList');
                            var getTpl = taskKeyResultsList.innerHTML;
                            var taskKeyResults = document.getElementById('taskKeyResults');
                            laytpl(getTpl).render(data, function (html) {
                                taskKeyResults.innerHTML = html;
                            });
                            form.render();

                            form.on('checkbox(closeKeyResult)', function (data) {
                                var currentCheckbox = data.elem;
                                if ($('#canEdit').attr('data-canedit') === '0') {
                                    $(currentCheckbox).removeAttr('checked');
                                    form.render('checkbox');
                                    return;
                                }
                                layer.open({
                                    content: '确定关闭该关键结果吗？', icon: 3, title: '提示'
                                    , btn: ['确定', '取消']
                                    , yes: function (index) {
                                        $.ajax({
                                            type: "POST",
                                            dataType: "json",
                                            url: "/TaskScheduleBoard/KeyResult/CloseKeyResult",
                                            data: { keyResultId: $(currentCheckbox).attr('data-keyresultid') },
                                            success: function (data) {
                                                if (data.result) {
                                                    loadKeyResultsSummary();
                                                    loadTaskKeyResults(form, laytpl, laypage);
                                                    loadTaskTracking(laytpl, laypage, onlyMyTracks);
                                                }
                                            }
                                        });
                                        layer.close(index);
                                    }
                                    , btn2: function (index) {
                                        $(currentCheckbox).removeAttr('checked');
                                        layer.close(index);
                                        form.render('checkbox');
                                    }
                                    , cancel: function (index) {
                                        $(currentCheckbox).removeAttr('checked');
                                        layer.close(index);
                                        form.render('checkbox');
                                    }
                                });
                            });
                        }
                    });
                }
            });
        }
    });
}

function editKeyResult(currentButton) {
    var keyResultId = $(currentButton).attr('data-keyresultid');
    layer.open({
        type: 2,
        title: '修改关键结果',
        resize: false,
        area: ['577px', '499px'],
        shadeClose: true,
        scrollbar: false,
        content: '/TaskScheduleBoard/KeyResult/EditKeyResult?type=edit&keyResultId=' + keyResultId,
        end: function () {
            loadKeyResultsSummary();
            loadTaskKeyResults(layui.form, layui.laytpl, layui.laypage);
            loadTaskTracking(layui.laytpl, layui.laypage, onlyMyTracks);
        }
    });
}

function viewKeyResult(currentButton) {
    var keyResultId = $(currentButton).attr('data-keyresultid');
    layer.open({
        type: 2,
        title: '查看关键结果',
        resize: false,
        area: ['577px', '453px'],
        shadeClose: true,
        scrollbar: false,
        content: '/TaskScheduleBoard/KeyResult/EditKeyResult?type=view&keyResultId=' + keyResultId
    });
}

function deleteKeyResult(currentButton) {
    var keyResultId = $(currentButton).attr('data-keyresultid');
    layer.confirm('确定删除该关键结果吗？', { icon: 3, title: '提示' }, function (index) {
        $.ajax({
            url: '/TaskScheduleBoard/KeyResult/DeleteKeyResult'
            , type: 'post'
            , async: false
            , data: { keyResultId: keyResultId }
            , success: function (d) {
                if (d.result) {
                    parent.layer.msg('删除成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                        function () { parent.layer.closeAll(); });
                    loadKeyResultsSummary();
                    loadTaskKeyResults(layui.form, layui.laytpl, layui.laypage);
                    loadTaskTracking(layui.laytpl, layui.laypage, onlyMyTracks);
                }
                else {
                    parent.layer.msg(d.message, { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                        function () { parent.layer.closeAll(); });
                }
            }
        });
    });
}