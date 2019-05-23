<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>我的商品</title>
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
                <div class="row">
                    <div id="toolbar" class="btn-group btn-group-sm">
                        <button id="btn_add" type="button" class="btn btn-link btn-success">
                            <span class="glyphicon" aria-hidden="true"></span>添加商品
                        </button>

                        <button id="btn_on" type="button" class="btn btn-success">
                            <span class="glyphicon" aria-hidden="true"></span>上架
                        </button>

                        <button id="btn_off" type="button" class="btn btn-success">
                            <span class="glyphicon" aria-hidden="true"></span>下架
                        </button>

                        <button id="btn_info" type="button" class="btn btn-success">
                            <span class="glyphicon" aria-hidden="true"></span>详情
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
    jQuery(function($) {
        init_tables();

        $("#btn_add").click(function () {
            window.location.href = "${ctx}/product/page";
        });

        $("#btn_on").click(function () {
            updteSkuStatus(true);
        });

        $("#btn_off").click(function () {
            updteSkuStatus(false);
        });

        $("#btn_info").click(function () {
            var selectRow = $('#table').bootstrapTable('getSelections');
            var _length = selectRow ? selectRow.length : 0;

            if(!selectRow || _length < 1) {
                showErrorDialog("请先选择数据！");
                return;
            }

            selectRow = selectRow[0];
            window.open("${ctx}/item?id=" + selectRow.id, "_blank");
        });
    });
    
    function updteSkuStatus(isOn) {
        var selectRow = $('#table').bootstrapTable('getSelections');
        var _length = selectRow ? selectRow.length : 0;

        if(!selectRow || _length < 1) {
            showErrorDialog("请先选择数据！");
            return;
        }

        selectRow = selectRow[0];
        var data = {};
        data.id = selectRow.id;
        data.skuStatusBoolean = isOn;

        senAjax("/product/updateProduct", data,
            function (jsonData) {
                if(jsonData && jsonData.success) {
                    showSuccessDialog(selectRow.skuName + " 保存成功");
                    $('#table').bootstrapTable("refresh");
                }
                else {
                    showErrorDialog(selectRow.skuName + " 保存失败");
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                showErrorDialog(selectRow.skuName + " 保存失败");
            }
        );
    }

    function init_tables() {
        $('#table').bootstrapTable({
            url: '${ctx}/product/productList',
            method: 'post',
            cache: false,
            classes: "table small",
            dataType : "json",
            contentType : "application/json",
            locale: "zh-CN",
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

                $(".bootstrap-table .bs-checkbox").css({
                    'vertical-align': 'middle'
                });
            },
            rowStyle: function(row, index) {
                var productStock = row.productStock;
                if(productStock) {
                    var numStock = productStock.numStock == null ? 0 : productStock.numStock;
                    var num = productStock.num == null ? 0 : productStock.num;

                    if(num - numStock == 0) {
                        return { classes: "danger" }
                    }
                }

                return { classes: "" }
            },
            // table-bordered
            classes: 'table table-striped table-hover',
            toolbar: '#toolbar',
            idField: "id",
            uniqueId: "id",
            sortable: false,
            /*sortName: "id",
            sortOrder: 'asc',*/
            singleSelect : true,
            showColumns: true,
            columns: [
                {
                    checkbox: true
                },
                {
                    field: 'id',
                    title: 'ID',
                    visible: false,
                    valign: 'middle',
                },
                {
                    field: 'skuName',
                    title: '商品名称',
                    valign: 'middle',
                },
                {
                    field: 'skuTypeId',
                    title: '商品类目',
                    valign: 'middle',
                    visible: false,
                },
                {
                    field: 'price',
                    title: '价格(¥)',
                    valign: 'middle',
                    align: 'center',
                    editable: {
                        type: 'text',
                        title: '价格',
                        emptytext: "-",
                        validate: function (value) {
                            if($.trim(value) == '') {
                                return '价格不能为空!';
                            }

                            if(isNaN(value)) {
                                return '价格必须是数字，可以是小数!';
                            }
                        }
                    }
                },
                {
                    field: 'skuNum',
                    title: '库存',
                    valign: 'middle',
                    align: 'center',
                    formatter: function(value, rowData, index) {
                        return rowData.productStock.num;
                    },
                    editable: {
                        type: 'text',
                        title: '库存',
                        emptytext: "-",
                        validate: function (value) {
                            // console.log($(this));
                            if($.trim(value) == '') {
                                return '库存不能为空!';
                            }

                            if(isNaN(value) || value % 1 != 0) {
                                return '库存必须是整数!';
                            }

                            var pk = $(this).context.dataset.pk;

                            if(pk) {
                                var rowData = $('#table').bootstrapTable('getRowByUniqueId', pk);
                                var productStock = rowData.productStock;
                                var numStock = productStock.numStock == null ? 0 : productStock.numStock;

                                if(numStock > 0 && Number(value) < Number(numStock)) {
                                    return '库存不能小于已售库存 ' + numStock + " ！";
                                }
                            }
                        }
                    }
                },
                {
                    field: 'numStock',
                    title: '已售库存',
                    valign: 'middle',
                    align: 'center',
                    formatter: function(value, rowData, index) {
                        var productStock = rowData.productStock;
                        var numStock = productStock.numStock == null ? 0 : productStock.numStock;
                        return numStock;
                    }
                },
                {
                    field: 'daofou',
                    title: '是否可刀',
                    valign: 'middle',
                    formatter: function(value, rowData, index) {
                        return value ? "可刀" : "不可刀";
                    }
                },
                {
                    field: 'skuAttr',
                    title: '成色',
                    valign: 'middle',
                },
                {
                    field: 'buyDate',
                    title: '开售时间',
                    valign: 'middle',
                },
                {
                    field: 'skuStatus',
                    title: '商品状态',
                    valign: 'middle',
                    align: 'center',
                },
                {
                    field: 'creatorname',
                    title: '创建人',
                    valign: 'middle',
                    align: 'center',
                    visible: false,
                }
            ],
            onEditableSave: function (field, row, oldValue, $el) {
                if(!field || !row) {
                    return;
                }
                else {
                    var data = {};
                    data.id = row.id;
                    data[field] = row[field];

                    senAjax("/product/updateProduct", data,
                        function (jsonData) {
                            if(jsonData && jsonData.success) {
                                showSuccessDialog("执行成功");
                                $('#table').bootstrapTable("refresh");
                            }
                            else {
                                showErrorDialog("执行失败");
                            }
                        },
                        function (XMLHttpRequest, textStatus, errorThrown) {
                            showErrorDialog("执行失败");
                        }
                    );
                }
            },
        });
    }
</script>
</body>
</html>
