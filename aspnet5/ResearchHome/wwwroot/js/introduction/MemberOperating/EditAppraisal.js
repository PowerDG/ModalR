function save() {
    var appraisal = {
        Id: $("#txtAppraisalId").val(),
        memberId: $("#txtMemberId").val(),
        year: $("#txtYear").val(),
        appraisalType: $("#type").val(),
        performanceScore: $("#txtPerformanceScore").val(),
        valueScore: $("#txtValueScore").val(),
        appraisalLevel: $("#level").val(),
        totalScore: $("#TotalScore").text()
    };
    if (checkDataVaild()) {
        $.post("/introduction/appraisals/editappraisals", appraisal, function (data) {
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

function checkDataVaild() {
    var errorCount = 0;
    if ($("#txtYear").val() == "") {
        $("#error_year").css("display", "block");
        errorCount = errorCount + 1;
    }
    if ($("#type").val() == "") {
        $("#error_type").css("display", "block");
        errorCount = errorCount + 1;
    }
    var perforScore = $("#txtPerformanceScore").val();
    var valueScore = $("#txtValueScore").val();
    if (perforScore == "") {
        $("#error_performanceScore").css("display", "block");
        errorCount = errorCount + 1;
    }
    if (valueScore == "") {
        $("#error_valueScore").css("display", "block");
        errorCount = errorCount + 1;
    }
    var totalScore = parseFloat(perforScore) / 2 + parseFloat(valueScore) * 5 / 3;

    if ($("#level").val() == "") {
        $("#error_level").css("display", "block");
        errorCount = errorCount + 1;
    }
    if (totalScore > 100 || totalScore < 0) {
        $("#error_valueScore").css("display", "block");
        $("#error_performanceScore").css("display", "block");
        errorCount = errorCount + 1;
    }
    if (errorCount == 0) {
        return true;
    } else {
        return false;
    }
}

function onchangeEvent(e) {
    $(e).next().next().css("display", "none");
}
function onInputBlur(memberId) {
    var select;
    var perforScore = $("#txtPerformanceScore").val() > 0 ? $("#txtPerformanceScore").val() : 0;
    var valueScore = $("#txtValueScore").val() > 0 ? $("#txtValueScore").val() : 0;
    perforScore = parseFloat(perforScore) / 2;
    valueScore = parseFloat(valueScore) * 5 / 3;
    var totalScore = perforScore + valueScore;
    totalScore = totalScore.toFixed(2);
    $("#TotalScore").text(totalScore);
    if (valueScore >= 100) {
        $("#error_valueScore").css("display", "block");
    }
    if (totalScore > 100 || totalScore < 0) {
        $("#error_valueScore").css("display", "block");
        $("#error_performanceScore").css("display", "block");
        
    }
    if (parseFloat(totalScore) < 80) {
        select = 'dd[lay-value=' + 1 + ']';
        $("#level").val("低于预期");
    } else if (totalScore > 80.0 ) {
        select = 'dd[lay-value=' + 2 + ']';
    } else {
        select = 'dd[lay-value=' + 2 + ']';
    }
    $('#level').siblings("div.layui-form-select").find('dl').find(select).click();

}