function save() {
    var _memberId = $("#txtMemberId").val();
    var score = $("#txtScore").val();
    var description = $("#txtDescription").val();
    var integralId = $("#txtIntegralId").val();
    var oldScore = $("#txtOldScore").val();
    var createdTime = $("#txtCreatedTime").val();
    var integrals = {
        Id: integralId,
        memberId: _memberId,
        integral: score,
        description: description,
        oldScore: oldScore,
        createdTime: createdTime
    };
    if (checkDataVaild(integrals)) {
        $.post("/introduction/integrals/saveintegral", integrals, function (data) {
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

function checkDataVaild(integrals) {
    var errorCount = 0;
    if (integrals.integral == "") {
        $("#error_score").css("display", "block");
        errorCount += 1;
    }
    if (integrals.description == "") {
        $("#error_desc").css("display", "block");
        errorCount += 1;
    }
    if (errorCount > 0) {
        return false;
    } else {
        return true;
    }
}

function onchangeEvent(e) {
    $(e).next().css("display", "none");
}