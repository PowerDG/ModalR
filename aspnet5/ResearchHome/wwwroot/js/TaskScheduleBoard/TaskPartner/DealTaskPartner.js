function btnSubmit() {
    if ($('#partner option:selected').val() === '0') {
        $('#partnerError').css("display", "block");
        return false;
    }
    $('#partnerError').css("display", "none");
    $('#MemberId').val($('#partner option:selected').val());
    $('#addTaskParnerForm').submit();
}