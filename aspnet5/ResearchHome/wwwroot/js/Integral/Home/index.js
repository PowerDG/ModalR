function LoadPage() {
    getIntegralRanking();
    getMedalRanking();
    getYearReview();
    $('#order img').attr('src', '/images/public/NonePicture.png');
}

function getMedalRanking() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/Integral/Home/GetMedals",
        success: function (data) {
            var tableCols = [
                { type: 'numbers', title: '排名', width: 55 }
                , {
                    field: 'name', title: '姓名', width: 90, templet: function (d) {
                        return d.name;
                    }
                }
                , {
                    field: 'score', title: '一级', width: 60, templet: function (d) {
                        return d.medalLevel1;
                    }
                }
                , {
                    field: 'score', title: '二级', width: 60, templet: function (d) {
                        return d.medalLevel2;
                    }
                }
                , {
                    field: 'score', title: '三级', width: 60, templet: function (d) {
                        return d.medalLevel3;
                    }
                }
            ];
            renderTopThreeDiv('#medal', data);
            renderScoreTable('#medalTable', tableCols, data);
        }
    });
}

function getYearReview() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/Integral/Home/GetYearReviews",
        success: function (data) {
            var tableCols = [
                { type: 'numbers', title: '排名', width: 55 }
                , {
                    field: 'name', title: '姓名', width: 90, templet: function (d) {
                        return d.Name;
                    }
                }
                , {
                    field: 'score', title: '考评结果', width: 183, templet: function (d) {
                        return d.Level;
                    }
                }
            ];
            renderTopThreeDiv('#yearReview', data);
            renderScoreTable('#yearReviewTable', tableCols, data);
        }
    });
}

function getIntegralRanking() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: "/Integral/Home/GetIntegralRankingData",
        success: function (data) {
            var tableCols = [
                { type: 'numbers', title: '排名', width: 55 }
                , {
                    field: 'name', title: '姓名', width: 90, templet: function (d) {
                        return d.Name;
                    }
                }
                , {
                    field: 'score', title: '总积分', width: 183, templet: function (d) {
                        return d.TotalIntegral;
                    }
                }
            ];
            renderTopThreeDiv('#score', data);
            renderScoreTable('#scoreTable', tableCols, data);
        }
    });
}

function renderTopThreeDiv(ele, data) {
    if (data === null || data.length === null) {
        return;
    }
    var length = data.length > 3 ? 3 : data.length;
    var innerElement;

    for (var index = 0; index < length; index++) {
        if (index == 0) {
            innerElement = '.top';
        }
        if (index == 1) {
            innerElement = '.left';
        }
        if (index == 2) {
            innerElement = '.right';
        }
        $(`${ele} ${innerElement}  img`).attr('src', data[index].Photo);
        if (ele == '#score') {
            $(`${ele} ${innerElement} .information`).html(`<div  class="memberName">${data[index].Name}</div><div>${data[index].TotalIntegral}</div>`);
        }
        if (ele == '#yearReview') {
            $(`${ele} ${innerElement} .information`).html(`<div  class="memberName">${data[index].Name}</div><div>${data[index].Level}</div>`);
        }
        if (ele == '#medal') {
            $(`${ele} ${innerElement}  img`).attr('src', data[index].photo);
            $(`${ele} ${innerElement} .information`).html(`<div  class="memberName">${data[index].name}</div>
                                                             <div>一级 &nbsp;${data[index].medalLevel1}</div>
                                                             <div>二级 &nbsp;${data[index].medalLevel2}</div>
                                                             <div>三级 &nbsp;${data[index].medalLevel3}</div>`);
        }
    }
}

function renderScoreTable(tableName, tableCols, tableData) {
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: tableName
            , height: 'full'
            , data: tableData
            , limit: 1000
            , cols: [tableCols]
            , done: function () {
                for (var index = 0; index < 3; index++) {
                    $('tr[data-index="' + index + '"]').attr('style', 'display:none');
                }
            }
        });
    });
}
