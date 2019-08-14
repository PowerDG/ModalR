var goBackClick = [];

layui.config({
    base: '/js/TaskScheduleBoard/Tasks/'
});
layui.link("/css/TaskScheduleBoard/TaskSchedule/mykanban.css");

layui.use(['mykanban', 'jquery','element', 'table', 'layer', 'util'], function () {
    var mykanban = layui.mykanban;
    var $ = layui.$;
    var element = layui.element;
    var table = layui.table;
    var layer = layui.layer;
    var util = layui.util;

    $('.layui-fixbar').remove();
    util.fixbar({
        bgcolor: '#009688'
        , css: { right: 15, bottom: 30 }
    });

    var taskStatusArray = ["未开始", "研究", "实施", "测试", "上线", "完成"];
    mykanban.init($('.kanban-container'));
    $.ajax({
        url: "/TaskScheduleBoard/Tasks/GetKanbanTasks",
        success: function (data) {
            for (var i = 0; i < taskStatusArray.length; i++) {
                var flag = false;
                for (var j = 0; j < data.length; j++) {
                    if (taskStatusArray[i] == data[j].status) {
                        flag = true;
                        var statusColumn = mykanban.addColumn(data[j].status + " <span style='font-size: 18px;'>" + data[j].taskCount + "</span>");
                        for (var k = 0; k < data[j].cardList.length; k++) {
                            statusColumn.addCard(data[j].cardList[k].taskName, data[j].cardList[k].taskId, data[j].cardList[k].taskColor
                                , data[j].cardList[k].lastTrackTime, data[j].cardList[k].memberImage
                                , data[j].cardList[k].memberId
                                , function (id) {
                                    pageToUrl('nagiveBar_introduction', '/introduction/member/memberrecord?id=' + id);
                                }
                                , function (id) {
                                    goBackClick.push(function () { pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks'); });
                                    pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/GetTaskDetail?taskId=' + id);
                                }
                                , 4 - data[j].cardList[k].taskPriority
                            );
                        }
                    }
                }
                if (flag == false) {
                    mykanban.addColumn(taskStatusArray[i] + " <span style='font-size: 18px;'>0</span>");
                }

                if (i != taskStatusArray.length - 1) {
                    mykanban.addOrientationIcon();
                }
            }

        }
    });
    //任务视图
    var taskTable=table.render({
        elem: '#taskTable'
        , id: 'taskTable'
        , url: '/TaskScheduleBoard/Tasks/GetTasks'
        , toolbar: '#taskTableToolbar'
        , defaultToolbar: []
        , page: true
        , limit: 20
        , cols: [[
            { type: 'numbers', title: '编号', width: 50 }
            , {
                field: 'taskName', title: '名称', templet: function (d) {
                    return '<a class="taskNameColumn" data-taskid="' + d.taskId + '">' + d.taskName + '</a>';
                }
            }
            , {
                field: 'planName', title: '计划', width: 200, templet: function (d) {
                    if (d.planId != null) {
                        return '<div class="planNameColumn" data-planid="' + d.planId + '">' + d.planName + '</div>';
                    }
                    else {
                        return '';
                    }
                }
            }
            , {
                field: 'taskStatus', title: '状态', width: 80, templet: function (d) {
                    var style = getTaskStatusColumnStyle(d.taskStatus, d.deadLineTime, taskStatusArray);
                    return '<div class="layui-btn layui-btn-xs" style="cursor: default;color: #000;' + style + '">' + d.taskStatus + '</div>';
                }
            }
            , {
                field: 'members', title: '参与人', width: 150, templet: function (d) {
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
                field: 'deadLineTime', title: '截止日期', width: 105, templet: function (d) {
                    return toDateString(d.deadLineTime, 'YYYY-MM-DD');
                }
            }
            , { field: 'tracks', title: '最后一天跟进', templet: '#tracksTemplet' }
            , { field: 'toolUnit', title: '操作', width: 80, toolbar: '#taskToolUnitTemplet' }
        ]]
        , done: function () {
            $('#taskTable-tab tbody .taskNameColumn[data-taskid]').on('click', function () {
                var taskId = $(this).data('taskid');
                var currentButtonEvent = $('#taskTable-btn button:not([class~="layui-btn-primary"])').attr('lay-event');
                goBackClick.push(function () {
                    pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks'
                        , function () {
                            $('#taskView').click();//返回至之前的tab页
                            $('button[lay-event=' + currentButtonEvent + ']').click();//返回至之前的tab中点击的筛选按钮页
                        });
                });
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/GetTaskDetail?taskId=' + taskId);
            });
            $('#taskTable-tab tbody .planNameColumn[data-planid]').on('click', function () {
                var planid = $(this).data('planid');
                var currentButtonEvent = $('#taskTable-btn button:not([class~="layui-btn-primary"])').attr('lay-event');
                goBackClick.push(function () {
                    pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks'
                        , function () {
                            $('#taskView').click();//返回至之前的tab页
                            $('button[lay-event=' + currentButtonEvent + ']').click();//返回至之前的tab中点击的筛选按钮页
                        });
                });
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/Plan/GetPlanDetail?planId=' + planid);
            });
        }
    });

    if ($('#memberSelect').length === 1) {
        $.ajax({
            url: '/TaskScheduleBoard/Tasks/GetTaskMember',
            type: 'get',
            success: function (d) {
                for (var index = 0; index < d.data.length; index++) {
                    $('#memberSelect').append(new Option(d.data[index].Name, d.data[index].Id));
                }
                layui.form.render("select");
            }
        });
    }
    
    form.on('select(memberSelect)', function (data) {
        if (data.value>0) {
            var active = {
                reload: function () {
                    taskTable.reload({
                        where: {
                            search: data.value
                        }
                    });
                }
            };
            active['reload'].call();
            $('#taskTable-btn button').each(function () {
                $(this).addClass('layui-btn-primary');
            });
        }

    });      

    //任务视图头工具栏事件
    table.on('toolbar(taskTable)', function (obj) {
        if (obj.event === "createTask") {
            $('#memberSelect').click();
            $('#member_search input').val("按参与人搜索");
            layer.open({
                type: 2,
                title: "添加任务--无所属计划",
                resize: false,
                area: ['600px', '500px'],
                shadeClose: true,
                scrollbar: false,
                async: false,
                content: '/TaskScheduleBoard/Tasks/CreateTask',
                end: function () {
                    table.reload('taskTable');
                    $('#taskTable-btn button').each(function () {
                        $(this).addClass('layui-btn-primary');
                    });
                    $('button[lay-event="' + obj.config.where.queryType + '"]').removeClass('layui-btn-primary');
                }
            });
        }
        else {
            $('#memberSelect').click();
            $('#member_search input').val("按参与人搜索");
            table.reload('taskTable', {
                where: {
                    queryType: obj.event
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
            $('#taskTable-btn button').each(function () {
                $(this).addClass('layui-btn-primary');
            });
            $('button[lay-event="' + obj.event + '"]').removeClass('layui-btn-primary');
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
    });

    var planStatusArray = ["开放", "关闭"];
    //计划视图
    table.render({
        elem: '#planTable'
        , id: 'planTable'
        , url: '/TaskScheduleBoard/Plan/GetPlans'//数据接口
        , toolbar: '#planTableToolbar'
        , defaultToolbar: []
        , page: true
        , cols: [[
            { type: 'numbers', title: '编号', width: 50 }
            , {
                field: 'planName', title: '名称', templet: function (d) {
                    return '<div class="planNameColumn" data-planid="' + d.planId + '">' + d.planName + '</div>';
                }
            }
            , {
                field: 'planStatus', title: '状态', width: 70, templet: function (d) {
                    var style = 'style="cursor: default;color: #000;';
                    switch (d.planStatus) {
                        case planStatusArray[0]:
                            style += 'background-color: #FFCC99;';
                            break;
                        case planStatusArray[1]:
                            style += 'background-color: #EEEEEE;';
                            break;
                        default:
                            style += 'background-color: #EEEEEE;';
                            break;
                    }
                    style += '"';
                    return '<div ' + style + ' class="layui-btn layui-btn-xs">' + d.planStatus + '</div>';
                }
            }
            , {
                field: 'tasks', title: '任务列表', templet: function (d) {
                    var div = $('<div></div>');
                    var ol = $('<ol></ol>');
                    for (var i = 0; i < d.tasks.length; i++) {
                        var taskLi = $('<li></li>');
                        var style = getTaskStatusColumnStyle(d.tasks[i].taskStatus, d.tasks[i].deadLineTime, taskStatusArray);
                        var taskButton = $('<div class="taskNameColumn" style="display: inline-block;border-radius: 2px;;margin-bottom: 2px;'
                            + style + '" data-taskid = "' + d.tasks[i].taskId + '">' + (i + 1) + '.' + d.tasks[i].taskName + '</div>');
                        taskLi.append(taskButton);
                        ol.append(taskLi);
                    }
                    div.append(ol);
                    return div.html();
                }
            }
            , {
                field: 'createdMemberId', title: '创建人', width: 75, templet: function (d) {
                    //在单元格里放入成员图片
                    var memberDiv = $('<div></div>');
                    var imgClick = '$(".layui - table - tips").remove();pageToUrl("nagiveBar_introduction", "/introduction/member/memberrecord?id=' + d.createdMemberId + '");';
                    var picDiv = $('<img style="width:36px;heigh:36px;cursor:pointer" src="' + d.createdMemberPhoto + '"></img>');
                    picDiv.attr('onclick', imgClick);
                    memberDiv.append(picDiv);
                    return memberDiv.html();
                }
            }
            , {
                field: 'createTime', title: '创建时间', width: 105, templet: function (d) {
                    return toDateString(d.createTime, 'YYYY-MM-DD');
                }
            }
            , {
                field: 'closedTime', title: '关闭时间', width: 220, templet: function (d) {
                    return toDateString(d.closedTime);
                }
            }
            , { field: 'toolUnit', title: '操作', width: 80, toolbar: '#planToolUnitTemplet' }
        ]]
        , done: function () {
            $('#planTable-tab tbody .planNameColumn[data-planid]').on('click', function () {
                var planId = $(this).data('planid');
                var currentButtonEvent = $('#planTable-btn button:not([class~="layui-btn-primary"])').attr('lay-event');
                goBackClick.push(function () {
                    pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks'
                        , function () {
                            $('#planView').click();//返回至之前的tab页
                            $('button[lay-event=' + currentButtonEvent + ']').click();//返回至之前的tab中点击的筛选按钮页
                        });
                });
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/Plan/GetPlanDetail?planId=' + planId);
            });

            $('#planTable-tab tbody .taskNameColumn[data-taskid]').on('click', function () {
                var taskId = $(this).data('taskid');
                var currentButtonEvent = $('#planTable-btn button:not([class~="layui-btn-primary"])').attr('lay-event');
                goBackClick.push(function () {
                    pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks'
                        , function () {
                            $('#planView').click();//返回至之前的tab页
                            $('button[lay-event=' + currentButtonEvent + ']').click();//返回至之前的tab中点击的筛选按钮页
                        });
                });
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/GetTaskDetail?taskId=' + taskId);
            });
        }
    });
    table.on('toolbar(planTable)', function (obj) {
        if (obj.event === "createPlan") {
            layer.open({
                type: 2,
                title: '添加计划',
                resize: true,
                area: ['590px', '407px'],
                shadeClose: true,
                scrollbar: false,
                async: false,
                content: '/TaskScheduleBoard/Plan/CreatePlan',
                end: function () {
                    table.reload('planTable');
                    $('#planTable-btn button').each(function () {
                        $(this).addClass('layui-btn-primary');
                    });
                    $('button[lay-event="' + obj.config.where.queryType + '"]').removeClass('layui-btn-primary');
                }
            });
        }
        else {
            table.reload('planTable', {
                where: {
                    queryType: obj.event
                }
                , page: {
                    curr: 1 //重新从第 1 页开始
                }
            });
            $('#planTable-btn button').each(function () {
                $(this).addClass('layui-btn-primary');
            });
            $('button[lay-event="' + obj.event + '"]').removeClass('layui-btn-primary');
        }
    });
    table.on('tool(planTable)', function (obj) {
        var data = obj.data;
        if (obj.event === 'closePlan') {
            layer.confirm('确定关闭该计划吗？', { icon: 3, title: '提示' }, function (index) {
                $.ajax({
                    url: '/TaskScheduleBoard/Plan/ClosePlan'
                    , type: 'post'
                    , async: false
                    , data: { planId: data.planId }
                    , success: function (d) {
                        if (d.result) {
                            parent.layer.msg('关闭成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                            table.reload('planTable');
                        }
                        else {
                            parent.layer.msg(d.message, { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                        }
                    }
                });
            });
        } else if (obj.event === 'addTask') {
            createTaskByPlan(data);
        } else if (obj.event === 'deletePlan') {
            layer.confirm('确定删除该计划吗？', { icon: 3, title: '提示' }, function (index) {
                $.ajax({
                    url: '/TaskScheduleBoard/Plan/DeletePlan'
                    , type: 'post'
                    , async: false
                    , data: { planId: data.planId }
                    , success: function (d) {
                        if (d.result) {
                            parent.layer.msg('删除成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                            table.reload('planTable');
                        }
                        else {
                            parent.layer.msg(d.message, { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                        }
                    }
                });
            });
        }
    });

      //成员视图
    var seasons = ["春", "夏", "秋", "冬"];
    var colors = ["102, 255, 0", "255,0,0", "255, 153, 0","153, 0, 255"];
    var nowDate = new Date();//当前日期
    var marginTopIndex = 0;
    //上个季节
    var lastDate = new Date(nowDate);
    lastDate.setMonth(nowDate.getMonth() - 3); 

    var lastDate2 = new Date(nowDate);
    lastDate2.setMonth(nowDate.getMonth() - 6); 

    var lastDate3 = new Date(nowDate);
    lastDate3.setMonth(nowDate.getMonth() - 9); 

    var lastDate4 = new Date(nowDate);
    lastDate4.setMonth(nowDate.getMonth() - 12); 
   
    //下个季节
    var nextDate = new Date(nowDate);
    nextDate.setMonth(nowDate.getMonth() +3); 

    table.render({
        elem: '#memberTable'
        , id: 'memberTable'
        , url: '/TaskScheduleBoard/MemberScheduleTasks/GetMemberScheduleTasks'
        , skin: 'nob'
        , cellMinWidth: 80
        , page: false
        , limit: 10000
        , cols: [[
            {
                field: 'pic', width: 182, style: 'background-color:rgba(219, 219, 219,0.3);',templet: function (d) {
                    marginTopIndex = 0;
                    var memberDiv = $('<div ></div>');
                    var imgSrc = d.memberPhoto[0].Photo != null ? d.memberPhoto[0].Photo: '/images/public/NonePicture.png';
                    var img = `<img src="${imgSrc}" style="margin-top:25px;">`;
                    var name = $(`<a class="memberName">${d.memberPhoto[0].Name}</a>`);
                    var imgClick = `pageToUrl("nagiveBar_introduction", "/introduction/member/memberrecord?id=${d.memberPhoto[0].Id}");`;
                    memberDiv.append(img);
                    name.attr('onclick', imgClick);
                    memberDiv.append(name);
                    if (d.count < 5) {
                        return `<div style="height:${225}px;width:167px;">${memberDiv.html()}</div>`;
                    }
                    return `<div style="height:${65+(d.count - 1) * 47}px;width:167px;">${memberDiv.html()}</div>`;
                }
            }
            , {
                field: 'lastYear', title: '<div class="title" style="background-color:rgba(219, 219, 219,0.5);">' + lastDate4.getFullYear() + '&nbsp;' + getSeason(lastDate4) + '</div>',
                width: 183, style: 'background-color:rgba(219, 219, 219,0.3);', templet: function (d) {
                    return showTask(d, lastDate4,0);
                }
            }
            , {
                field: 'spring', title: '<div class="title" style="' + getColor(lastDate3, 0.5) + ';">' + lastDate3.getFullYear() + '&nbsp;' + getSeason(lastDate3) + '</div>',
                width: 183, style: getColor(lastDate3, 0.3), templet: function (d) {
                    return showTask(d, lastDate3,1);
                }
            }
            , {
                field: 'summer', title: '<div class="title" style="' + getColor(lastDate2, 0.7) + ';">' + lastDate2.getFullYear() + '&nbsp;' + getSeason(lastDate2) + '</div>',
                width: 183, style: getColor(lastDate2, 0.3), templet: function (d) {
                    return showTask(d, lastDate2,2);
                }
            }
            , {
                field: 'autumn', title: '<div class="title" style="' + getColor(lastDate, 0.7) + ';">' + lastDate.getFullYear() + '&nbsp;' + getSeason(lastDate) + '</div>',
                width: 183, style: getColor(lastDate, 0.3), templet: function (d) {
                    return showTask(d, lastDate,3);
                }
            }
            , {
                field: 'winter', title: '<div class="title" style="' + getColor(nowDate, 0.7) + ';">' + nowDate.getFullYear() + '&nbsp;' + getSeason(nowDate) + '</div>',
                width: 183, style: getColor(nowDate, 0.3), templet: function (d) {
                    return showTask(d, nowDate,4);
                }
            }
            , {
                field: 'nextYear', title: '<div class="title" style="background-color:rgba(219, 219, 219,0.5);">' + nextDate.getFullYear() + '&nbsp;' + getSeason(nextDate) + '</div>',
                width: 183, style: 'background-color:rgba(219, 219, 219,0.3);'
            }
        ]]
        , done: function (res, curr, count) {
            var that = this.elem.next();
            res.data.forEach(function (item, index) {
                if (index % 2 == 0) {
                    var tr = that.find(".layui-table-box tbody tr[data-index='" + index + "']").css("background-color", "rgba(128,128,128,0.2)");
                }
            });

            $('.layui-container').css("height", `100%`);
            taskCount = 0;
            $('#memberTable-tab thead th').eq(5).find('div').eq(1).css({ "color": "white", "font-weight": "800"});
            $('#memberTable-tab tbody .taskScheduleColumn[data-taskid]').on('click', function () {
                var taskId = $(this).data('taskid');
                var currentButtonEvent = $('#memberTable-btn button:not([class~="layui-btn-primary"])').attr('lay-event');
                goBackClick.push(function () {
                    pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks'
                        , function () {
                            $('#memberView').click();//返回至之前的tab页
                            $('button[lay-event=' + currentButtonEvent + ']').click();//返回至之前的tab中点击的筛选按钮页
                        });
                });
                pageToUrl('nagiveBar_tasks', '/TaskScheduleBoard/tasks/GetTaskDetail?taskId=' + taskId);
            });
            $('#memberTable-tab .layui-table-body').off('mouseenter', 'td');
        }
    });
    var titlediv = $('.title'), scrollTop;
    $(window).scroll(function () {
        scrollTop = Math.max(document.body.scrollTop || document.documentElement.scrollTop);
        if (scrollTop < 175) {
            titlediv.css({ "top": 175 - scrollTop });
            
        }
        if (scrollTop > 175) {
            titlediv.css({ "top": 0 });
        }
    });

    function showTask(d, date, seasonIndex) {
        var tasksDiv = $('<div></div>');
        for (var index = 0; index < d.taskList.length; index++) {
            if (d.taskList[index].season == seasonIndex) {
                marginTopIndex++;
                var task = `<div  class="task" style="${getColor(date, 0.5)};margin-left:${geLength(d.taskList[index].length)}px;top:${marginTopIndex * 45 - 15}px;"
                            title="${d.taskList[index].name}"><a class="taskScheduleColumn" data-taskid="${d.taskList[index].id}">${d.taskList[index].name}</a></div>`;
               
                tasksDiv.append(task);
            }
        }

        return tasksDiv.html();
    }
    
    function getSeason(obj) {
        return seasons[parseInt((obj.getMonth() + 3) / 3) - 1];
    }
    function getColor(obj, opacityNum) {
        return `background-color:rgba(${colors[parseInt((obj.getMonth() + 3) / 3) - 1]},${opacityNum});filter:Alpha(opacity=${opacityNum * 100});`;
    }
    function geLength(across) {
        if (across == 1) {
            return -8;
        }
        return 40 * across;
    }

    function createTaskByPlan(data) {
        layer.open({
            type: 2,
            title: "添加任务--当前计划是：" + data.planName,
            resize: false,
            area: ['600px', '500px'],
            shadeClose: true,
            scrollbar: false,
            async: false,
            content: '/TaskScheduleBoard/Tasks/CreateTask?planId=' + data.planId,
            end: function () {
                table.reload('planTable');
            }
        });
    }

    function trackTask(taskId) {
        var index = layer.open({
            type: 2,
            resize: false,
            title: "任务跟进",
            area: ['545px', '332px'],
            scrollbar: false,
            shadeClose: true,
            scrollbar: false,
            async: false,
            content: "/TaskScheduleBoard/Tasks/TrackingTask?taskId=" + taskId,
            end: function () {
                table.reload('taskTable');
            }
        });
    }

});

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