
layui.use(['jquery', 'element', 'table', 'rate'], function () {
    var $ = layui.$;
    var table = layui.table;
    var layer = layui.layer;
    var rate = layui.rate;
    var index = 0;
    var bookTable = table.render({
        elem: '#bookTable'
        , id: 'bookTable'
        , url: '/Book/Books/GetBooks'
        , toolbar: '#bookTableToolbar'
        , defaultToolbar: []
        , page: { theme: 'green', limit: 20 }
        , limit: 20
        , cols: [[
            { type: 'numbers', title: '编号', width: 40 }
            , {
                field: 'name', title: '书名', width: 215, templet: function (d) {
                    if (d.state===2) {
                        return '<div style="color:lightgray;cursor: pointer" lay-event="editbook">' + d.name + '</div>';
                    }
                    return '<div style="cursor: pointer" lay-event="editbook">' + d.name + '</div>';
                }
            }
            , {
                field: 'photo', title: '封面', style: "height:110px;width:90px;", width: 130, templet: "#bookImgTool"
               
            }
            , {
                field: 'author', title: '作者', width: 145, templet: function (d) {
                    if (d.state === 2) {
                        return '<div style="color:lightgray;">' + d.author + '</div>';
                    }
                    return '<div >' + d.author + '</div>';
                }
            }
            , {
                field: 'time', title: '加入时间', width: 110, templet: function (d) {
                    if (d.state === 2) {
                        return '<div style="color:lightgray;">' + toDateString(d.create_time, 'YYYY-MM-DD') + '</div>';
                    }
                    return toDateString(d.create_time, 'YYYY-MM-DD');
                } 
            }
            , {
                field: 'score', title: '评分', width: 160, templet: function (d) {
                    index++;
                    return '<div><div id="likeLevel' + index + '">' + d.average_score + '</div>';
                }
            }
            , {
                field: 'lastComment', title: '最新评价', width: 308, templet: function (d) {
                    var comment=d.last_comment == null ? "" : d.last_comment;
                    if (d.state === 2) {
                        return `<div style="white-space: unset;color:lightgray;"title="${comment}">${comment.substring(0, 78)}</div>`;
                    }
                    return `<div style="white-space: unset;"title="${comment}">${comment.substring(0,78)}</div>`;
                }
            }
            , {
                field: 'reading', title: '阅读中', width: 74, templet: function (d) {
                    if (d.member.length == 0) {
                        return "";
                    }
                    return `<img src="${d.member[0].photo }" style="width:36px;height:36px;" />`;
                }
            }
            , { field: 'toolUnit', title: '操作', width: 90, toolbar: '#bookToolUnitTemplet' }
        ]]
        , done: function () {
            for (; index > 0; index--) {
                rate.render({
                    elem: '#likeLevel' + index
                    , value: $('#likeLevel' + index).text()
                    ,readonly:true
                });
            };
        }
    });
    var active = {
        reload: function () {
            var demoReload = $('#search');
            bookTable.reload({
                where: {
                    search: demoReload.val()
                }
            });
        }
    };

    $('#searchBtn').on('click', function () {
        var type = $(this).data('type');
        active[type] ? active[type].call(this) : '';
    });
    $('#search').bind('keyup', function (event) {
        if (event.keyCode == "13") {
            $('#searchBtn').click();
        }
    });

    table.on('toolbar(bookTable)', function (obj) {
        if (obj.event === "addBook") {
            layer.open({
                type: 2,
                anim: 4,
                title: "添加图书",
                resize: false,
                area: ['400px', '465px'],
                shadeClose: true,
                scrollbar: false,
                async: false,
                content: '/Book/Books/AddBook',
                end: function () {
                    table.reload('bookTable');
                    $('#bookTable-btn button').each(function () {
                        $(this).addClass('layui-btn-primary');
                    });
                    $('button[lay-event="' + obj.config.where.queryType + '"]').removeClass('layui-btn-primary');
                }
            });
        }
        else {
            table.reload('bookTable', {
                where: {
                    queryType: obj.event
                }
                , page: {
                    curr: 1
                }
            });
            $('#bookTable-btn button').each(function () {
                $(this).addClass('layui-btn-primary');
            });
            $('button[lay-event="' + obj.event + '"]').removeClass('layui-btn-primary');
        }
    });

    table.on('tool(bookTable)', function (obj) {
        var data = obj.data;
        if (obj.event === 'editbook') {
            editBook(data);
        } else if (obj.event === 'borrowbook') {
            borrowBook(data);
        } else if (obj.event === 'lostbook') {
            lostBook(data);
        } else if (obj.event ==='reviewbook') {
            reviewBook(data);
        }
    });

    function reviewBook(data) {
        layer.open({
            type: 2,
            title: "添加评价",
            anim: 2,
            resize: false,
            area: ['455px', '390px'],
            shadeClose: true,
            scrollbar: false
            , content: '/Book/Books/CommentBook?bookId=' + data.id 

        });
    }

    function lostBook(data) {
        layer.open({
            type: 1,
            anim: 2,
            title: "书籍丢失处理",
            resize: false,
            area: ['400px', '310px'],
            shadeClose: true,
            scrollbar: false,
            btn: ['丢失', '取消']
            , yes: function () {
                var lostCause = $('#txtDescription').val();
                
                $.ajax({
                    url: '/Book/Books/LostBook?bookId=' + data.id + '&lostCause=' + lostCause
                    , type: 'post'
                    , success: function (d) {
                        if (d.result) {
                            parent.layer.msg('操作成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                            table.reload('bookTable');
                        }
                        else {
                            parent.layer.msg('操作失败，请联系管理员!', { icon: 5, shift: -1, time: 1000, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                        }
                    }
                });
            }
            , btn2: function () {
                layer.closeAll();
                table.reload('bookTable');
            }
            , content: `<div class="layui-form-item" style="margin-left:-15px;margin-top:20px;">
                        <label class="layui-form-label">原因</label>
                        <div class="layui-input-block" style="width:450px;width:250px;">
                             <textarea id="txtDescription" rows="8" maxlength="200" required lay-verify="required" placeholder="请输入原因" class="layui-textarea"></textarea>
                         </div>
                      </div>`
            
        });
    }

    function borrowBook(data) {
        layer.confirm('确定借阅这本书吗？', { icon: 3, title: '提示' }, function (index) {
            $.ajax({
                url: '/Book/Books/BorrowBook?bookId=' + data.id
                , type: 'post'
                , success: function (d) {
                    if (d.result) {
                        parent.layer.msg('借阅成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                            function () { parent.layer.closeAll(); });
                        table.reload('bookTable');
                    }
                    else {
                        parent.layer.msg('借阅失败，请联系管理员!', { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                            function () { parent.layer.closeAll(); });
                    }
                }
            });
        });
    }
    
    function editBook(data) {
        layer.open({
            type: 2,
            title: "书籍详情",
            resize: false,
            area: ['600px','800px'],//'600px',
            //offset: '10%',
            anim: 3,
            shadeClose: true,
            scrollbar: false,
            async: false,
            content: '/Book/Books/EditBook?bookId=' + data.id,
        });
    }
    
});