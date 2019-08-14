var integralTotalTableSortData = { field: "TotalIntegral", type: "DESC" };

var integralTotalTableCols = [
    { field: 'Index', width: 60, title: '排名', align: 'center' }
    //,{ field: 'Id', width: 80, title: '排名', sort: "ture" }
    , { field: 'Name', minwidth: 170, title: '姓名', sort: "ture" }
    , { field: 'TotalIntegral', width: 160, title: '积分', sort: "ture" }
    , { field: 'AnnualIntegral', width: 160, title: '今年积分', sort: "ture" }
];

window.onload = function () {
    loadIntegralTotalTableData();
}

function loadIntegralTotalTableData() {
    layui.use('table', function () {
        var table = layui.table;
        table.render({
            elem: '#integralTotalTable'
            , url: '/Integral/Home/GetIntegralTotalTableData'
            , height: 'full-50'
            , method: 'post'
            , limit: limitPage === undefined ? 10 : limitPage
            , limits: [10, 20, 30, 100, 200, 500]
            , page: true
            , async: false
            , cols: [integralTotalTableCols]
            , where: {
                sortField: integralTotalTableSortData.field,
                sortType: integralTotalTableSortData.type
            }
            , done: function (res) {
                $('.layui-layout-admin').css("overflow", "auto");
                setPageTableIndex("integralTotalContent");
                setSortStyle("integralTotalTable", integralTotalTableSortData);
            }
        });

        //排序事件
        table.on('sort(integralTotalTableFilter)', function (data) {
            integralTotalTableSortData = data;
            loadIntegralTotalTableData();
        });
    });
}

var limitPage;
$('#integralTotalContent').change(function (e) {
    limitPage = $(e.target).find('option:selected').attr('value');
});