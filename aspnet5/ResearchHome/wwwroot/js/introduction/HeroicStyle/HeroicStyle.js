var _showStyle;
function heroicStyleFristLoad(showStyle) {
    _showStyle = showStyle;
    getHeroicStyleData();
}

function fileDownLoad(imgId, imgSrc) {
    if ($('#' + imgId).attr("src") === '/images/public/NonePicture.png') {
        layer.msg("图片缺失,请与管理员联系!", { icon: 2, shift: -1, time: 1000, shade: 0.3 });
        return;
    }
    window.location.href = '/FileOption/DownWebFile?imgSrc=' + imgSrc;
}

function getHeroicStyleData() {
    layui.use(['laytpl','flow'], function () {
        var laytpl = layui.laytpl;
        var flow = layui.flow;
        $.ajax({
            type: "POST",
            dataType: "json",
            data: { showStyle: _showStyle },
            url: "/Introduction/HeroicStyle/GetHeroicStyleData",
            success: function (data) {
                if (data === null) return;
                var heroicStyleMaster = document.getElementById('heroicStyleMaster');
                var getTpl = heroicStyleMaster.innerHTML;
                var heroicStylePanel = document.getElementById('heroicStylePanel');
                laytpl(getTpl).render(data, function (html) {
                    heroicStylePanel.innerHTML = html;
                });
                flow.lazyimg();
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

//点击英雄风采图片进行轮播展示
//function carouselDisplay(imageId, pageLayer) {
//    layui.use(['laytpl', 'carousel'], function () {
//        var laytpl = layui.laytpl;
//        var carousel = layui.carousel;
//        $.ajax({
//            type: "POST",
//            dataType: "json",
//            data: { showStyle: _showStyle },
//            url: "/Introduction/HeroicStyle/GetHeroicStyleData",
//            success: function (data) {
//                if (data === null) return;
//                var heroicStyle = document.getElementById('carouselDisplayHeroicStylePic');
//                var getTpl = heroicStyle.innerHTML;
//                laytpl(getTpl).render(data, function (html) {
//                    var index = pageLayer.open({
//                        type: 1,
//                        title: "",
//                        closeBtn: 1,
//                        shadeClose: true,
//                        content: html,
//                        area: ["-moz-fit-content", ""],
//                        success: function (layero, index) {
//                            carousel.render({
//                                elem: '#carouselHeroicStyle'
//                                , width: '800px'
//                                , height: '440px'
//                                , interval: 5000
//                                //, full:true
//                            });
//                        }
//                    });
//                });
//            }
//        });
//    });
//}

//function carouselDisplay2(picid, showStyle) {
//    //$.post('/Introduction/HeroicStyle/GetHeroicStylePic', { currentPicId: picid, showStyle:showStyle },
//    //    function (data, status) {
//    //        layui.use(['layer'], function () {
//    //            layer.photos({
//    //                photos: data
//    //                , anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
//    //            }); 
//    //    });
//    //    });


//    $.ajax({
//        type: "POST",
//        dataType: "json",
//        url: "/Introduction/HeroicStyle/GetHeroicStylePic",
//        data: { currentPicId: picid, showStyle: showStyle },
//        success: function (data) {
//            layui.use(['layer'], function () {
//                layer.photos({
//                    photos: data
//                    , anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
//                }); 
//        }
//    });

//}
