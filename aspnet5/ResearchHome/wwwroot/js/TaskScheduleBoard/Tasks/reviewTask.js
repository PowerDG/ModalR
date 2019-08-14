layui.config({
    base: '/lib/layui/lay/extends/'
});
layui.use(['element', 'form', 'layer', 'laydate', 'myutil'], function () {
    var form = layui.form,
        layer = layui.layer,
        util = layui.myutil;

    //已点评不可编辑
    if ($('#isReview').attr('data-isreview') === '1') {
        $('#grantMedal').css('display', 'none');
        $('#foreignGrant').css('display', 'none'); 
        $('#reset').css('display', 'none');
    }

    $('#grantMedal').click(function () {
        layer.open({
            type: 2,
            title: '授予勋章',
            resize: true,
            area: ['700px', '712px'],
            shadeClose: true,
            scrollbar: false,
            success: function (layero, index) {
                layero.css("overflow-y", "visible");
            },
            //async: false,
            content: '/TaskScheduleBoard/Tasks/GrantMedal?taskId=' + $('input[name=taskId]').val() + '&grantType=1',
            end: function () {
                loadMemberMedals(1, 'memberPartContent');
            }
        });
    });

    loadMemberMedals(1, 'memberPartContent');//成员勋章
    loadMemberMedals(2, 'foreignPartContent');//外援勋章

    $('#foreignGrant').click(function () {
        layer.open({
            type: 2,
            title: '最佳外援',
            resize: false,
            area: ['700px', '712px'],
            shadeClose: true,
            scrollbar: false,
            success: function (layero, index) {
                layero.css("overflow-y", "visible");
            },
            //async: false,
            content: '/TaskScheduleBoard/Tasks/GrantMedal?taskId=' + $('input[name=taskId]').val() + '&grantType=2',
            end: function () {
                loadMemberMedals(2, 'foreignPartContent');
            }
        });
    });

    $('[name*="reviewScore"]').change(function () {
        var total = 0;
        for (var i = 0; i < $('[name*="reviewScore"]').length; i++) {
            var score = $($('[name*="reviewScore"]')[i]).val();
            //console.log($($('[name*="reviewScore"]')[0]).val());
            total += parseInt(score);
        }
        $('[name="totalScore"]').val(total);
    });

    $('#update').click(function () {
        var perfectFunction = $('#perfectFunction').val();
        var troubleFunction = $('#troubleFunction').val();
        var strongAspect = $('#strongAspect').val();
        var weaknessAspect = $('#weaknessAspect').val();

        $.ajax({
            url: '/TaskScheduleBoard/Tasks/UpdateTaskReviews?taskId=' + $('input[name=taskId]').val() + '&perfectFunction=' + perfectFunction
                + '&troubleFunction=' + troubleFunction + '&strongAspect=' + strongAspect + '&weaknessAspect=' + weaknessAspect,
            method: 'post',
            success: function (data) {
                if (data.result) {
                    layer.msg("保存成功!", { icon: 6, shift: -1, time: 1000 });
                }
                else {
                    layer.msg(data.message, { icon: 5, shift: -1, time: 1000 });
                }
            }
        })
    });

    $('#reset').click(function () {
        $.ajax({
            url: '/TaskScheduleBoard/Tasks/ClearMedal?taskId=' + $('input[name=taskId]').val(),
            method: 'post',
            success: function (data) {
                if (data.result) {
                    layer.msg("清空成功!", { icon: 6, shift: -1, time: 1000 });
                    loadMemberMedals(1, 'memberPartContent');
                    loadMemberMedals(2, 'foreignPartContent');
                }
                else {
                    layer.msg(data.message, { icon: 5, shift: -1, time: 1000 });
                }
            }
        })
    });


    var contributionStandardIndex = null;
    $('.layui-fixbar').remove();
    if ($('#isReview').attr('data-isreview') === '1') {
        util.fixbar({
            bar1: '&#xe62c'
            , bar2: '&#xe65c'
            , bgcolor: '#009688'
            , css: { right: 15, bottom: 30 }
            , click: function (type) {
                if (type === 'bar1' && contributionStandardIndex === null) {
                    var personalContributeTop = $('#personalContribute').offset().top - $(document).scrollTop() + 'px';
                    var personalContributeleft = $('#personalContribute').offset().left + 'px';
                    contributionStandardIndex = layer.open({
                        type: 2,
                        title: ['个人贡献参考标准', 'font-size:16px;'],
                        closeBtn: 2,
                        //shadeClose: true,
                        shade: false,
                        maxmin: false, //开启最大化最小化按钮
                        //offset: ['135px', '1px'],
                        offset: 'lb',
                        area: [($('#personalContribute').offset().left - 12) + 'px', '800px'],
                        content: '/TaskScheduleBoard/ContributionStandard/Index'
                    });
                }
                else if (type === 'bar1' && contributionStandardIndex != null) {
                    layer.close(contributionStandardIndex);
                    contributionStandardIndex = null;
                }
                else if (type === 'bar2') {
                    (goBackClick.pop())();
                }
            }
        });
    }
    else {
        util.fixbar({
            bar1: '&#xe62c'
            , bar2: '&#x1005'
            , bar3: '&#xe65c'
            , bgcolor: '#009688'
            , css: { right: 15, bottom: 30 }
            , click: function (type) {
                if (type === 'bar1' && contributionStandardIndex === null) {
                    var personalContributeTop = $('#personalContribute').offset().top - $(document).scrollTop() + 'px';
                    var personalContributeleft = $('#personalContribute').offset().left + 'px';
                    contributionStandardIndex = layer.open({
                        type: 2,
                        title: ['个人贡献参考标准', 'font-size:16px;'],
                        closeBtn: 2,
                        shade: false,
                        maxmin: true, //开启最大化最小化按钮
                        offset: 'lb',
                        area: [($('#personalContribute').offset().left - 12) + 'px', '800px'],
                        content: '/TaskScheduleBoard/ContributionStandard/Index'
                    });
                }
                else if (type === 'bar1' && contributionStandardIndex != null) {
                    layer.close(contributionStandardIndex);
                    contributionStandardIndex = null;
                }
                else if (type === 'bar2') {
                    $('[lay-filter="saveReview"]').click();
                }
                else if (type === 'bar3') {
                    (goBackClick.pop())();
                }
            }
        });
    }
    form.on('submit(saveReview)', function (data) {
        var formData = {};
        formData.members = [];
        for (var i in data.field) {
            if (i.indexOf('-') != -1) {
                if (i.indexOf('reviewComment-') != -1) {
                    var member = {};
                    member.Id = i.split('-')[1];
                    member.ReviewComment = data.field[i];
                    member.ReviewScore = data.field['reviewScore-' + member.Id];
                    formData.members.push(member);
                }
            }
            else {
                formData[i] = data.field[i];
            }
        }
        $.ajax({
            url: '/TaskScheduleBoard/Tasks/SaveTaskReview', 
            method: 'post',
            data: formData,
            success: function (data) {
                if (data.result) {
                    layer.msg("保存成功!", { icon: 6, shift: -1, time: 1000 });
                    $('#perfectFunction').attr('disabled', 'disabled');
                    $('#troubleFunction').attr('disabled', 'disabled');
                    $('#strongAspect').attr('disabled', 'disabled');
                    $('#weaknessAspect').attr('disabled', 'disabled');
                    $('#totalScore').attr('disabled', 'disabled');
                    $('[name*="reviewComment"]').attr('disabled', 'disabled');
                    $('[name*="reviewScore"]').attr('disabled', 'disabled');
                    $('#grantMedal').css('display', 'none');
                    $('#foreignGrant').css('display', 'none');
                    //form.render();
                }
                else {
                    layer.msg(data.message, { icon: 5, shift: -1, time: 1000 });
                }
            }
        })

        return false;
    });
});

function loadMemberMedals(grantType, contentDivId) {
    $.ajax({
        url: '/TaskScheduleBoard/Tasks/GetMemberMedals?taskId=' + $('input[name=taskId]').val() + '&grantType=' + grantType,
        method: 'post',
        //data: data.field,
        success: function (data) {
            $('#' + contentDivId).empty();
            for (var i = 0; i < data.length; i++) {
                var member = data[i];
                var medals = data[i].personalMedals;

                var staffDiv = $('<div class="layui-col-staff"></div>');
                var imageDiv = $('<div></div>');
                imageDiv.attr('data-memberid', member.memberId);
                imageDiv.css({
                    'position': 'relative',
                    'width': '150px',
                    'height': '150px',
                    'background-image': 'url(' + member.memberPhoto + ')',
                    'background-size': 'contain'
                });
                for (var j = 0; j < medals.length; j++) {
                    var vertical = parseInt(j / 4);
                    var horizontal = j % 4;
                    var medalImage = $('<img></img>');
                    medalImage.attr({
                        'width': 34,
                        'height': 34,
                        'src': medals[j].medalIcon
                    });
                    medalImage.css({
                        'position': 'absolute',
                        'bottom': vertical * 39 + 'px',
                        'right': horizontal * 39 + 'px'
                    });
                    imageDiv.append(medalImage);
                }
                staffDiv.append(imageDiv);
                $('#' + contentDivId).append(staffDiv);
            }
        }
    });
};