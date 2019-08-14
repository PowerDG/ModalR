//页面初始
var dataLoadingEvt;
var layer;
$(function () {
    document.onreadystatechange = subSomething;
    layui.use(['layer', 'form'], function () {
        layer = layui.layer
            , form = layui.form;
    });
    function subSomething() {
        if (document.readyState == "complete") { //当页面加载状态为完全结束时隐藏加载动画
            HideLoading(); //加载完后关闭
        }
    }
    dataLoadingEvt = setTimeout(HideLoading, 1000);
});

//隐藏Loading
var HideLoading = function () {
    $('#loading').hide();
    clearTimeout(dataLoadingEvt);
}

function previewPic(imgSrc, pageLayer) {
    var img = new Image();
    img.src = imgSrc;
    var divDocument = document.createElement("div");
    divDocument.appendChild(img);

    if (img.complete) {
        var index = pageLayer.open({
            type: 1,
            title: "",
            closeBtn: 1,
            shadeClose: true,
            content: divDocument.innerHTML,
            area: ["-moz-fit-content", ""],
            end: function () {
            }
        });
        return;
    }

    img.onload = function () {
        var index = pageLayer.open({
            type: 1,
            title: "",
            closeBtn: 1,
            shadeClose: true,
            content: divDocument.innerHTML,
            area: ["-moz-fit-content", ""],
            end: function () {
            }
        });
    };
}

var compressedImg;
function uploadImg(eleId, callBack) {
    var img = new Image();
    var divDocument = document.createElement("div");
    divDocument.appendChild(img);
    var imageSrc;
    if (typeof FileReader == 'undefined') {
        var picsrc = getPath(document.all.fileid);
        img.src = picsrc;
    } else {
        var reader = new FileReader();
        reader.onload = function (e) {
            img.src = this.result;
        }
        reader.readAsDataURL(document.getElementById(eleId).files[0]);
    }
    img.onload = function () {
        // 图片原始尺寸
        var originWidth = this.width;
        var originHeight = this.height;
        // 最大尺寸限制
        var maxWidth = 1440, maxHeight = 900;
        // 目标尺寸
        var targetWidth = originWidth, targetHeight = originHeight;
        // 图片尺寸超过400x400的限制
        if (originWidth > maxWidth || originHeight > maxHeight) {
            if (originWidth / originHeight > maxWidth / maxHeight) {
                // 更宽，按照宽度限定尺寸
                targetWidth = maxWidth;
                targetHeight = Math.round(maxWidth * (originHeight / originWidth));
            } else {
                targetHeight = maxHeight;
                targetWidth = Math.round(maxHeight * (originWidth / originHeight));
            }
        }
        var canvas = document.createElement("canvas");
        canvas.width = targetWidth;
        canvas.height = targetHeight;
        var ctx = canvas.getContext("2d");
        ctx.drawImage(img, 0, 0, targetWidth, targetHeight);
        var imageType = img.src.split(';')[0].replace("data:", "");
        compressedImg = canvas.toDataURL(imageType, 0.5);
        if (callBack !== undefined) {
            callBack();
        }
    }
}

function uploadOrgImg(eleId, callBack) {
    var img = new Image();
    var divDocument = document.createElement("div");
    divDocument.appendChild(img);
    var imageSrc;
    if (typeof FileReader == 'undefined') {
        var picsrc = getPath(document.all.fileid);
        img.src = picsrc;
    } else {
        var reader = new FileReader();
        reader.onload = function (e) {
            img.src = this.result;
        }
        reader.readAsDataURL(document.getElementById(eleId).files[0]);
    }

    img.onload = function () {
        compressedImg = img.src;
        if (callBack !== undefined) {
            callBack();
        }
    }
}

// 获取本地上传的照片路径
function getPath(obj) {
    if (obj) {
        //ie
        if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
            obj.select();
            // IE下取得图片的本地路径
            return document.selection.createRange().text;
        }
        //firefox
        else if (window.navigator.userAgent.indexOf("Firefox") >= 1) {
            if (obj.files) {
                // Firefox下取得的是图片的数据
                return obj.files.item(0).getAsDataURL();
            }
            return obj.value;
        }
        return obj.value;
    }
}

function importPartContent(Url, callBack) {
    $.ajax({
        url: Url,
        dataType: 'html',
        type: 'get',
        async: false,
        success: function (res) {
            callBack(res);
        },
        error: function (res) {
        }
    });
}

//获取URL参数
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg); //获取url中"?"符后的字符串并正则匹配
    var context = "";
    if (r != null)
        context = r[2];
    reg = null;
    r = null;
    return context == null || context == "" || context == "undefined" ? "" : context;
}

//时间格式请参照moment.js
function toDateString(time, format) {
    format = format || 'YYYY-MM-DD HH:mm';
    var result = moment(time).format(format);
    if (typeof (time) == "undefined" || typeof (time) == "object")
        result = "--";
    return result;
}

function SelectBind(Controller, CrotrolId, Key, Text, SelectKey, SelectedMaxHeight, Form, dataWhere) //控制器(自定义),控件Id,值,内容,默认选中内容,重新加载
{
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/Select/" + Controller,
        data: dataWhere,
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                if (data[i][Key] == SelectKey) //判断是否是默认选中
                {
                    $('#' + CrotrolId).append("<option value='" + data[i][Key] + "' selected>" + data[i][Text] + "</option>");
                } else {
                    $('#' + CrotrolId).append("<option value='" + data[i][Key] + "'>" + data[i][Text] + "</option>");
                }
            }
            Form.render();
            if (SelectedMaxHeight !== null) {
                var dlList = document.getElementsByClassName("layui-anim layui-anim-upbit");
                if (dlList.length > 0) dlList[0].style.maxHeight = SelectedMaxHeight;
            }
        }
    });
}

function setSortStyle(eleId, sortDataArray) {
    $('#' + eleId).parent().find('.layui-table-header>table>thead>tr>th').each(function () {
        if ($(this).attr("data-field") === sortDataArray.field) {
            if (sortDataArray.type.toLocaleLowerCase() === "desc") {
                $($(this).find('.layui-table-sort-desc')[0]).css('border-top-color', '#666');
            } else {
                $($(this).find('.layui-table-sort-asc')[0]).css('border-bottom-color', '#666');
            }
        }
    });
}

function setPageTableIndex(eleId) {
    $('#' + eleId + ' .layui-table-body>table>tbody>tr').each(function () {
        var nowPageRowNum = parseInt($(this).attr("data-index")) + 1;
        var nowPage = parseInt($('#' + eleId + ' .layui-laypage-curr>em').get(1).innerHTML);
        var limit = parseInt($('#' + eleId + ' .layui-laypage-limits>select>option[selected]').val());
        $(this).find('td[data-field="Index"]>div').html(parseInt((nowPage - 1) * limit + nowPageRowNum));
    });
}

function setTableIndex(eleId) {
    $('#' + eleId + ' .layui-table-body>table>tbody>tr').each(function () {
        var nowPageRowNum = parseInt($(this).attr("data-index")) + 1;
        $(this).find('td[data-field="Index"]>div').html(nowPageRowNum);
    });
}

function getNowFormatDate(date) {
    var seperator = "-";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var dateStr = year + seperator + month + seperator + strDate;
    return dateStr;
}

function getPreMonth(date) {
    var arr = date.split('-');
    var year = arr[0]; //获取当前日期的年份
    var month = arr[1]; //获取当前日期的月份
    var day = arr[2]; //获取当前日期的日
    var days = new Date(year, month, 0);
    days = days.getDate(); //获取当前日期中月的天数
    var year2 = year;
    var month2 = parseInt(month) - 1;
    if (month2 == 0) {
        year2 = parseInt(year2) - 1;
        month2 = 12;
    }
    var day2 = day;
    var days2 = new Date(year2, month2, 0);
    days2 = days2.getDate();
    if (day2 > days2) {
        day2 = days2;
    }
    if (month2 < 10) {
        month2 = '0' + month2;
    }
    var t2 = year2 + '-' + month2 + '-' + day2;
    return t2;
}

var HtmlUtil = {
    /*1.用浏览器内部转换器实现html转码*/
    htmlEncode: function (html) {
        //1.首先动态创建一个容器标签元素，如DIV
        var temp = document.createElement("div");
        //2.然后将要转换的字符串设置为这个元素的innerText(ie支持)或者textContent(火狐，google支持)
        (temp.textContent != undefined) ? (temp.textContent = html) : (temp.innerText = html);
        //3.最后返回这个元素的innerHTML，即得到经过HTML编码转换的字符串了
        var output = temp.innerHTML;
        temp = null;
        return output;
    },
    /*2.用浏览器内部转换器实现html解码*/
    htmlDecode: function (text) {
        //1.首先动态创建一个容器标签元素，如DIV
        var temp = document.createElement("div");
        //2.然后将要转换的字符串设置为这个元素的innerHTML(ie，火狐，google都支持)
        temp.innerHTML = text;
        //3.最后返回这个元素的innerText(ie支持)或者textContent(火狐，google支持)，即得到经过HTML解码的字符串了。
        var output = temp.innerText || temp.textContent;
        temp = null;
        return output;
    }
};