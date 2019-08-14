window.onload = function () {
    loadMembers();
};

function loadMembers() {
    layui.use(['laytpl'], function () {
        var laytpl = layui.laytpl;
        $.get("/introduction/member/GetReentryMember", function (data) {
            var getTpl = memberList.innerHTML
                , view = document.getElementById('memberdiv');
            laytpl(getTpl).render(data, function (html) {
                view.innerHTML = html;
            })
        });
    });
}

function reenterMember(id) {
    layer.confirm('确定要回归吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/member/ReenterMember", { id }, function (data) {
            parent.layer.msg(data.message, {
                icon: 6,
                shift: -1,
                time: 500,
                shade: 0.3
            }, function () {
                if (data.success) {
                    parent.layer.closeAll();
                }
            });
        });
    }, function () { });
}

function pageToUrl(id) {
    parent.$("#entryMemberPageId").val(id);
    parent.layer.closeAll();
}
