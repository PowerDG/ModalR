var selectMedals = [];
layui.config({
    base: '/lib/layui/lay/extends/'
});

layui.use(['element', 'form', 'layer', 'selectM'], function () {
    var form = layui.form
        , element = layui.element
        , layer = layui.layer;

    if ($('#grantType').attr('data-granttype') === '1') {
        SelectBind("GetTaskParticipant", "memberId", "Id", "Name", '', "150px", form, { taskId: $('#taskId').attr('data-taskid') });
    }
    else {
        SelectBind("GetMembersList", "memberId", "Id", "Name", '', "150px", form, { taskId: $('#taskId').attr('data-taskid') });
        $('.medalImage').each(function () {
            var medalId = $(this).attr('data-medalId');
            var index = selectMedals.indexOf(medalId);
            if (index != -1) {
                selectMedals.splice(index, 1);
                $(this).empty();
                return;
            }
            selectMedals.push(medalId);
            var selectIcon = $('<i class="layui-icon layui-icon-ok-circle selectIcon" ></i>')
            $(this).append(selectIcon);
        });
    }

    $('.medalImage').click(function () {
        var medalId = $(this).attr('data-medalId');
        var index = selectMedals.indexOf(medalId);
        if (index != -1) {
            selectMedals.splice(index, 1);
            $(this).empty();
            return;
        }
        selectMedals.push(medalId);
        var selectIcon = $('<i class="layui-icon layui-icon-ok-circle selectIcon" ></i>')
        $(this).append(selectIcon);
    });

    $('#grantMedals').click(function () {
        var postData = {};
        postData.medalIds = selectMedals.join(',');
        postData.memberId = $('.layui-form-select dd.layui-this').attr('lay-value');
        postData.reason = $('#reason').val();
        if (postData.memberId === undefined || postData.memberId === '') {
            layer.msg("请选择一个成员！", { icon: 5 });
        }
        else if (postData.medalIds === '') {
            layer.msg("至少选择一个勋章！", { icon: 5 });
        }
        else {
            $.ajax({
                url: '/TaskScheduleBoard/Tasks/SaveMemberMedals?taskId=' + $('#taskId').attr('data-taskid') + '&grantType=' + $('#grantType').attr('data-granttype')
                , method: 'post'
                , data: postData
                , success: function (d) {
                    if (d.result) {
                        parent.layer.msg('添加成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                            function () { parent.layer.closeAll(); });
                    }
                    else {
                        parent.layer.msg(d.message, { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                            function () { parent.layer.closeAll(); });
                    }
                }
            });
        }
        return false;
    });
});