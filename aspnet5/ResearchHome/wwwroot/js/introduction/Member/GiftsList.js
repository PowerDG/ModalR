var giftslimitPage;
$(document).ready(function () {
    //loadGiftsTable();

    $("#giftsContent").change(function (e) {
        giftslimitPage = $(e.target).find("option:selected").attr('value');
    });
});

function loadGiftsTable() {
    layui.use(['table', 'layer'], function () {
        var table = layui.table;
        var columns = [
            { type: 'numbers', title: '序号', width: 50 }
            , { field: 'Name', title: '礼物', width: 307, templet: '#link' }
            , { field: 'Price', title: '价格', width: 150 }
            , { field: 'CreatedTime', title: '时间', width: 207, templet: '<p>{{toDateString(d.CreatedTime,"YYYY-MM-DD")}}</p>' }
            , { field: 'CreatedMemberName', title: '记录人', width: 240, templet: '#giftsTable' }
        ];
        table.render({
            elem: '#table_gifts'
            , width: 960
            , url: '/introduction/gifts/getgiftsrecord?id=' + $("#memberPageId").val()
            , page: true
            , limit: giftslimitPage === undefined ? 5 : giftslimitPage
            , limits: [5, 10, 20, 30, 100]
            , cols: [columns]
        });
    });
}

function editGift(_memberPageId, giftId, title) {
    layer.open({
        resize: false,
        title: title,
        type: 2,
        area: ['400px', '370px'],//宽高
        content: "/introduction/gifts/editgift?memberId=" + _memberPageId + "&giftId=" + giftId,
        end: function () {
            loadGiftsTable();
        }
    });
}

function deleteGift(id) {
    layer.confirm('确定要删除吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/gifts/delete", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                loadGiftsTable()
            };
        });
    }, function () { });
}