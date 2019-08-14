

layui.use(['element', 'form', 'laydate'], function () {
    var form = layui.form
        , laydate = layui.laydate;
    laydate.render({
        elem: '#endTime'
        , type: 'datetime'
       //, value:''
    });
    laydate.render({
        elem: '#startTime'
        , type: 'datetime'
    });
    form.on('submit(ok)', function (data) {

        if (data.field.partyName.length > 24) {
            layer.msg("标题太长了哦！");
            return false;
        }

        if (!(data.field.money < 1000000 && data.field.money >= 0)) {
            layer.msg("检查花费金额数目！！");
            return false;
        }
        if (!(data.field.number < 100 && data.field.number > 0)) {
            parent.layer.msg('请输入正确的人数!',{icon: 5,shift: -1, time: 1000});
            return false;
        }
        if (!($('input[name=endTime]').val() > $('input[name=startTime]').val())) {
            parent.layer.msg('还没开始就结束了！', { icon: 5, shift: -1, time: 1000 });
            return false;
        }

        
        if (data.field.partyName.partyPlace > 8) {
            parent.layer.msg("请检查场所名称长度！");
            return false;
        }
        var tel = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
        var phone = /^1[23457689]\d{9}$/;
        var telphone = $('input[name=tel]').val();
        if (telphone != "" && !tel.test(telphone) && !phone.test(telphone)) {

            parent.layer.msg('请输入正确的电话号码！', { icon: 5, shift: -1, time: 1000 });
            return false;
        }
        if ($('input[name=address]').val().length > 50) {
            parent.layer.msg('地址太长！', { icon: 5, shift: -1, time: 1000 });
            errorCount += 1;
            return;
        }
        var url = '/PartyAndActivity/Parties/CreateParty';
        $.post(url, data.field, function (e) {
            if (e.result) {
                parent.layer.msg('添加成功!', { icon: 6, shift: -1, time: 1000, shade: 0.3 });
            } else {
                parent.layer.msg('添加失败,请重试！！', { icon: 5, shift: -1, time: 500 });
            }
        }, 'json')
        parent.layer.closeAll();
        return false; 
    });
});


var lon = $('#longitude').val()
var lat = $('#latitude').val();
var map;
if (lon > 0) {
    map = new AMap.Map('container', {
        zoom: 20,
        resizeEnable: true,
        center: [lon, lat],
        viewMode: '3D'
    });
} else {
    map = new AMap.Map('container', {
        zoom: 12,
        resizeEnable: true,
        viewMode: '3D'
    });
}
var autoOptions = {
    input: "partyPlace"
};
var auto = new AMap.Autocomplete(autoOptions);
var placeSearch = new AMap.PlaceSearch({
    map: map
}); 
AMap.event.addListener(auto, "select", select);//注册监听，当选中某条记录时会触发
function select(e) {
    placeSearch.setCity(e.poi.adcode);
    placeSearch.search(e.poi.name);  //关键字查询查询
    placeSearch.getDetails(e.poi.id, function (status,result) {
        //查询电话号码
        if (status === 'complete' && result.info === 'OK') {
            var poiArr = result.poiList.pois;
            $('#tel').val(poiArr[0].tel);
        }
    });
    $('#address').val(e.poi.address);
    $('#longitude').val(e.poi.location.lng);
    $('#latitude').val(e.poi.location.lat);
}
map.plugin('AMap.Geolocation', function () {
    var geolocation = new AMap.Geolocation({
        enableHighAccuracy: true,
        timeout: 10000,
        buttonOffset: new AMap.Pixel(10, 20),
        zoomToAccuracy: true,
        buttonPosition: 'RB'
    });
    map.center = geolocation;
    map.addControl(geolocation);
});
var geocoder, marker;
if (!marker) {
    marker = new AMap.Marker();
    map.add(marker);
}
var lnglat;
function regeoCode() {
    if (!geocoder) {
        geocoder = new AMap.Geocoder();
    }

    if (!marker) {
        marker = new AMap.Marker();
        map.add(marker);
    }
    marker.setPosition(lnglat);
    geocoder.getAddress(lnglat, function (status, result) {
        if (status === 'complete' && result.regeocode) {
            var address = result.regeocode.formattedAddress;
            $('#address').val(address);
            $('#longitude').val(lnglat.lng);
            $('#latitude').val(lnglat.lat);
        }
    });
    marker.setMap(map);
}
// marker.setPosition([lon, lat]);
map.on('click', function (e) {
    lnglat = e.lnglat;
    regeoCode();
})