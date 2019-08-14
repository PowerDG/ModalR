
var readbooklimitPage;
$("#booksContent").change(function (e) {
    readbooklimitPage = $(e.target).find("option:selected").attr('value');
});

function loadBooksTable() {
    layui.use(['table'], function () {
        var table = layui.table;
        var columns = [
            { type: 'numbers', title: '序号', width: 70 }
            , { field: 'Photo', title: '封面', style: "height:120px;width:120px;", width: 135, templet: "#bookImgTool" }
            , { field: 'Name', title: '书名', width: 200 }
            , { field: 'Author', title: '作者', width: 120 }
            , { field: 'create_time', title: '读完时间', width: 112, toolbar: '<p>{{toDateString(d.create_time,"YYYY-MM-DD")}}</p>' }
            , { field: 'Commentary', title: '描述', width: 330, toolbar: '#booksTable' }
        ];
        table.render({
            elem: '#table_books'
            , width: 960
            , url: '/introduction/readbooks/getreadbooks?memberId=' + $("#memberPageId").val()
            , page: true
            , limit: readbooklimitPage === undefined ? 5 : readbooklimitPage
            , limits: [5, 10, 20, 30, 100]
            , cols: [columns]
        });
    });
}

function editBooks(_memberPageId, bookId, title) {
    layer.open({
        resize: false,
        title: title,
        type: 2,
        area: ['600px', '450px'],//宽高
        content: "/introduction/readbooks/EditReadBook?memberId=" + _memberPageId + "&bookId=" + bookId,
        end: function () {
            loadBooksTable();
        }
    });
}

function deleteBook(id) {
    layer.confirm('确定要删除吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/ReadBooks/deletebook", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                loadBooksTable();
            };
        });
    }, function () { });
}

function strLength(str, end) {
    if (str.length > end) {
        return str.substr(0, end) + "...";
    }
    return str
}