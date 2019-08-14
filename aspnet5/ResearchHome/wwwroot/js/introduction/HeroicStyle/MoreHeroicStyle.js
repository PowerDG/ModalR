getHeroicStyleData();
function fileDownLoad(imgId, imgSrc) {
    if ($('#' + imgId).attr("src") === '/images/public/NonePicture.png') {
        layer.msg("图片缺失,请与管理员联系!", { icon: 2, shift: -1, time: 1000, shade: 0.3 });
        return;
    }
    window.location.href = '/FileOption/DownWebFile?imgSrc=' + imgSrc;
}

function getHeroicStyleData() {
    layui.use(['laytpl', 'laypage'], function () {
        var laytpl = layui.laytpl;
        var laypage = layui.laypage;
        console.log('xxxx');
        $.ajax({
            type: "POST",
            dataType: "json",
            url: "/Introduction/HeroicStyle/GetHeroicStylePicturesCount",
            success: function (data) {
                var count = data.picturesCount;
                laypage.render({
                    elem: 'picturesPaging'
                    , count: count
                    , limit: 15
                    , groups: 5
                    , layout: ['prev', 'page', 'next', 'count']
                    , prev: '<i class="layui-icon layui-icon-left"></i>'
                    , next: '<i class="layui-icon layui-icon-right"></i>'
                    , jump: function (obj) {
                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            url: "/Introduction/HeroicStyle/GetHeroicStyleByPaging",
                            data: { page: obj.curr, limit: obj.limit },
                            success: function (data) {
                                var heroicStyleMaster = document.getElementById('moreHeroicStyleMaster');
                                var getTpl = heroicStyleMaster.innerHTML;
                                var heroicStylePanel = document.getElementById('moreHeroicStylePartContent');
                                laytpl(getTpl).render(data, function (html) {
                                    heroicStylePanel.innerHTML = html;
                                });
                            }
                        });
                    }
                });
            }
        });
    });
}

function editHeroicStyle(eleId) {
    var index = layer.open({
        type: 2,
        title: "修改英雄风彩",
        resize: false,
        area: ['500px', '500px'],
        shadeClose: true,
        async: false,
        content: '/Introduction/HeroicStyle/OptionHeroicStyle?pictureId=' + eleId,
        end: function () {
            getHeroicStyleData();
        }
    });
}

function deleteHeroicStyle(eleId) {
    layer.confirm('确认删除?', { icon: 3, title: '删除提示' }, function (index) {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: "/Introduction/HeroicStyle/DeleteHeroicStyle",
            data: { pictureId: eleId },
            success: function (data) {
                if (data) {
                    layer.msg("删除成功!", { icon: 6, shift: -1, time: 500, shade: 0.3 }, function () { getHeroicStyleData(); });
                } else {
                    layer.msg("删除失败,请重试!", { icon: 5, shift: -1, time: 500, shade: 0.3 });
                }
            }
        });
        layer.close(index);
    });
}