var _myChart = null;
var _laytpl = null;

function setChatr(myChart, laytpl, element) {
    this._myChart = myChart;
    this._laytpl = laytpl;
    this._element = element;
}

function medalDivMouseEnter(obj) {
    $(obj).find('a').css("display", "inline-block");
}

function medalDivMouseLeave(obj) {
    $(obj).find('a').each(function () {
        var title = $(this).attr("title");
        if (title === "编辑" || title === "删除" || title === "弃用") {
            $(this).css("display", "none");
        }
    });
}

function loadChart() {
    $.get("/SkillsAndMedals/Home/GetSkillsdata", function (data) {
        _myChart.setOption(option = {
            series: [
                {
                    type: 'tree',
                    data: [data],
                    top: '1%',
                    left: '7%',
                    bottom: '1%',
                    right: '20%',
                    symbolSize: 7,
                    label: {
                        normal: {
                            position: 'left',
                            verticalAlign: 'middle',
                            align: 'right',
                            fontSize: 12
                        }
                    },

                    leaves: {
                        label: {
                            normal: {
                                position: 'right',
                                verticalAlign: 'middle',
                                align: 'left'
                            }
                        }
                    },

                    expandAndCollapse: false,
                    animationDuration: 550,
                    animationDurationUpdate: 750
                }
            ]
        });
        ResizeChart(_myChart);
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

function loadMedals(laytpl, element) {
    $.get("/SkillsAndMedals/Home/List", function (data) {
        var getTpl = medalList.innerHTML
            , view = document.getElementById('medaldiv');
        laytpl(getTpl).render(data, function (html) {
            view.innerHTML = html;
        });
        element.init();
    });
}

function loadDiscardMedals(laytpl, element) {
    $.get("/SkillsAndMedals/Home/DiscardMedalList", function (data) {
        var getTpl = discardMedalList.innerHTML
            , view = document.getElementById('discardMedaldiv');
        laytpl(getTpl).render(data, function (html) {
            view.innerHTML = html;
        });
        element.init();
    });
}

function initChart() {
    _myChart.on('mouseover', function (params) {
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        $('.tip').removeClass("layui-anim-fadeout");
        $('.tip').addClass("layui-anim-up");
        $('.tip').show().css({
            "left": params.event.event.clientX- 10,
            "top": params.event.event.clientY + scrollTop - 20
        })
        $("#noteId").val(params.data.id);
        $("#noteName").val(params.data.name);
        var level = params.data.level;
        switch (level) {
            case 1:
                $('#deleteskill').hide();
                $('#addskill').show();
                $('#editskill').show();
                break;
            case 2:
                $('#deleteskill').show();
                $('#addskill').show();
                $('#editskill').show();
                break;
            case 3:
                $('#addskill').hide();
                $('#deleteskill').show();
                $('#editskill').show();
                break;
        }
    });
}

function showEditSkill(id, title) {
    layer.open({
        resize: false,
        title: title,
        type: 2,
        area: ['400px', '350px'],//宽高
        content: "/SkillsAndMedals/Home/EditSkills?id=" + id,
        end: function () {
            loadChart();
        }
    });
}

function editMedal(id) {
    showEditMedal(id, "编辑勋章");
}

function addMedal() {
    showEditMedal(0, "添加勋章");
}

function deleteMedal(id) {
    layer.confirm('确定要删除吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/SkillsAndMedals/Home/DeleteMedal", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) loadMedals(_laytpl, _element);
        });
    }, function () { });
}

function discardMedal(id) {
    layer.confirm('确定要弃用吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/SkillsAndMedals/Home/DiscardMedal", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                loadMedals(_laytpl, _element);
                loadDiscardMedals(_laytpl, _element);
            }
        });
    }, function () { });
}

function showEditMedal(id, title) {
    layer.open({
        resize: false,
        title: title,
        type: 2,
        area: ['550px', '450px'],//宽高
        content: "/SkillsAndMedals/Home/EditMedal?id=" + id,
        end: function () {
            loadMedals(_laytpl, _element);
        }
    });
}

function addSkill() {
    var id = $('#noteId').val();
    layer.open({
        resize: false,
        title: '添加技能',
        type: 2,
        area: ['370px', '350px'],//宽高
        content: "/SkillsAndMedals/Home/AddSkills?id=" + id,
        end: function () {
            loadChart();
        }
    });
}

function deleteSkill() {
    var id = $('#noteId').val();
    var name = $('#noteName').val();
    layer.confirm('确定要删除 [' + name + '] 吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.get("/SkillsAndMedals/Home/DeleteSkills?id=" + id, function (data) {
            layer.msg(data.message);
            if (data.success) loadChart();
        });
    }, function () { });
}

function editSkill() {
    var id = $('#noteId').val();
    showEditSkill(id, "编辑技能");
}

function initEvent(isAdmin) {
    if (isAdmin == "True") {
        $('.skill_get_info').mouseover(function () {
            $('#editSkillDesc').show();

        }).mouseout(function () {
            $('#editSkillDesc').hide();
        });
        $('.medal_get_info').mouseover(function () {
            $('#editMedalDesc').show();
        }).mouseout(function () {
            $('#editMedalDesc').hide();
        });
    }
}

function loadSkillDescription() {
    $.get('/SkillsAndMedals/Home/GetDescription?path=SkillDescription', function (data) {
        $('#skill_title').html(data.title);
        $('#skill_content').html(data.content);
    });
}

function loadMedalDescription() {
    $.get('/SkillsAndMedals/Home/GetDescription?path=MedalDescription', function (data) {
        $('#medal_title').html(data.title);
        $('#medal_content').html(data.content);
    });
}

function editDescription(obj) {
    var id = $(obj).data("id");
    layer.open({
        resize: false,
        title: '编辑说明',
        type: 2,
        area: ['600px', '450px'],//宽高
        content: "/SkillsAndMedals/Home/EditDescription?id=" + id,
        end: function () {
            if (id == "skilldescription") {
                loadSkillDescription();
            } else if (id == "medaldescription") {
                loadMedalDescription();
            }
        }
    });
}

function showMedaledPerson(medalId) {
    var index = layer.open({
        type: 2,
        title: "勋章授予记录",
        resize: false,
        area: ['700px', '600px'],
        shadeClose: true,
        async: false,
        content: '/SkillsAndMedals/Home/MedaledMemberTable?medalId=' + medalId,
        end: function () {
        }
    });
}

