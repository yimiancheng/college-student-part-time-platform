<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>我的收藏</title>
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
                    <div id="toolbar" class="btn-group btn-group">
                        <button id="btn_index" type="button" class="btn btn btn-success">
                            <span class="glyphicon" aria-hidden="true"></span>首页
                        </button>
                    </div>

                    <div class="hr hr10 hr-dotted"></div>

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
    var SKUSTATUS_TYPES = [];
    SKUSTATUS_TYPES[0] = {value: "收藏", text: "收藏"};
    SKUSTATUS_TYPES[1] = {value: "删除", text: "删除"};

    jQuery(function($) {
        init_tables();
        
        $("#btn_index").click(function () {
            window.location.href = "${ctx}/index";
        });
    });
    
    function init_tables() {
        $('#table').bootstrapTable({
            url: '${ctx}/my/skuLikeList',
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

                /*$(".bootstrap-table .bs-checkbox").css({
                    'vertical-align': 'middle'
                });*/
            },
            // table-bordered
            classes: 'table table-striped table-hover',
            idField: "id",
            uniqueId: "id",
            sortable: false,
            singleSelect : true,
            showColumns: false,
            onEditableSave: function (field, row, oldValue, $el) {
                if(field && row) {
                    var data = {};
                    data.id = row.id;
                    data.skuName = row.skuName;

                    if("skuStatus" == field) {
                        data.ststus = row[field];
                    }
                    else {
                        data[field] = row[field];
                    }

                    updateSkuLike(data);
                }
            },
            columns: [
                {
                    field: 'id',
                    title: 'ID',
                    visible: false,
                    valign: 'middle',
                },
                {
                    field: 'skuId',
                    title: '商品ID',
                    visible: false,
                    valign: 'middle',
                },
                {
                    field: 'skuName',
                    title: '商品名称',
                    valign: 'middle',
                },
                {
                    field: 'skuStatus',
                    title: '收藏状态',
                    valign: 'middle',
                    visible: true,
                    editable: {
                        type: 'select',
                        title: '收藏状态',
                        emptytext: "-",
                        disabled: false,
                        source: function () {
                            return SKUSTATUS_TYPES;
                        },
                        validate: function (value) {
                            if(!value || $.trim(value) == '') {
                                return '收藏状态不能为空!';
                            }
                        }
                    }
                },
                {
                    field: 'createDate',
                    title: '收藏时间',
                    valign: 'middle',
                    align: 'center',
                },
                {
                    field: 'creatorname',
                    title: '创建人',
                    valign: 'middle',
                    align: 'center',
                    visible: false,
                },
                {
                    field: '',
                    title: '操作',
                    valign: 'middle',
                    align: 'center',
                    visible: true,
                    formatter: function(value, rowData, index) {
                        var html = '<div class="btn-group btn-group-sm">' +
                            '<button type="button" class="btn btn-white btn-success" style="margin-bottom: 3px;" onclick="goToItem(\'' +
                            rowData.skuId +
                            '\')"><i class="icon-only ace-icon fa fa-lock"></i>&nbsp;&nbsp;立即购买 </button>';

                        return html + '</div>';
                    }
                }
            ]
        });
    }
    
    function goToItem(skuId) {
        if(skuId) {
            window.open("${ctx}/trade?id=" + skuId, "_blank");
        }
    }
    
    function updateSkuLike(data) {
        senAjax("/my/updateSkuLike", data,
            function (jsonData) {
                if(jsonData && jsonData.success) {
                    showSuccessDialog(data.skuName + " 执行成功");
                    $('#table').bootstrapTable("refresh");
                }
                else {
                    showErrorDialog(data.skuName + " 执行失败");
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                showErrorDialog(data.skuName + " 执行失败");
            }
        );
    }
</script>
</body>
</html>
