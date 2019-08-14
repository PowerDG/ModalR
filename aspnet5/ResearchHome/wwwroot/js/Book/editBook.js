
layui.use(['jquery', 'element', 'rate'], function () {
    var $ = layui.$;
    var rate = layui.rate;
    rate.render({
        elem: '#score'
        , value: $('#score').text()
        , readonly: true
    });
})

function loadCommentTable(bookId) {
   
    layui.use(['jquery', 'element', 'table', 'rate'], function () {
        var $ = layui.$;
        var table = layui.table;
        var rate = layui.rate;
        var index = 0;
        var bookTable = table.render({
            elem: '#bookTable'
            , id: 'bookTable'
            , url: '/Book/Books/GetBookCommentsTable?bookId=' + bookId
            , page: true
            , skin: 'nob'
            , limit: 3
            , limits: [1,3]
            , cols: [[

                {
                    field: 'name', width: 520, style:'height:90px',templet: function (d) {
                        index++;
                        //console.log(d.count);
                        var commentInfo = $(`<div style="margin-left:10px;margin-right:10px;"><div><i>${d.Name}</i><i style="margin-left:10px;margin-right:15px;">${toDateString(d.create_time, 'YYYY-MM-DD')}</i><div style="display:inline-block;"><div id="likeLevel${index}">${d.score}</div></div>
                                        <div style="margin-left:10px;"title="${d.comment}">${d.comment.substring(0, 68)}</div></div>`);

                        return commentInfo.html();
                    }
                }

            ]]
            , done: function (d) {
                $('#commentcount').text(d.count);
                for (; index > 0; index--) {
                    rate.render({
                        elem: '#likeLevel' + index
                        , value: $('#likeLevel' + index).text()
                        , readonly: true
                        // , text: true
                        //, setText: function (value) {
                        //    var arrs = {
                        //        '1': '不好看'
                        //        , '2': '没营养'
                        //        , '3': '还行吧'
                        //        , '4': '不错哦'
                        //        , '5': '推荐！'
                        //    };
                        //    this.span.text(arrs[value] || (value + "星"));
                        //}
                    });
                };
            }
        });
    });
}
        

function save() {
    if ($("input[name='isupload']").val() == "0") {
        book.photo = "";
    }
    book.id = $("#txtBookId").val();
    book.name = $("#txtName").val();
    book.author = $("#txtAuthor").val();
    book.resource = $("#resource").val();
    if (checkDataVaild(book)) {
        $.post('/Book/Books/AddBook', book, function (d) {
            if (d.result) {
                parent.layer.msg(d.msg, { icon: 6, shift: -1, time: 500, shade: 0.3 },
                    function () { parent.layer.closeAll(); });
            }
            else {
                parent.layer.msg(d.msg, { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                    function () { parent.layer.closeAll(); });
            }
            
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
    if (book.resource == "") {
        errorCount += 1;
        $("#error_resource").css("display", "block");
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