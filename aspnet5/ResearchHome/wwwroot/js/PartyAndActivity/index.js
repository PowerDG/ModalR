var moneyResourceList = ["", "团队经费", "捐赠", "其他"];

layui.use(['jquery', 'element', 'table', 'util', 'rate'], function () {
    var $ = layui.$;
    var table = layui.table;
    var layer = layui.layer;
    var util = layui.util;
    var rate = layui.rate;
    var i = 0;
    $('.layui-fixbar').remove();
    util.fixbar({
        bgcolor: '#009688'
        , css: { right: 15, bottom: 30 }
    });
    
    var party=table.render({
        elem: '#partyTable'
        , id: 'partyTable'
        , url: '/PartyAndActivity/Parties/GetParties'
        , toolbar: '#partyTableToolbar'
        , defaultToolbar: []
        , skin: 'nob'
        , even: false
        , page: true
        , limit: 2
        , limits:[2,5,10]
        , cols: [[
            {
                field: 'PartyName', width: 620, style: 'height:330px;', templet: function (d) {
                    i++;
                    var currAuth;
                    if (d.isCanEdit) {
                        currAuth = `<img src="/images/PromptImg/Edit.png"onclick="editParty(${d.id})" style="width:16px;height:16px;vertical-align:middle;margin-bottom: 10px;margin-left:15px;"title="编辑" />`;
                    }
                    if (d.isCanDelete){
                        currAuth += `<img src="/images/PromptImg/Obsolete.png" onclick="deleteParty(${d.id})"style="width:16px;height:16px;vertical-align:middle;margin-bottom: 10px;margin-left:10px;" title="删除"/>`;
                    }
                    var partyInfo = $('<div><div style="margin-left:17px;">' +
                        '<div style="display: inline-block;"><span style="font-size:20px;">' + d.partyName + '</span>' + currAuth + '</div>'
                        + '<p><img src="/images/PromptImg/date.png" />' + toDateString(d.startTime, 'YYYY-MM-DD HH:mm') + '&nbsp;~&nbsp;' + toDateString(d.endTime, 'YYYY-MM-DD HH:mm') + '</p>'
                        + '<p style="overflow:hidden;white-space: nowrap;"><img src="/images/PromptImg/address.png" />' + d.partyPlace.substring(0, 15) + '<i style="font-style: italic;margin-left:10px;width:200px;">' + d.address.substring(0,20)  + '</i></p>'
                        + '<p><img src="/images/PromptImg/phone.png" />' + d.tel + '</p>'
                        + '<p><img src="/images/PromptImg/yuan.png" style="width:16px;height:16px;" />' + d.money + '大洋/' + d.number + '人&nbsp;-&nbsp;' + moneyResourceList[d.moneyResource] + '</p>'
                        + '<p style="margin-top:-3px;"><img src="/images/PromptImg/face.png" style="width:18px;height:18px;margin-top: 16px;" /><div id="likeLevel' + i + '">' + d.likeLevel + '</div><div style="display:none;">' + d.id + '</div>&nbsp;&nbsp;' + d.reviewTimes +'次</p>'
                        +'</div> </div>');
                    var review = $('<p><img src="/images/PromptImg/review.png" style="width:18px;height:18px;margin-left:15px;" /></p>');
                    for (var j = 0; j < d.reviews.length; j++) {
                        var reviewPart = `<div style="padding-left:8px;padding-right:8px; height:25px;line-height:25px;color:orange;border:solid 1px black;float:left;margin-left:10px;position:relative;left:-10px;top:5px;">${d.reviews[j].review}</div>`;
                        review.append(reviewPart);
                    }
                    partyInfo.append(review);
                    if (d.isCanEdit) {
                        partyInfo.append(`<img src="/images/PromptImg/Edit.png" onclick="showReview(${d.id})" style="width:16px;height:16px;vertical-align:middle;"title="添加评论" />`);
                    }
                    if (d.reviews.length >2) {
                        partyInfo.append(`<img src="/images/PromptImg/DetailMessage.png" onclick="showMoreReview(${d.id})" style="width:16px;height:16px;margin-left:8px;vertical-align:middle;" title="更多评论" />`);
                    }
                   return partyInfo.html();
                }
            }
            , {
                field: 'Photos', width: 660, style: 'height:330px;overflow:hidden', templet: function (d) {
                    var imgDiv = $('<div></div>');
                    
                    for (var i = 0; i < d.pics.length; i++) {
                        var picDiv = `<div style="float:left;margin-top:30px;margin-left: 50px;"><img onclick="previewPic('${d.pics[i].imgUrl}', layer)" style="width:150px;height:150px;cursor:pointer;" src="${d.pics[i].imgUrlPart}">
                            <div style="display: table-cell;width: 1%;text-align: center;height:50px;vertical-align: middle;"> ${d.pics[i].imgDescription} </div></div > `;
                        imgDiv.append(picDiv); 
                    }
                    if (d.isCanEdit) {
                        var addPartyImg = `<div style="float:left;width:150px;height:150px;margin-left:35px;margin-top:30px;border:solid 1px gray;" onclick="addPartyImg(${d.id});"><img style="width:22px;height:22px;margin:40%;" title="添加一张照片" src="/images/PromptImg/addImg.png"></img ></div>`;
                        imgDiv.append(addPartyImg); 
                    }
                    
                    return imgDiv.html();
                }
            }
            
        ]]
        , done: function () {
            $('#partyView').click();
           for (; i>0; i--) {
            rate.render({
                elem: '#likeLevel' + i
                , value: $('#likeLevel' + i).text()
                , text: true
                , setText: function (value) {
                    var arrs = {
                        '1': '垃圾'
                        , '2': '一般般'
                        , '3': '还行吧'
                        , '4': '不错哦'
                        , '5': '太棒了'
                    };
                    this.span.text(arrs[value] || (value + "星"));
                }
                , choose: function (value) {
                    var partyId = this.span.parent().next().text();
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        url: "/PartyAndActivity/Parties/UpdatePartyLikeLevel?value=" + value + '&&partyId=' + partyId,
                        success: function (data) {
                            if (data.result) {
                                parent.layer.msg('已评分!', { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () { parent.layer.closeAll(); });
                                //table.reload('partyTable');
                            } else {
                                parent.layer.msg(data.msg !== '' ? data.msg : '评分失败,请重试！！', { icon: 5, shift: -1, time: 500, shade: 0.3 });
                            }
                        }
                    });
                }
            });
            };
        }
    });
    var active = {
        reload: function () {
            var demoReload = $('#search');
            party.reload({
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
    
    table.on('toolbar(partyTable)', function (obj) {
        if (obj.event === "createparty") {
            layer.open({
                type: 2,
                title: "添加活动",
                resize: false,
                area: ['750px', '660px'],
                shadeClose: true,
                scrollbar: false,
                async: false,
                content: '/PartyAndActivity/Parties/CreateParty',
                end: function () {
                    location.reload();
                    $('#partyTable-btn button').each(function () {
                        $(this).addClass('layui-btn-primary');
                    });
                    $('button[lay-event="' + obj.config.where.queryType + '"]').removeClass('layui-btn-primary');
                }
            });
        }
        else {
            table.reload('partyTable', {
                where: {
                    queryType: obj.event
                }
                , page: {
                    curr: 1
                }
            });
            $('#partyTable-btn button').each(function () {
                $(this).addClass('layui-btn-primary');
            });
            $('button[lay-event="' + obj.event + '"]').removeClass('layui-btn-primary');
        }
    });

    //经费统计
    var funtab=table.render({
        elem: '#fundTable'
        , id: 'fundTable'
        , url: '/PartyAndActivity/Fund/GetFunds'
        , toolbar: '#fundTableToolbar'
        , defaultToolbar: []
        , page: { theme: 'green', limit: 20 }
        , limit: 20
        , cols: [[
            { type: 'numbers', title: '编号', width: 70 }
            , {
                field: 'time', title: '入账日期',width:170, templet: function (d) {
                    return toDateString(d.insertTime, 'YYYY-MM-DD HH:mm:ss');
                }
            }
            , {
                field: 'item', title: '事项', width: 280, templet: function (d) {
                    return '<div>' + d.itemName + '</div>';
                }
            }
            , {
                field: 'money', title: '金额', width: 140, templet: function (d) {
                    var style = 'style=" ';
                    if (d.operatMoney >0) {
                        style += 'color: green;"';
                        return '<div ' + style + '>+' + d.operatMoney + '</div>';
                    } else {
                        style += 'color:red;"';
                        return '<div ' + style + '>' + d.operatMoney+ '</div>';
                    }
                }
            }
            , {
                field: 'remainMoney', title: '操作完余额', width: 140, templet: function (d) {
                    var style = 'style="cursor: default;';
                    if (d.remainMoney < 0) {
                        style += 'color: red;';
                    } else {
                        style += 'color: green;';
                    }
                    style += '"';
                  
                    return '<div ' + style + '>' + d.remainMoney + '</div>';
                }
            }
            , {
                field: 'createdMemberId', title: '操作人', width: 85, templet: function (d) {
                    return '<div>'+d.name+'</div>';
                }
            }
            , {
                field: 'createTime', title: '备注', width: 320, templet: function (d) {
                    return d.description == null ? "" : d.description;
                }
            }
            , { field: 'toolUnit', title: '操作', width: 80, toolbar: '#fundToolUnitTemplet' }
        ]]
        , done: function () {
            var remainMoney = $($("#fundTable-tab .layui-table-body.layui-table-main tr :eq(10)")[0]).attr('data-content');
            console.log(remainMoney);
            var style = 'style="cursor: default;';
            if (remainMoney < 0) {
                style += 'color: red;';
            } else {
                style += 'color: green;';
            }
            style += '"';

            $('#remainMoney').html('<span ' + style + '>' + remainMoney + '</span>');
          
        }
    });
    table.on('toolbar(fundTable)', function (obj) {
        if (obj.event === "createfund") {
            layer.open({
                type: 2,
                title: '添加事项',
                resize: true,
                area: ['590px', '460px'],
                shadeClose: true,
                scrollbar: false,
                async: false,
                content: '/PartyAndActivity/Fund/CreateFund',
                end: function () {
                    table.reload('fundTable');
                    $('#fundTable-btn button').each(function () {
                        $(this).addClass('layui-btn-primary');
                    });
                    $('button[lay-event="' + obj.config.where.queryType + '"]').removeClass('layui-btn-primary');
                }
            });
        }
        else {
            table.reload('fundTable', {
                where: {
                    queryType: obj.event
                }
                , page: {
                    curr: 1
                }
            });
            $('#fundTable-btn button').each(function () {
                $(this).addClass('layui-btn-primary');
            });
            $('button[lay-event="' + obj.event + '"]').removeClass('layui-btn-primary');
        }
    });
    table.on('tool(fundTable)', function (obj) {
        var data = obj.data;
        if (obj.event === 'editfund') {
            editFund(data);
        } else if (obj.event === 'deletefund') {
            layer.confirm('确定删除该项吗？', { icon: 3, title: '提示' }, function (index) {
                $.ajax({
                    url: '/PartyAndActivity/Fund/DeleteFund?fundId=' + data.id
                    , type: 'post'
                    , async: false
                    , success: function (d) {
                        if (d.result) {
                            parent.layer.msg('删除成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                            table.reload('fundTable');
                        }
                        else {
                            parent.layer.msg('删除失败!', { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                                function () { parent.layer.closeAll(); });
                        }
                    }
                });
            });
        }
    });

    function editFund(data) {
        layer.open({
            type: 2,
            title: "编辑事项:",
            resize: false,
            area: ['600px', '500px'],
            shadeClose: true,
            scrollbar: false,
            async: false,
            content: '/PartyAndActivity/Fund/CreateFund?fundId=' + data.id,
            end: function () {
                table.reload('fundTable');
                
            }
        });
    }


});


function deleteParty(id) {
    layer.confirm('确定删除该项吗？', { icon: 3, title: '提示' }, function (index) {
        $.ajax({
            url: '/PartyAndActivity/Parties/DeleteReview?partyId=' + id
            , type: 'post'
            , async: false
            , success: function (d) {
                if (d.result) {
                    parent.layer.msg('删除成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                        function () { parent.layer.closeAll(); });
                    location.reload();
                }
                else {
                    parent.layer.msg('删除失败，请联系管理员', { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                        function () { parent.layer.closeAll(); });
                }
            }
        });
    });
}
function editParty(id) {
            layer.open({
                type: 2,
                title: "编辑活动",
                resize: false,
                area: ['750px', '720px'],
                shadeClose: true,
                scrollbar: false,
                async: false,
                content: '/PartyAndActivity/Parties/CreateParty?partyId=' + id,
                end: function () {
                    $('#partyTable-btn button').each(function () {
                        $(this).addClass('layui-btn-primary');
                    });
                }
            });
}
function showReview(id) {
    layer.open({
        type: 1,
        title: '评论',
        area: '350px',
        content: `<div><input type="text"  id="input_${id}" maxlength="10"  style="width:310px;margin:20px 10px 20px 20px;height:20px;" placeholder="请输入10字以内评语" /></div>
                   <div style="float:right;margin-right:25px;margin-bottom:10px;">
                       <button class="layui-btn layui-btn-sm" onclick="submitReview(${id})" style="float: right;margin-right:-10px;margin-bottom:5px;border-radius:15px;">提交</button>
                   </div>`
    });
}

function submitReview(id) {
    var text = $(`#input_${id}`).val();
    if (text.length>10) {
        parent.layer.msg('评语太长了呦', { icon: 5, shift: -1, time: 2000, shade: 0.3 },
            function () { parent.layer.closeAll(); });
        return;
    }
    $.ajax({
        url: '/PartyAndActivity/Parties/SubmitReview?partyId=' + id + '&&text=' + text
        , type: 'post'
        , success: function (d) {
            if (d.result) {
                parent.layer.msg('评论成功!', { icon: 6, shift: -1, time: 500, shade: 0.3 },
                    function () { parent.layer.closeAll(); });
                location.reload();
            }
            else {
                parent.layer.msg('无法评论，请联系管理员', { icon: 5, shift: -1, time: 2000, shade: 0.3 },
                    function () { parent.layer.closeAll(); });
            }
        }
    });
}

function showMoreReview(id) {

    $.post("/PartyAndActivity/Parties/showMoreReview?partyId=" + id, {}, function (str) {
        var reviewAll = $('<div>');
        for (var j = 0; j < str.reviews.length; j++) {
            var reviewPart = `<div style="padding-left:8px;padding-right:8px; height:25px;line-height:25px;color:orange;
                             border:solid 1px black;float:left;margin-left:20px;margin-top:20px;">${str.reviews[j].Review}</div>`;
            
            reviewAll.append(reviewPart);
        }
        reviewAll.append(`</div>`);
        layer.open({
            type: 1,
            title: '全部评论',
            area: ['500px', '500px'],
            content: reviewAll.html()

        });
    });
}
function addPartyImg(partyId) {
    var index = layer.open({
        type: 2,
        title: "新增活动",
        resize: false,
        area: ['500px', '500px'],
        shadeClose: true,
        async: false,
        content: '/PartyAndActivity/Parties/OptionPartyImg?partyId=' + partyId,
        end: function () {
            location.reload();
        }
    });
}
