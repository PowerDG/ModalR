function loadPage(actionType, photoHD, gender) {
    layui.use(["form", 'laydate'], function () {
        var form = layui.form;
        var laydate = layui.laydate;
        laydate.render({
            elem: '#entrytime',
            done: function (value, date, endDate) {
                $('#error_entrytime').css("display", "none");
            }
        });
        laydate.render({
            elem: '#birthday',
            done: function (value, date, endDate) {
                $('#error_birthday').css("display", "none");
            }
        });
        if (actipnType == "Edit") {
            if (gender == "True") {
                $("#rdMale").attr("checked", "checked");
                $("#rdFemale").removeAttr("checked");
            } else {
                $("#rdMale").removeAttr("checked");
                $("#rdFemale").attr("checked", "checked");
            }
            $("input[name='title']").attr("disabled", "disabled").attr("readonly", "readonly");
            form.render();
        } else {
            $("input[name='name']").on("blur", function () {
                getpinyin();
            });
        }
        member = { actionType : actionType, photoHD : photoHD };
    });
}

function loadUploadImg() {
    uploadImg("ImgUpload", function () {
        $("#imgHeadPhoto").attr("src", compressedImg);
        member.photo = compressedImg;
        member.photoHD = compressedImg;
        $("input[name='isupload']").val("1");
    });
}

function saveMember() {
    if (!checkDataVaild()) {
        return false;
    }
    member.id = $("input[name='id']").val();
    member.name = $("input[name='name']").val();
    member.entryTime = $("input[name='entrytime']").val();
    member.gender = $("input[name=gender]:checked").val() == "1";
    member.title = $("input[name='title']").val();
    member.remarks = $("textarea[name='remarks']").val();
    member.account = $("input[name='account']").val();
    member.qq = $("input[name='qq']").val();
    member.phone = $("input[name='phone']").val();
    member.wechat = $("input[name='wechat']").val();
    member.birthday = $("input[name='birthday']").val();
    member.email = $("input[name='email']").val();
    member.aliasName = $("input[name='aliasName']").val();
    member.hobby = $("input[name='hobby']").val();
    member.motto = $("textarea[name='motto']").val();
    member.label = $("textarea[name='label']").val();
    if ($("input[name='isupload']").val() == "0") {
        member.photo = "";
    }
    $.post("/introduction/member/editmember", member, function (data) {
        if (data.success) {
            layer.open({
                title: "操作结果",
                content: data.message,
                yes: function () {
                    parent.layer.closeAll();
                }
            });
        } else {
            layer.msg(data.message);
        }
    });
}

function checkDataVaild() {
    var errorCount = 0;
    $("#error_name").css("display", $("input[name='name']").val() == "" ? "block" : "none");
    $("#error_entrytime").css("display", $("input[name='entrytime']").val() == "" ? "block" : "none");
    $("#error_title").css("display", $("input[name='title']").val() == "" ? "block" : "none");
    $("#error_birthday").css("display", $("input[name='birthday']").val() == "" ? "block" : "none");
    $("#error_account").css("display", $("input[name='account']").val() == "" ? "block" : "none");
    return $("input[name='name']").val() !== "" && $("input[name='entrytime']").val() !== ""
        && $("input[name='title']").val() !== "" && $("input[name='birthday']").val() !== ""
        && $("input[name='account']").val() !== "";
}

function onchangeEvent(e, errorId) {
    $('#' + errorId).css("display", $(e).val() === "" ? "block" : "none");
}

function resetPassword() {
    layer.confirm('确定要重置密码吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/member/ResetPassword", { memberId: $("input[name='id']").val() }, function (data) {
            if (data.success) {
                //$("#password").data("clipboard-text", data.password);
                layer.open({
                    title: "操作结果",
                    content: data.message,
                    yes: function () {
                        //console.log($("#password").data("clipboard-text"));
                        //var clipboard = new ClipboardJS("#password");
                        //layer.msg("密码已复制");
                        parent.layer.closeAll();
                    }
                });
            } else {
                layer.msg(data.message);
            }
        });
    }, function () { });
}

function getpinyin() {
    var name = $("input[name='name']").val();
    if (name.length > 0) {
        $.get("/introduction/member/GetPinYin?name=" + name, function (data) {
            $("input[name='account']").val(data);
            $("#error_account").css("display", "none");
        });
    } else {
        $("input[name='account']").val("");
        $("#error_account").css("display", "block");
    }
}