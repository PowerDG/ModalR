function saveTitle(titleChangeId) {
    var _memberId = $("#txtMemberId").val();
    var oldTitle = $("#txtOldTitle").val();
    var newTitle = $("#txtNewTitle").val();
    var titleChange = {
        Id: titleChangeId,
        memberId: _memberId,
        oldTitle: oldTitle,
        newTitle: newTitle
    };
    if (checkDataVaild(titleChange)) {
        $.post("/introduction/title/changetitle", titleChange, function (data) {
            parent.layer.msg(data.message, {
                icon: 6,
                shift: -1,
                time: 500,
                shade: 0.3
            }, function () {
                if (data.success) parent.layer.closeAll();
            });
        });
    }
}

function checkDataVaild(titleChange) {
    if (titleChange.newTitle == "") {
        $("#error_title").css("display", "block");
        return false;
    }
    return true;
}

function onchangeEvent(e) {
    $(e).next().css("display", "none");
}
