var appraisalLimitPage;
$(document).ready(function () {
    //loadAppraisalsTable();

    $("#appraisalsContent").change(function (e) {
        appraisalLimitPage = $(e.target).find("option:selected").attr('value');
    });
});

function loadAppraisalsTable() {
    layui.use(['table','layer'],  function () {
        var table = layui.table;
        var columns = [
            { type: 'numbers', title: '序号', width: 50 }
            , { field: 'Year', title: '年度', width: 100 }
            , { field: 'Type', title: '类型', width: 100 }
            , { field: 'PerformanceScore', title: '绩效', width: 104 }
            , { field: 'ValueScore', title: '价值观', width: 104 }
            , { field: 'TotalScore', title: '总分', width: 114 }
            , { field: 'Level', title: '考评结果', width: 150 }
            , { field: 'CreatedMemberName', title: '考评人', width: 230, templet: '#appraisalTable' }
        ];

        table.render({
            elem: '#table_appraisals'
            ,width:960
            , url: '/introduction/appraisals/getappraisals?id=' + $("#memberPageId").val()
            , page: true
            , limit: appraisalLimitPage === undefined ? 5 : appraisalLimitPage
            , limits: [5, 10, 20, 30, 100]
            , cols: [columns]
        });
    });
}

function editAppraisal(_memberPageId, appraisalId, title) {
    layer.open({
        resize: false,
        title: title,
        type: 2,
        area: ['750px', '410px'],//宽高
        content: "/introduction/appraisals/editappraisals?memberId=" + _memberPageId + "&appraisalId=" + appraisalId,
        end: function () {
            loadAppraisalsTable();
        }
    });
}

function deleteAppraisal(id) {
    layer.confirm('确定要删除吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/appraisals/delete", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                loadAppraisalsTable();
            };
        });
    }, function () { });
}