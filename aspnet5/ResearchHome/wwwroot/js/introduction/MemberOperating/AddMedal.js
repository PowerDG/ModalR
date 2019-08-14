
function selectDiv(target) {
    $('.layui-col-medal').each(function () { $(this).removeClass("select-medal"); })
    $(target).addClass("select-medal");
    var id = $(target).data("id");
    $("input[name='selectMedal']").val(id);
}

function loadMedals() {
    layui.use(['laytpl'], function () {
        var laytpl = layui.laytpl;
        $.get("/SkillsAndMedals/home/List", function (data) {
            var getTpl = medalList.innerHTML
                , view = document.getElementById('medaldiv');
            laytpl(getTpl).render(data, function (html) {
                view.innerHTML = html;
            })
        })
    });
}

function save() {
    var selectVal = $("input[name='selectMedal']").val();
    if (selectVal <= 0) {
        layer.msg("请选择勋章");
        return false;
    }
    layer.prompt({
        formType: 2,
        value: ' ',
        title: '请输入授予理由',
        area: ['300px', '100px']
    }, function (value, index, elem) {
        if (value == " ") {
            layer.tips("请输入授予理由", ".layui-layer-input");
            return false;
        }
        var model = {
            memberId: memberPageId,
            medalId: selectVal,
            reason: value
        };
        $.post("/introduction/medals/addmembermedal", model, function (data) {
            parent.layer.msg(data.message, {
                icon: 6,
                shift: -1,
                time: 500,
                shade: 0.3
            }, function () {
                if (data.success) parent.layer.closeAll();
            });
        });

    });
}