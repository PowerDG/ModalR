function save2(_memberPageId) {
        if ($("input[name='isupload']").val() == "0") {
        book.photo = "";
    }
    book.memberId = _memberPageId;
    book.id = $("#txtBookId").val();
    book.name = $("#txtName").val();
    book.author = $("#txtAuthor").val();
    book.lastcomment = $("#txtDescription").val();
        if (checkDataVaild(book)) {
        $.post("/introduction/readbooks/commentextrabook", book, function (data) {
            parent.layer.msg(data.message, {
                icon: 6,
                shift: -1,
                time: 500,
                shade: 0.3
            }, function () {
                parent.layer.closeAll();
                if (data.success) parent.layer.closeAll();
            });
        });
    }
}
 

 

function checkDataVaild(book) {
    var errorCount = 0;
    if (book.id <= 0 && book.photo == "") {
        $("#error_photo").css("display", "block");
        errorCount += 1;
    }
    if (book.name == "") {
        errorCount += 1;
        $("#error_name").css("display", "block");
    }
    if (book.author == "") {
        errorCount += 1;
        $("#error_author").css("display", "block");
    }
    if (errorCount > 0) {
        return false;
    } else {
        return true;
    }
    return true;
}

function onchangeEvent(e) {
    $(e).next().css("display", "none");
}

function loadUploadImg() {
    uploadImg("ImgUpload", function () {
        $("#bookPhoto").attr({ src: compressedImg });
        book.photo = compressedImg;
        book.photoHD = compressedImg;
        $("input[name='isupload']").val("1");
        $("#error_photo").css("display", "none");
    });
}