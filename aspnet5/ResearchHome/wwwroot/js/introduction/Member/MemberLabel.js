function loadLabelChart() {
    var myLabelChart = echarts.init(document.getElementById('div_Label'));

    $.get("/introduction/labels/GetMemberLabels?memberId=" + $("#memberPageId").val(), function (data) {
        if (data == null || data.memberLabels == null || data.memberLabels.length === 0) {
            $('#div_Label').css('height', '40px');
            $('#notLabel').show();
            $("#LabelCount").text("0");
        } else {
            $('#notLabel').hide();
            $('#div_Label').css('height', '400px');
            $("#LabelCount").text("" + data.labelCount + "");

            var option = {
                backgroundColor: '#F7F7F7',
                tooltip: {
                    show: true
                },
                series: [{
                    name: '次数',
                    type: 'wordCloud',
                    sizeRange: [30, 66],
                    rotationRange: [-45, 90],
                    shape: 'diamond',
                    textPadding: 0,
                    autoSize: {
                        enable: true,
                        minSize: 30
                    },
                    textStyle: {
                        normal: {
                            color: function () {
                                return 'rgb(' + [
                                    Math.round(Math.random() * 160),
                                    Math.round(Math.random() * 160),
                                    Math.round(Math.random() * 160)
                                ].join(',') + ')';
                            }
                        },
                        emphasis: {
                            shadowBlur: 10,
                            shadowColor: '#333'
                        }
                    },
                    data: data.memberLabels
                }]
            };
            myLabelChart.setOption(option);
        }
    });
}

function AddMemberLabel(_memberPageId) {
    layer.open({
        resize: false,
        title: '添加标签',
        type: 2,
        area: ['400px', '400px'],//宽高
        content: "/introduction/labels/AddMemberLabel?memberId=" + $("#memberPageId").val(),
        end: function () {
            loadLabelChart();
        }
    });
}

function saveLabels() {
    var labels = $('#labels').val();
    var memberId = $('#memberId').val();
    $.post("/introduction/labels/AddMemberLabel", { memberId, labels}, function (data) {
        if (data.success) {
            layer.msg(data.message, { icon: 6, shift: -1, time: 500, shade: 0.3 },
                function () { parent.layer.closeAll(); });
        } else {
            layer.msg(data.message, { icon: 5, shift: -1, time: 500, shade: 0.3 },
                function () { parent.layer.closeAll(); });
        }
    });
}
