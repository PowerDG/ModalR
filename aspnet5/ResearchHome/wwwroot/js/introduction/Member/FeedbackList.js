var feedbacklimitPage;
$("#feedbacksContent").change(function (e) {
    feedbacklimitPage = $(e.target).find("option:selected").attr('value');
});

function loadFeedbacksTable() {
    layui.use(["table"], function () {
        var table = layui.table;
        var columns = [
            { type: 'numbers', title: '序号', width: 50 }
            , { field: 'CreatedTime', title: '时间', width: 220, templet: '<p>{{toDateString(d.CreatedTime,"YYYY-MM-DD HH:mm")}}</p>' }
            , { field: 'ProviderName', title: '反馈人', width: 240 }
            , { field: 'Content', title: '反馈内容', width: 445, templet: '#feedbackTable' }
        ];
        table.render({
            elem: '#table_feedbacks'
            , width: 960
            , url: '/introduction/feedback/getfeedbacks?id=' + $("#memberPageId").val()
            , page: true
            , limit: feedbacklimitPage === undefined ? 5 : feedbacklimitPage
            , limits: [5, 10, 20, 30, 100]
            , cols: [columns]
        });
    });
}

function editFeedback(_memberPageId, feedbackId, title) {
    layer.open({
        resize: false,
        title: title,
        type: 2,
        area: ['600px', '530px'],
        content: "/introduction/feedback/editfeedback?memberId=" + _memberPageId + "&feedbackId=" + feedbackId,
        end: function () {
            loadFeedbacksTable();
        }
    });
}

function deleteFeedback(id) {
    layer.confirm('确定要删除吗？', {
        btn: ['确认', '取消'], icon: 3
    }, function () {
        $.post("/introduction/feedback/delete", { id }, function (data) {
            layer.msg(data.message);
            if (data.success) {
                loadFeedbacksTable()
            };
        });
    }, function () { });
}