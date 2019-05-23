<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>销售订单</title>
    <%@ include file="../common/static/headerLink.jspf"%>
</head>
<body class="no-skin">
<jsp:include page="../common/top.jsp" />
<div class="main-container ace-save-state" id="main-container">
    <jsp:include page="../common/left.jsp" />
    <div class="main-content">
        <div class="main-content-inner">
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb" id="breadcrumb">
                </ul>
            </div>
            <div class="page-content">
                <div class="page-header">
                    <div class="row">
                        <div class="form-group-sm">
                            <div class="col-xs-12">
                                <div class="form-group-sm col-xs-4">
                                    <label class="col-xs-3 control-label align-right align-center">下单时间：</label>
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar bigger-110"></i>
                                        </span>

                                        <input class="form-control" type="text" name="date-range-picker"
                                               id="datetimepicker"
                                               readonly/>
                                        <input type="hidden" name="minDate" id="minDate">
                                        <input type="hidden" name="maxDate" id="maxDate">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div id="toolbar" class="btn-group btn-group-sm">
                        <button id="btn_query" type="button" class="btn btn-success">
                            <span class="glyphicon" aria-hidden="true"></span>查询
                        </button>
                    </div>

                    <table id="table"></table>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />
</div>
<!-- /.main-container -->
<%@ include file="../common/static/aceJs.jspf"%>

<script>
    var ORDERSTATUS_TYPES = [];
    ORDERSTATUS_TYPES[0] = {value: "订单创建", text: "订单创建"};
    ORDERSTATUS_TYPES[1] = {value: "订单发货", text: "订单发货"};
    ORDERSTATUS_TYPES[2] = {value: "订单完成", text: "订单完成"};
    ORDERSTATUS_TYPES[3] = {value: "订单取消", text: "订单取消"};

    jQuery(function($) {
        var first_week_day = moment().isoWeekday(1).day(1);
        var last_week_day = moment().isoWeekday(1).day(7);
        init_dataTime_range("datetimepicker", "minDate", "maxDate", true, first_week_day, last_week_day);

        $("#btn_query").click(function () {
            $('#table').bootstrapTable("refresh");
        });

        init_tables();
    });

    function getTableParam(params) {
        var condition = {};
        condition.minDate = $("#minDate").val();
        condition.maxDate = $("#maxDate").val();

        var newParams = $.extend(params, condition);
        return newParams;
    }

    function init_tables() {
        $('#table').bootstrapTable({
            url: '${ctx}/my/order/buyOrderList',
            method: 'post',
            cache: false,
            dataType : "json",
            contentType : "application/json",
            locale: "zh-CN",
            queryParams: getTableParam,
            onLoadError: function (status) {
                if(status != 200) {
                    showErrorDialog("数据加载失败，请重试");
                }
            },
            onLoadSuccess: function (data) {
                $("#table tr>td, #table tr>th").css({
                    'border': '0px',
                    'border-bottom': '1px solid #ddd',
                });

                $(".item-list>li").css("background-color", "#FFF");
            },
            showRefresh: false,
            showColumns: true,
            showToggle: false,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: false,
            // classes: 'table table-striped table-bordered table-hover',
            classes: 'table small',
            toolbar: '#toolbar',

            sortable: false,
            idField: "id",
            uniqueId: "id",

            pagination: true,
            pageList: [10, 20],
            pageSize: 10,
            pageNumber: 1,
            sidePagination: "client",
            // sidePagination: "server",

            columns: [
                {
                    field: 'id',
                    title: '订单ID',
                    align: 'left',
                    valign: 'center',
                    visible: false,
                },
                {
                    field: 'skuId',
                    title: '商品ID',
                    align: 'left',
                    valign: 'center',
                    visible: false,
                },
                {
                    field: 'skuName',
                    title: '商品名称',
                    align: 'middle',
                    valign: 'center',
                    visible: true,
                },
                {
                    field: 'orderPrice',
                    title: '订单价格',
                    align: 'middle',
                    valign: 'center',
                    visible: true,
                },
                {
                    field: 'skuNum',
                    title: '订单数量',
                    align: 'middle',
                    valign: 'center',
                    visible: true,
                },
                {
                    field: 'createDate',
                    title: '下单时间',
                    align: 'middle',
                    valign: 'center',
                    visible: true,
                },
                {
                    field: 'orderStatus',
                    title: '订单状态',
                    align: 'middle',
                    valign: 'center',
                    visible: true,
                    formatter: function (value, rowData, index) {
                        if (rowData && rowData.orderLogs) {
                            return rowData.orderLogs[rowData.orderLogs.length - 1].orderStatus;
                        }
                    },
                    editable: {
                        type: 'select',
                        title: '订单状态',
                        emptytext: "-",
                        disabled: false,
                        source: function (e) {
                            return ORDERSTATUS_TYPES;
                        },
                        validate: function (value) {
                            if(!value || $.trim(value) == '') {
                                return '订单状态不能为空!';
                            }

                            if(value == "订单完成") {
                                return '订单状态不能选择完成!';
                            }

                            if(value == "订单创建") {
                                return '订单状态不能选择创建!';
                            }

                            var pk = $(this).attr("data-pk");

                            if(pk) {
                                var rowData = $('#table').bootstrapTable('getRowByUniqueId', pk);

                                if (rowData && rowData.orderLogs) {
                                    var oldValue = rowData.orderLogs[rowData.orderLogs.length - 1].orderStatus;

                                    if(oldValue == "订单完成" || oldValue == "订单取消") {
                                        return '已完成或者取消订单不能修改!';
                                    }

                                    /*if(oldValue == "订单创建" && value == "订单取消") {
                                        return '已发货订单不能取消，请联系卖家!';
                                    }*/
                                }
                            }
                        }
                    }
                },
                {
                    field: 'buyUserName',
                    title: '买家账号',
                    align: 'middle',
                    valign: 'center',
                    visible: true
                }
            ],

            detailView: true,
            onExpandRow: function (index, row, $Subdetail) {
                initSubTable(index, row, $Subdetail);
            },
            onEditableSave: function (field, row, oldValue, $el) {
                if(field == "orderStatus" && row && row[field] != row) {
                    var data = {};
                    data.orderId = row.id;

                    if(row && row.orderLogs) {
                        data.orderStatusOldName = row.orderLogs[row.orderLogs.length - 1].orderStatus;
                    }

                    data.orderStatusName = row[field];

                    senAjax("/my/order/addOrderLog", data,
                        function (jsonData) {
                            if(jsonData && jsonData.success) {
                                showSuccessDialog("订单状态更新成功");
                                $('#table').bootstrapTable("collapseAllRows");
                                $('#table').bootstrapTable("refresh");
                            }
                            else {
                                showErrorDialog("订单状态更新失败");
                            }
                        },
                        function (XMLHttpRequest, textStatus, errorThrown) {
                            showErrorDialog("订单状态更新失败");
                        }
                    );
                }
            }
            /*responseHandler: function responseHandler(sourceData) {
                //这里要做分页，所以对返回的数据进行了处理
                return {
                    "total": sourceData.total,  // 总条数
                    "rows": sourceData.rows // 返回的数据列表（后台返回一个list集合）
                };
            },
            onDblClickRow: function (row, $element, field) {

            }*/
        });
    }

    initSubTable = function (index, row, $detail) {
        var cur_table = $detail.html('<table></table>').find('table');
        var id = row.id;

        $(cur_table).bootstrapTable({
            url: '${ctx}/my/order/orderLogList',
            method: 'get',
            queryParams: { orderId: id },
            dataType : "json",
            contentType : "application/json",
            cache: false,
            classes: "table small table-no-bordered",
            sortable: false,
            showHeader:false,
            sortOrder: "desc",
            showColumns: false,
            uniqueId: "id",
            columns: [
                {
                    field: 'orderStatus',
                    title: '订单状态',
                    align: 'middle',
                    valign: 'center',
                    visible: true
                },
                {
                    field: 'createDate',
                    title: '操作时间',
                    align: 'middle',
                    valign: 'center',
                    visible: true
                },
                {
                    field: 'creatorName',
                    title: '操作账号',
                    align: 'middle',
                    valign: 'center',
                    visible: true
                },
            ],
            onLoadError: function (status) {
                if(status != 200) {
                    $('#table').bootstrapTable('collapseRow', id);
                    showErrorDialog("子表数据加载失败，请重试");
                }
            },
            onLoadSuccess: function (data) {
                $("#table tr>td, #table tr>th").css({
                    'border': '0px',
                    'border-bottom': '1px solid #ddd',
                });

                $(".item-list>li").css("background-color", "#FFF");

                if(!data) {
                    $('#table').bootstrapTable('collapseRow', index);
                }
            },
        });
    }
</script>
</body>
</html>
