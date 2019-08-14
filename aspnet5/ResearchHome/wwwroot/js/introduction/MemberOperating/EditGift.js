function save() {
    var _memberId = $("#txtMemberId").val();
    var name = $("#txtName").val();
    var price = $("#txtPrice").val();
    var link = $("#txtHyperlink").val();
    if (link != "" && (link.search("http://") == -1 && link.search("https://") == -1)) {
        link = "https://" + link;
    }
    var giftId = $("#txtGiftId").val();
    var gift = {
        Id: giftId,
        memberId: _memberId,
        name: name,
        price: price,
        hyperlink: link
    };
    if (checkDataVaild(gift)) {
        $.post("/introduction/gifts/editgift", gift, function (data) {
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

function checkDataVaild(gift) {
    if (gift.name == "") {
        $("#error_name").css("display", "block");
        return false;
    }
    return true;
}

function onchangeEvent(e) {
    $(e).next().css("display", "none");
}