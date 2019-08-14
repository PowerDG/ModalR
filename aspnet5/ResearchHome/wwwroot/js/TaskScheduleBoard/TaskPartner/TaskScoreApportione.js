window.onload = function () {
    getTaskPartner();
    getTaskInfo();
    getCommunicationData();
}

var detailPartShowHeight;
var communicationReplayShowHeight;

function setPanelHeight(eleId, ImgId) {
    var iframeElement = window.top.frames[0].frameElement;
    var layerIframe = $(iframeElement).parent().parent();
    var isExpend = $('#' + ImgId).attr("src") === '/images/PromptImg/ContentShrink.png';
    if (isExpend) {
        $('#' + eleId).css("display", "block");
        var iframeElementOldClientHeight = $(iframeElement)[0].clientHeight;
        $(iframeElement).css("height", $(iframeElement)[0].clientHeight + $('#' + eleId).height() + "px");
        if (eleId === 'showTaskDetail') detailPartShowHeight = $(iframeElement)[0].clientHeight - iframeElementOldClientHeight;
        else communicationReplayShowHeight = $(iframeElement)[0].clientHeight - iframeElementOldClientHeight;
        var layerPanelAddHeight = eleId === 'showTaskDetail' ? detailPartShowHeight : communicationReplayShowHeight;
        $('#addTaskParnerForm').css("height", $('#addTaskParnerForm').height() + layerPanelAddHeight + "px");
        $('.layui-contentall').css("height", $('.layui-contentall').height() + layerPanelAddHeight + "px");
        var layerIframeTop = ($(parent.window).height() - $(iframeElement)[0].clientHeight) / 2;
        $(layerIframe).css("top", layerIframeTop + "px");
        $('#' + ImgId).attr("src", '/images/PromptImg/ContentExpend.png');
    } else {
        if (eleId === 'showTaskDetail') {
            $(iframeElement).css("height", $(iframeElement)[0].clientHeight - detailPartShowHeight + "px");
            $('#addTaskParnerForm').css("height", $('#addTaskParnerForm').height() - detailPartShowHeight + "px");
            $('.layui-contentall').css("height", $('.layui-contentall').height() - detailPartShowHeight + "px");
        }
        else {
            $('#addTaskParnerForm').css("height", $('#addTaskParnerForm').height() - communicationReplayShowHeight + "px");
            $('.layui-contentall').css("height", $('.layui-contentall').height() - communicationReplayShowHeight + "px");
            $(iframeElement).css("height", $(iframeElement)[0].clientHeight - communicationReplayShowHeight + "px");
        }
        var layerIframeTop = ($(parent.window).height() - $(iframeElement)[0].clientHeight) / 2;
        $(layerIframe).css("top", layerIframeTop + "px");
        $('#' + eleId).css("display", "none");
        $('#' + ImgId).attr("src", '/images/PromptImg/ContentShrink.png');
    }
}

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
                var communicationInfoPanel = document.getElementById('communicationReplay');
                laytpl(getTpl).render(data, function (html) {
                    communicationInfoPanel.innerHTML = html;
                });
            }
        });
    });
}

function getTaskPartner() {
    layui.use('laytpl', function () {
        var laytpl = layui.laytpl;
        $.ajax({
            type: "POST",
            dataType: "json",
            data: { taskId: GetQueryString("taskId") },
            url: "/TaskScheduleBoard/TaskPartner/GetTaskPartner",
            success: function (data) {
                var taskScoreApportioneMaster = document.getElementById('taskScoreApportioneMaster');
                var getTpl = taskScoreApportioneMaster.innerHTML;
                var taskScoreApportione = document.getElementById('taskScoreApportione');
                laytpl(getTpl).render(data, function (html) {
                    taskScoreApportione.innerHTML = html;
                    var iframeHeight = $(".layui-layer-title").height();
                    $('#taskScoreApportione').css("height", data.length * $(".layui-form-item .layui-inline").height());
                    var iframeElement = window.top.frames[0].frameElement;
                    var layerIframe = $(iframeElement).parent().parent();
                    var layerTitleHeight = $(layerIframe).find(".layui-layer-title")[0].clientHeight;
                    var layerBtnHeight = $(".layui-content-btn").height();
                    var scoreApportionePanelHeight = $('#taskScoreApportione')[0].clientHeight;
                    var taskDetailPartHeight = $(".taskDetailPart")[0].clientHeight;
                    var iframeElementHeight = scoreApportionePanelHeight + layerBtnHeight + taskDetailPartHeight * 2 + 5 * 2 + 20;//两个菜单底部间隔5px  form顶部间隔20px
                    $(iframeElement).css("height", iframeElementHeight + "px");
                    $('#addTaskParnerForm').css("height", scoreApportionePanelHeight + taskDetailPartHeight * 2 + 5 * 2 + "px");
                    $('.layui-contentall').css("height", scoreApportionePanelHeight + taskDetailPartHeight * 2 + 5 * 2 + 20 + layerBtnHeight + "px");
                    $(iframeElement).css("max-height", "800px");
                    $('.layui-contentall').css("max-height", "800px");
                    $('#addTaskParnerForm').css("max-height", 800 - layerBtnHeight - 20 + "px");
                    var layerIframeTop = ($(parent.window).height() - $(iframeElement)[0].clientHeight) / 2;
                    $(layerIframe).css("top", layerIframeTop + "px");
                });
            }
        });
    });
}

function isNullOrNumber(value, errorId) {
    if (!value) {
        $('#' + errorId + ' .valid-tips-span>span').html("分值不能为空");
        $('#' + errorId).removeClass('errorMsgHide');
        $('#' + errorId).addClass('errorMsgShow');
    }
    else if (isNaN(value)) {
        $('#' + errorId + ' .valid-tips-span>span').html("分值只能是数字");
        $('#' + errorId).removeClass('errorMsgHide');
        $('#' + errorId).addClass('errorMsgShow');
    } else {
        $('#' + errorId).removeClass('errorMsgShow');
        $('#' + errorId).addClass('errorMsgHide');
    }
}

function btnSubmit() {
    if ($('.errorMsgShow').length) return;
    var models = [];
    var totalIntegral = 0;
    $('.layui-input-inline>input').each(function () {
        models.push({
            MemberId: $(this).attr("id"),
            Integral: parseInt($(this).val()),
            Description: $('#' + $(this).attr("id") + '_Description').val()
        });
        totalIntegral += parseInt($(this).val());
    });
    if (totalIntegral !== parseInt(GetQueryString("taskScore"))) {
        layer.confirm('分配分值的总和与任务总分不匹配，是否要继续保存？', { icon: 3, title: '分值确认' }, function (index) {
            sumbitFuc(models);
            layer.close(index);
        });
    }
    else {
        sumbitFuc(models);
    }
}

function sumbitFuc(models) {
    $.ajax({
        type: "POST",
        dataType: "json",
        data: { tasksIntegralModels: models, taskId: GetQueryString("taskId") },
        url: "/TaskScheduleBoard/TaskPartner/SetTaskScoreApportione",
        success: function (data) {
            if (data) {
                layer.msg("分配成功!", { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () { parent.layer.closeAll(); });
            } else {
                layer.msg("分配失败,请重试!", { icon: 5, shift: -1, time: 500, shade: 0.3 });
            }
        }
    });
}