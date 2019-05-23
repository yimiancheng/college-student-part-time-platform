<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>商品类目管理</title>
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
                        <button id="btn_add" type="button" class="btn btn-success">
                            <span class="glyphicon" aria-hidden="true"></span>添加分类
                        </button>

                        <button id="btndel" type="button" class="btn btn-danger">
                            <span class="glyphicon" aria-hidden="true"></span>删除分类
                        </button>
                    </div>

                    <table id="table"></table>

                    <div class="hr hr10 hr-dotted"></div>

                    <div class="alert alert-info">
                        <button type="button" class="close" data-dismiss="alert">
                            <i class="ace-icon fa fa-times"></i>
                        </button>
                        <strong>注意!</strong>
                            排序越大越靠前。
                        <br>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />
</div>
<!-- /.main-container -->
<%@ include file="../common/static/aceJs.jspf"%>

<script>
    var ADD_PRODUCT_TYPE_DIALOG = new BootstrapDialog({
        size: BootstrapDialog.SIZE_NORMAL,
        closable: true,
        closeByBackdrop: false,
        closeByKeyboard: false,
        title: '添加商品类目',
        buttons: [
            {
                label: '保存',
                cssClass: 'btn btn-success btn-sm',
                action: function(dialog){
                    var productTypeName = dialog.getModalBody().find('#productTypeName');
                    var _typeName = $(productTypeName).val();
                    submitProductType(_typeName, dialog);
                    // dialog.close();
                }
            }
        ]
    });

    jQuery(function($) {
        init_tables();
        addProductType();
        delProductType();
    });
    
    function delProductType() {
        $("#btndel").click(function () {
            var selectRow = $('#table').bootstrapTable('getSelections');
            var _length = selectRow ? selectRow.length : 0;
            if(!selectRow || _length < 1) {
                showErrorDialog("请先选择数据！")
            }
            else {
                var ids = [];
                for (var i = 0; i < _length; i++) {
                    ids.push(selectRow[i].id);
                }

                var data = {};
                data.id = ids;

                senAjax("/productType/delProductType", data,
                    function (jsonData) {
                        if(jsonData && jsonData.success) {
                            $('#table').bootstrapTable("refresh");
                            showSuccessDialog("删除成功，删除 " + _length + " 条数据");
                        }
                        else {
                            showErrorDialog("执行失败！");
                        }
                    },
                    function (XMLHttpRequest, textStatus, errorThrown) {
                        showErrorDialog("执行失败！");
                    }
                );
            }
        });
    }
    
    function submitProductType(typeName, dialog) {
        var data = {
            typeName: typeName
        };

        senAjax("/productType/addProductType", data,
            function (jsonData) {
                if(jsonData && jsonData.success) {
                    dialog.close();
                    showSuccessDialog(typeName + " 保存成功！");
                }
                else {
                    showErrorDialog(typeName + " 保存失败！");
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                showErrorDialog(planObj_lunch.planName + " 提交审核 失败！");
            }
        );
    }

    function updateProductType(field, fieldValue, id) {
        var data = {
            id: id,
        };

        data[field] = fieldValue;

        senAjax("/productType/updateProductType", data,
            function (jsonData) {
                if(jsonData && jsonData.success) {
                    $('#table').bootstrapTable("refresh");
                }
                else {
                    showErrorDialog("修改失败，请重试！");
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                showErrorDialog("修改失败，请重试！");
            }
        );
    }
    
    function addProductType() {
        $("#btn_add").click(function () {
            ADD_PRODUCT_TYPE_DIALOG.realize();
            ADD_PRODUCT_TYPE_DIALOG.setMessage($('<div><input type="text" class="form-control" placeholder="商品一级类目" id="productTypeName"/></div>'));

            ADD_PRODUCT_TYPE_DIALOG.onHide(function () {
                $('#table').bootstrapTable("refresh");
            });

            ADD_PRODUCT_TYPE_DIALOG.onShown(function (dialogRef) {
                var productTypeName = dialogRef.getModalBody().find('#productTypeName');
                $(productTypeName).val("");
            });

            ADD_PRODUCT_TYPE_DIALOG.open();
        });
    }

    function init_tables() {
        $('#table').bootstrapTable({
            url: '${ctx}/productType/selectProductTypes',
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
            onEditableSave: function (field, row, oldValue, $el) {
                if(field && row) {
                    var fieldValue = row[field];

                    if(!fieldValue) {
                        return;
                    }

                    fieldValue = new String(fieldValue);
                    var index = fieldValue.indexOf("%");

                    if(index != -1) {
                        fieldValue = fieldValue.substring(0, index);
                    }

                    // console.log(field, fieldValue, oldValue, row);
                    updateProductType(field, fieldValue, row.id);
                }
            },
            // table-bordered
            classes: 'table table-striped table-hover',
            toolbar: '#toolbar',
            idField: "id",
            uniqueId: "id",
            sortable: false,
            /*sortName: "id",
            sortOrder: 'asc',*/
            // singleSelect : true,
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
                    field: 'typeName',
                    title: '类目名称',
                    valign: 'middle',
                },
                {
                    field: 'orderNo',
                    title: '排序',
                    valign: 'middle',
                    align: 'center',
                    // sortable: true,
                    editable: {
                        type: 'text',
                        title: '排序',
                        emptytext: "-",
                        validate: function (value) {
                            if(!value || $.trim(value) == '' || isNaN(value) || Math.ceil(value) != value) {
                                return '排序不能为空,且必须是整数数字!';
                            }
                        }
                    }
                },
                {
                    field: 'updateDate',
                    title: '更新时间',
                    valign: 'middle',
                    align: 'center'
                },
                {
                    field: 'createDate',
                    title: '创建时间',
                    valign: 'middle',
                    align: 'center'
                }
            ]
        });
    }
</script>
</body>
</html>
