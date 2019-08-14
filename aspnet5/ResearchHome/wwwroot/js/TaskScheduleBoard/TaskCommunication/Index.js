window.onload = function () {
    getTaskInfo();
    getCommunicationData();
}

function show_element(e) {
    if (!e) {
        var e = window.event;
    }
    var target = e.target;
    if (target.id === 'replyDescriptionMaster'
        || target.id === 'replyMasterBtnDiv'
        || target.id === 'replyMasterBtn'
        || target.id === 'replyMasterMsg'
        || target.className === 'layui-icon layui-icon-reply-fill'
        || target.className === 'layui-layer-btn0' //确认取消评论按钮(确定)
        || target.className === 'layui-layer-btn1' //确认取消评论按钮(取消)
    ) {
        return false;
    } else {
        if ($('.replyClass').length === 0 || $('#replyDescriptionMaster').val() === '') {
            $('.replyClass').remove();
            $('#communicationPanel').css("display", "block");
        }
        else {
            layer.confirm('当前输入框有数据,确认取消评论?',
                {
                    yes: function (index) {
                        $('.replyClass').remove();
                        $('#communicationPanel').css("display", "block");
                        layer.closeAll();
                    },
                    cancel: function (index, layero) {
                        $('#replyDescriptionMaster').focus();
                    }
                }
            );
        }
    }

}

$(document).mousedown(function (e) {
    show_element(e);
});

function getTaskInfo() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/TaskCommunication/GetCommunicationTask",
        data: { taskId: GetQueryString("taskId") },
        success: function (data) {
            $('#taskName').empty().append(data.Name);
            $('#taskScore').empty().append(data.Score);
            $('#memberName').empty().append(data.MemberName);
            $('#startTime').empty().append(toDateString(data.StartTime) + " ~ " + toDateString(data.EndTime));
        }
    });
}

function getCommunicationData() {
    $('#communicationDescription').focus();
    layui.use('laytpl', function () {
        var laytpl = layui.laytpl;
        $.ajax({
            type: "POST",
            dataType: "json",
            url: "/TaskScheduleBoard/TaskCommunication/GetCommunicationData",
            data: { taskId: GetQueryString("taskId") },
            success: function (data) {
                var CommunicationsInfoMaster = document.getElementById('CommunicationsInfoMaster');
                var getTpl = CommunicationsInfoMaster.innerHTML;
                var communicationInfoPanel = document.getElementById('communicationInfoPanel');
                laytpl(getTpl).render(data, function (html) {
                    communicationInfoPanel.innerHTML = html;
                });
            }
        });
    });
}

function showRelayPanel(eleId, replyName, replyId, commounicationId) {
    if ($('.replyClass').length === 0 || $('#replyDescriptionMaster').val() === '') {
        showReplyMaster(eleId, replyName, replyId, commounicationId);
    }
    else {
        layer.confirm('当前输入框有数据,确认取消评论?',
            {
                yes: function (index) {
                    showReplyMaster(eleId, replyName, replyId, commounicationId);
                    layer.closeAll();
                },
                cancel: function (index, layero) {
                    $('#replyDescriptionMaster').focus();
                }
            }
        );
    }
}

function showReplyMaster(eleId, replyName, replyId, commounicationId) {
    $('.replyClass').remove();
    $('#' + eleId).append($('#replyPanelMaster').html());
    $('#replyMemberId').val(replyId);
    $('#replyCommounicationId').val(commounicationId);
    var showMsg = "回复:" + replyName + ":";
    $('#replyMasterMsg').html(showMsg);
    $('#replyDescriptionMaster').css("text-indent", getMsgWidth(showMsg, 'replyMasterMsg'));
    $('#replyPanelMasterDiv').css("display", "block");
    $('#communicationPanel').css("display", "none");
    $('#replyDescriptionMaster').focus();

}

function getMsgWidth(showMsg, showLable) {
    var msgWidth = 0;
    var fontSize = $('#' + showLable).css("font-size");
    var fontWidth = parseInt(fontSize.substring(0, fontSize.length - 2));
    for (var i = 0; i < showMsg.length; i++) {
        var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
        if (reg.test(showMsg[i])) msgWidth += fontWidth;
        else msgWidth += fontWidth / 2 + 1;
    }
    return msgWidth;
}

function submitCommunication() {
    if ($('#communicationDescription').val() === '') {
        layer.msg("请输入内容!", { icon: 8, shift: -1, time: 500, shade: 0.3 });
        return;
    }
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/TaskCommunication/InsertTaskCommunication",
        data: {
            taskId: GetQueryString("taskId"),
            communicationText: $('#communicationDescription').val()
        },
        success: function (data) {
            if (data) {
                layer.msg("评论成功!", { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () {
                    communicationText: $('#communicationDescription').val('');
                    getCommunicationData();
                });
            } else {
                layer.msg("评论失败!", { icon: 5, shift: -1, time: 500, shade: 0.3 });
            }
        }
    });
}

function submitReplyCommunication() {
    if ($('#replyDescriptionMaster').val() === '') {
        layer.msg("请输入内容!", { icon: 8, shift: -1, time: 500, shade: 0.3 });
        return;
    }
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/TaskScheduleBoard/TaskCommunication/InsertTaskCommunicationReply",
        data: {
            taskId: GetQueryString("taskId"),
            replyMemberId: $('#replyMemberId').val(),
            replycommounicationId: $('#replyCommounicationId').val(),
            communicationText: $('#replyDescriptionMaster').val()
        },
        success: function (data) {
            if (data) {
                layer.msg("评论成功!", { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () {
                    communicationText: $('#replyDescriptionMaster').val('');
                    $('#communicationPanel').css("display", "block");
                    getCommunicationData();
                });
            } else {
                layer.msg("评论失败!", { icon: 5, shift: -1, time: 500, shade: 0.3 });
            }
        }
    });
}