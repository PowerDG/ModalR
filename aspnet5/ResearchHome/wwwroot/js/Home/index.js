function setScrollPositon() {
    var scrollTop = $.cookie('scrollTop');
    if (scrollTop !== undefined) {
        $('body,html').animate({ scrollTop: scrollTop }, 50);
    }
}

window.onresize = function () {
    $('#ContentCenter').css("min-height", ($(window).height() - 170) + "px");
    $('#NoAuthShowPart').css("padding-top", (($(window).height() - 170 - 310) / 2) + "px");
}

$(window).scroll(function (s, e) {
    $.cookie('scrollTop', getScrollTop(), { path: '/' });
});

function getScrollTop() {
    var scrollPos;
    if (window.pageYOffset) {
        scrollPos = window.pageYOffset;
    }
    else if (document.compatMode && document.compatMode != 'BackCompat') { scrollPos = document.documentElement.scrollTop; }
    else if (document.body) { scrollPos = document.body.scrollTop; }
    return scrollPos;
}

function showClickStyle(eleId) {
    $('#nagiveBar li').each(function () { $(this).removeClass("layui-this"); });
    $('#' + eleId).addClass("layui-this");
}


function loginPage() {
    var index = layer.open({
        type: 2,
        title: "用户登录",
        resize: false,
        area: ['600px', '550px'],
        shadeClose: true,
        async: false,
        content: '/Authorization/Login',
        end: function () {
            window.location.reload();
        }
    });
}

function logoutEvent() {
    layer.confirm('确认退出当前账号?', { icon: 3, title: '退出提示' }, function (index) {
        location.href = '/Authorization/Logout';
    });
}

function changePassword() {
    var index = layer.open({
        type: 2,
        title: "密码修改",
        resize: false,
        area: ['500px', '400px'],
        shadeClose: true,
        async: false,
        content: '/Authorization/VerificationPassword',
        end: function () {
        }
    });
}