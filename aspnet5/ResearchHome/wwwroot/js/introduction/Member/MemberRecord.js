/**************************************个人页-初始化*********************************************/
$(document).on('mouseenter', '.layui-table>tbody>tr', function (event) {
    $(this).find('.toolPanl').css("display", "block");
}).on('mouseleave', '.layui-table>tbody>tr', function (event) {
    $(this).find('.toolPanl').css("display", "none");
});

function loadLikeCount(likeType) {
    if (likeType == "like") {
        $("#like").attr("src", "/images/PromptImg/LikeMemberChoosed.png");
        $("#like").data("clicktag", 1);
    } else if (likeType == "dislike") {
        $("#fight").attr("src", "/images/PromptImg/fightingChoosed.png");
        $("#fight").data("clicktag", 1);
    }
}

layui.config({
    base: '/lib/layui/lay/extends/'
});
layui.use(['util'], function () {
    var util = layui.util;
    $('.layui-fixbar').remove();
    util.fixbar({
        bar1: '&#xe65c'
        , bgcolor: '#009688'
        , css: { right: 15, bottom: 30 }
        , click: function (type) {
            if (type === 'bar1') {
                pageToUrl('nagiveBar_introduction', '/Introduction/Home', function () { LoadPage(); $('.layui-fixbar').remove(); });
            }
        }
    });
});

/**************************************个人页-初始化*********************************************/

/**************************************个人页-点赞加油模块*******************************************/
function clickLike(loginId) {
    if (loginId <= 0) {
        layer.msg("请先登录");
        return false;
    }
    var fight_tag = $("#fight").data("clicktag");
    var like_tag = $("#like").data("clicktag");
    var fight = 0;
    var like = 0;
    if (like_tag == 0) {
        like = 1;
        $("#like").data("clicktag", 1);
        $("#like").attr("src", "/images/PromptImg/LikeMemberChoosed.png");
        if (fight_tag == 1) {
            fight = -1;
            $("#fight").data("clicktag", 0);
            $("#fight").attr("src", "/images/PromptImg/fighting.png");
        }
    } else if (like_tag == 1) {
        like = -1;
        $("#like").data("clicktag", 0);
        $("#like").attr("src", "/images/PromptImg/LikeMember.png");
    }
    clickLikeAndFlower(1, like, fight);
}

function clickFight(loginId) {
    if (loginId <= 0) {
        layer.msg("请先登录");
        return false;
    }
    var fight_tag = $("#fight").data("clicktag");
    var like_tag = $("#like").data("clicktag");
    var fight = 0;
    var like = 0;
    if (fight_tag == 0) {
        fight = 1;
        $("#fight").data("clicktag", 1);
        $("#fight").attr("src", "/images/PromptImg/fightingChoosed.png");
        if (like_tag == 1) {
            like = -1;
            $("#like").data("clicktag", 0);
            $("#like").attr("src", "/images/PromptImg/LikeMember.png");
        }
    } else if (fight_tag == 1) {
        fight = -1;
        $("#fight").data("clicktag", 0);
        $("#fight").attr("src", "/images/PromptImg/fighting.png");
    }
    clickLikeAndFlower(2, like, fight);
}

function clickLikeAndFlower(type, like, fight) {
    $.post("/introduction/member/clicklike", {
        memberId: $("#memberPageId").val(),
        type: type,
        like: like,
        fight: fight
    }, function (data) {
        if (data.success) {
            var likeCount = $(".likecount").text();
            var dislikeCount = $(".dislikecount").text();
            $('.likecount').text(parseInt(likeCount) + like);
            $('.dislikecount').text(parseInt(dislikeCount) + fight);
        }
    });
}

function clickLike1(loginId) {
    if (loginId <= 0) {
        layer.msg("请先登录");
        return false;
    }
    var fight_tag = $("#fight").data("clicktag");
    var like_tag = $("#like").data("clicktag");
    var fight = 0;
    var like = 0;
    if (like_tag == 0) {
        like = 1;
        if (fight_tag == 1) {
            fight = -1;
        }
    } else if (like_tag == 1) {
        like = -1;
    }
    clickLikeAndFlower1(1, like, fight);
}

function clickFight1(loginId) {
    if (loginId <= 0) {
        layer.msg("请先登录");
        return false;
    }
    var fight_tag = $("#fight").data("clicktag");
    var like_tag = $("#like").data("clicktag");
    var fight = 0;
    var like = 0;
    if (fight_tag == 0) {
        fight = 1;
        if (like_tag == 1) {
            like = -1;
        }
    } else if (fight_tag == 1) {
        fight = -1;
    }
    clickLikeAndFlower1(2, like, fight);
}

function clickLikeAndFlower1(type, like, fight) {
    $.post("/introduction/member/clicklike", {
        memberId: $("#memberPageId").val(),
        type: type,
        like: like,
        fight: fight
    }, function (data) {
        if (data.success) {
            var likeCount = $(".likecount").text();
            var dislikeCount = $(".dislikecount").text();
            $('.likecount').text(parseInt(likeCount) + like);
            $('.dislikecount').text(parseInt(dislikeCount) + fight);

            if (type == 1) {//点赞
                if (like == 1) {//点赞+1
                    $("#like").data("clicktag", 1);
                    $("#like").attr("src", "/images/PromptImg/LikeMemberChoosed.png");
                    if (fight == -1) {//加油-1
                        $("#fight").data("clicktag", 0);
                        $("#fight").attr("src", "/images/PromptImg/fighting.png");
                    }
                }
                else if (like == -1) {//取消点赞
                    $("#like").data("clicktag", 0);
                    $("#like").attr("src", "/images/PromptImg/LikeMember.png");
                }
            }
            else if (type == 2) {//加油
                if (fight == 1) {//加油+1
                    $("#fight").data("clicktag", 1);
                    $("#fight").attr("src", "/images/PromptImg/fightingChoosed.png");
                    if (like == -1) {//点赞-1
                        $("#like").data("clicktag", 0);
                        $("#like").attr("src", "/images/PromptImg/LikeMember.png");
                    }
                }
                else if (fight == -1) {//取消加油
                    $("#fight").data("clicktag", 0);
                    $("#fight").attr("src", "/images/PromptImg/fighting.png");
                }
            }
        }
    });
}

/**************************************个人页-点赞加油模块*******************************************/

/**************************************个人页-勋章模块*********************************************/
function addMedal(_memberPageId) {
    layer.open({
        resize: false,
        title: '授予勋章',
        type: 2,
        area: ['800px', '600px'],//宽高
        content: "/introduction/Medals/addmedal?memberId=" + _memberPageId,
        end: function () {
            loadMedal();
        }
    });
}

function loadMedal() {
    layui.use(['laytpl'], function () {
        var laytpl = layui.laytpl;
        $.get("/introduction/Medals/getmembermedal?memberId=" + $("#memberPageId").val(), function (data) {
            var getTpl = medalList.innerHTML
                , view = document.getElementById('medaldiv');
            laytpl(getTpl).render(data, function (html) {
                view.innerHTML = html;
            })
        });
    });
}

function showMedalGainLog(_medalId, _memberPageId) {
    layer.open({
        resize: false,
        title: '勋章授予记录',
        type: 2,
        area: ['700px', '565px'],//宽高
        content: "/introduction/Medals/MedalGainLogs?memberId=" + _memberPageId + "&medalId=" + _medalId
    });
}

/**************************************个人页-勋章模块*********************************************/