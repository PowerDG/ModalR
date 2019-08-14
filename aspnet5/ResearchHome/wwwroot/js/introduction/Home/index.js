function LoadPage() {
    getIntroduceData();
    getMembersData();
    getHeroicStylePage();
    cleanLayUiIcon();
}
function getMembersData() {
    $.get("/introduction/member/memberlist", function (data) {
        $("#heroesPartContent").html(data);
    });
}

function getIntroduceData() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/Introduction/Home/GetIntroductionData",
        data: {},
        success: function (data) {
            $('#introductionTitle').empty().append(data.Title);
            $('#introductionContent').html(data.Content);
        }
    });
}

function getHeroicStylePage() {
    importPartContent("/Introduction/HeroicStyle/HeroicStyle", function (res) {
        $('#heroicStylePartContent').empty().append(res);
        heroicStyleFristLoad("showPart");
    });
}

function cleanLayUiIcon(parameters) {
    $('.layui-fixbar').remove();
}

function editIntroduction() {
    var index = layer.open({
        type: 2,
        title: "修改研究院介绍",
        area: ['600px', '600px'],
        shadeClose: true,
        async: false,
        content: "/Introduction/Home/EditIntroduction",
        end: function () {
            getIntroduceData();
        }
    });
}

function showEditMemberPage(id, title) {
    layer.open({
        resize: true,
        title: title,
        type: 2,
        scrollbar: false,
        area: ['800px', '655px'],//宽高
        content: "/introduction/member/editmember?id=" + id,
        end: getMembersData
    });
}

function showMoreMembers() {
    var index = layer.open({
        type: 2,
        title: "远行英雄",
        resize: false,
        area: ['960px', '800px'],
        shadeClose: true,
        async: false,
        content: '/Introduction/member/farawayhero',
        end: function () {
            var id = $("#entryMemberPageId").val();
            if (id != "") {
                pageToUrl('nagiveBar_introduction', '/introduction/member/memberrecord?id=' + id);
            } else {
                getMembersData();
            }
        }
    });
}

function addHeroicStyleData() {
    var index = layer.open({
        type: 2,
        title: "新增英雄风彩",
        resize: false,
        area: ['500px', '500px'],
        shadeClose: true,
        async: false,
        content: '/Introduction/HeroicStyle/OptionHeroicStyle',
        end: function () {
            getHeroicStyleData("showPart");
        }
    });
}

function showMoreHeroicStyle() {
    var index = layer.open({
        type: 2,
        title: "英雄风彩",
        resize: true,
        area: ['1186px', '777px'],
        shadeClose: true,
        scrollbar: false,
        content: '/Introduction/HeroicStyle/MoreHeroicStyle',
        end: function () {
            getHeroicStyleData();
        }
    });
}

function deleteMember(id) {
    layer.confirm('确认删除该英雄账号吗？英雄账号删除后将无法再登录系统！', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/member/deletemember", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                getMembersData()
            };
        });
    }, function () { });
}

function leaveMember(id, title) {
    layer.confirm('确认对该英雄账号做离职处理吗？离职的英雄账号将无法再登录系统！', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/member/leavemember", { id, title }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                getMembersData()
            };
        });
    }, function () { });
}