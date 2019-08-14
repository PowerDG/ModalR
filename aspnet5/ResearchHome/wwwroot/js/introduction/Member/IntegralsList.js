var integralslimitPage;
$(document).ready(function () {
    //loadIntegralsTable();

    $("#integralsContent").change(function (e) {
        integralslimitPage = $(e.target).find("option:selected").attr('value');
    });
});

function loadIntegralsTable() {
    layui.use(['table'], function () {
        var table = layui.table;
        var columns = [
            { type: 'numbers', title: '序号', width: 50 }
            , { field: 'CreatedTime', title: '时间', width: 200, templet: '<p>{{toDateString(d.CreatedTime,"YYYY-MM-DD HH:mm")}}</p>' }
            , { field: 'Integral', title: '分值', width: 175 }
            , { field: 'Description', title: '说明', toolbar: '#integralsTable', width: 530 }
        ];
        table.render({
            elem: '#table_integrals'
            , width: 960
            , url: '/introduction/integrals/getintegrals?id=' + $("#memberPageId").val()
            , page: true
            , limit: integralslimitPage === undefined ? 5 : integralslimitPage
            , limits: [5, 10, 20, 30, 100]
            , cols: [columns]
        });
    });

}

function editIntegrals(_memberPageId, integralsId, title) {
    layer.open({
        resize: false,
        title: title,
        type: 2,
        area: ['370px', '360px'],//宽高
        content: "/introduction/integrals/editintegral?memberId=" + _memberPageId + "&integralId=" + integralsId,
        end: function () {
            loadIntegralsTable();
            loadTotalIntegral();
        }
    });
}

function deleteIntegral(id) {
    layer.confirm('确定要删除吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/integrals/delete", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                loadIntegralsTable();
                loadTotalIntegral();
            };
        });
    }, function () { });
}

function loadTotalIntegral() {
    $.get("/introduction/member/GetTotalIntegral?id=" + $("#memberPageId").val(), function (data) {
        $("#integralsTitle").text("总积分:" + data.totalIntegral + "    " + "今年积分:" + data.annualIntegral);
    });
}