function preImg() {
    uploadImg("uploadImgHideBtn", function () {
        $("#uploadImg").attr({ src: compressedImg });
        model.UploadImg = compressedImg;
        $('#uploadImgError').css("display", "none");
    });
}

function deleteImg() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/FileOption/DeleteFile",
        data: {
            fileUrl: $("#uploadImg").attr("src")
        },
        success: function (data) {
        }
    });
}

function descriptionOnblur() {
    var description = $('#Description').val();
    if (description === '') {
        $('#DescriptionErrorSpan').html('是不是要说些什么呢');
        $('#DescriptionError').css("display", "block");
    } else if (description.length > 40) {
        $('#DescriptionErrorSpan').html('说明不要超过40个字哟');
        $('#DescriptionError').css("display", "block");
    } else {
        $('#DescriptionError').css("display", "none");
        model.Description = description;
    }
}

function layerSubmit() {
    $('#uploadImgError').css("display", $('#uploadImg').attr("src") !== ''
        && $('#uploadImg').attr("src") !== '/images/public/NonePicture.png'
        ? "none" : "block");
    descriptionOnblur();
    if ($('#uploadImg').attr("src") === ''
        || $('#uploadImg').attr("src") === '/images/public/NonePicture.png'
        || $('#Description').val() === ''
        || $('#Description').val().length > 40) {
        return;
    }
    var url = parseInt(model.Id) === 0 ? "/Introduction/HeroicStyle/InsertHeroicStyle" : "/Introduction/HeroicStyle/UpdateHeroicStyle";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: url,
        async: false,
        data: {
            picturesModel: model
        },
        success: function (data) {
            if (data.result) parent.layer.msg('操作成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () { parent.layer.closeAll(); });
            else {
                parent.layer.msg(data.msg !== '' ? data.msg : '操作失败,请重试！！', { icon: 5, shift: -1, time: 500, shade: 0.3 });
            }
        }
    });
}

function layerExit() {
    parent.layer.closeAll();
}