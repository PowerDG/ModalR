var myChart = echarts.init(document.getElementById('div_skill'));

function loadChart() {
    $.get("/introduction/skills/getmemberskills?id=" + $("#memberPageId").val(), function (data) {
        if (data == null || data.skills == null) {
            $('#div_skill').css('height', '40px');
            $('#notskill').show();
            $("#skillCount").text("0");
        } else {
            $('#notskill').hide();
            $('#div_skill').css('height', '400px');
            $("#skillCount").text("" + data.skillCount + "");
            var option = {
                tooltip: {
                    trigger: "item",
                    triggerOn: "mousemove",
                    formatter: function (data) {
                        if (data.data.level == 3) {
                            return "授予时间：" + toDateString(data.data.gainDate, "YYYY-MM-DD")
                        } else {
                            return data.data.name
                        }
                    }
                },
                series: [
                    {
                        type: 'tree',
                        data: [data.skills],
                        left: '7%',
                        right: '20%',
                        top: '1%',
                        bottom: '1%',
                        symbol: 'emptyCircle',
                        orient: 'horizontal',
                        expandAndCollapse: true,
                        label: {
                            normal: {
                                position: 'left',
                                //rotate: -00,
                                verticalAlign: 'middle',
                                align: 'right',
                                fontSize: 12
                            }
                        },
                        leaves: {
                            label: {
                                normal: {
                                    position: 'right',
                                    //rotate: -00,
                                    verticalAlign: 'middle',
                                    align: 'left'
                                }
                            }
                        },
                        animationDurationUpdate: 750
                    }
                ]
            };
            myChart.setOption(option);
            ResizeChart(myChart);
        }
    });
}

function ResizeChart(myChart) {
    var container = document.getElementById('div_skill');
    var allNode = 0;
    var nodes = myChart._chartsViews[0]._data._graphicEls;
    for (var i = 0, count = nodes.length; i < count; i++) {
        var node = nodes[i];
        if (node === undefined)
            continue;
        allNode++;
    }
    var currentHeight = 18 * allNode;
    container.style.height = currentHeight + 'px';
    myChart.resize();
}

function editSkill(_memberPageId) {
    layer.open({
        resize: false,
        title: '授予技能',
        type: 2,
        area: ['400px', '500px'],//宽高
        content: "/introduction/skills/editskill?memberId=" + _memberPageId,
        end: function () {
            loadChart();
        }
    });
}