window.onload = function () {
    var isAddOption = GetQueryString("optionTaskType") === "add";
    $('#updateTaskDescription').css("display", isAddOption ? "none" : "block");
}

function btnSubmit() {
    if ($('#ScoreError').css("display") === "block") return;
    $('#Score').val(parseInt($('#Score').val()));
    $('#MemberId').val($('#todoPerson option:selected').val());
    $('#MemberName').val($('#todoPerson option:selected').text());
    $('#Status').val($('#taskStatus option:selected').val());
    $('#optionTaskForm').submit();
}

function onchangeEvent(e, errorId) {
    $('#' + errorId).css("display", $(e).val() === "" ? "block" : "none");
}

function disabledEndTime() {
    if ($('#taskStatus option:selected').val() !== "完成") {
        $('#endTime').attr("disabled", true);
    }
}