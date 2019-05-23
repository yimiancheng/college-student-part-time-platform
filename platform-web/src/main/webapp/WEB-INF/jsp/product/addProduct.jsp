<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="../common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>添加商品</title>
    <%@ include file="../common/static/headerLink.jspf"%>
    <link rel="stylesheet" href="${ctx}/ace_static/bootstrap-switch/css/bootstrap-switch.min.css"/>
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
                    <div role="form" id="edit_bug" class="form-horizontal">
                        <div class="form-group">
                            <%-- align-left --%>
                            <label class="col-xs-2 control-label">商品名称：</label>

                            <div class="input-group col-xs-8">
                                <input id="skuName" type="text" class="form-control" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">商品类目：</label>

                            <div class="col-xs-3 form-inline no-padding-left">
                                <select id="skuTypeId" name="skuTypeId" class="form-control"
                                        placeholder="请选择商品类目..."></select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">商品图片：</label>

                            <div class="input-group col-xs-8">
                                <input id="skuImg" type="text" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">商品成色：</label>

                            <div class="input-group col-xs-8">
                                <div class="rating inline"></div>
                                <p class="help-block">商品成色，分为1 - 10等！</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">交易地点：</label>

                            <div class="input-group col-xs-8">
                                <input id="tradePosition" type="text" class="form-control"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">商品库存：</label>

                            <div class="input-group col-xs-8">
                                <input id="skuNum" type="text" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">商品售卖时间：</label>

                            <div class="input-group col-xs-3">
                                <input id="bugDate_datetime" type="text" class="form-control" readonly/>
                                    <span class="input-group-addon">
                                        <i class="fa fa-clock-o bigger-110"></i>
                                    </span>
                                <input type="hidden" id="bugDate" value=""/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">商品价格：</label>

                            <div class="input-group col-xs-8 no-padding">
                                <input id="price" type="text" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">是否可刀：</label>

                            <div class="input-group col-xs-8 no-padding">
                                <input id="daofou" type="checkbox" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label">商品描述：</label>

                            <div class="input-group col-xs-8">
                                <textarea class="form-control autosize-transition" id="skuContent" placeholder="商品描述 ..."></textarea>
                            </div>
                        </div>

                        <div class="col-xs-offset-2">
                            <button class="btn btn-primary">
                                <i class="ace-icon fa fa-check bigger-110"></i>
                                提交</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/footer.jsp" />
</div>
<!-- /.main-container -->
<%@ include file="../common/static/aceJs.jspf"%>
<script src="${ctx}/ace_static/assets/js/jquery.raty.min.js"></script>
<script src="${ctx}/ace_static/assets/js/spinbox.min.js"></script>
<script src="${ctx}/ace_static/bootstrap-switch/js/bootstrap-switch.min.js"></script>

<script>
    var raty_hints = [];

    jQuery(function($) {
        for(var i = 1; i <= 10; i++) {
            raty_hints[i - 1] = i + "成新";
        }

        init_select2();
        init_ace_spinner();
        initSwitch();
        init_datetimepicker("bugDate_datetime", "bugDate", 'hour', 'month', 'yyyy-mm-dd hh:ii:00');

        $("#edit_bug button:last").click(function () {
            save_product();
        });

        $('.rating').raty({
            // cancel : true,
            half: false,
            starType : 'i',
            number: raty_hints.length,
            hints: raty_hints,
            targetType: 'hint',
            targetKeep: true,
            targetText: '请选择成色',
            precision: false,
            score: 8,
            click: function(score, evt) {

            }
        }).find('i:not(.star-raty)').css("color", "#01c30b");
    });
    
    function save_product() {
        var data = {};
        data.skuName = $("#skuName").val();
        data.skuTypeId = $("#skuTypeId").val();
        data.skuImg = $("#skuImg").val();
        data.tradePosition = $("#tradePosition").val();
        data.skuNum = $("#skuNum").val();
        data.buyDate = $("#bugDate").val();
        data.price = $("#price").val();
        data.daofou = "on" == $("#daofou").val() ? 1 : 0;
        data.skuContent = $("#skuContent").val();
        data.skuAttr = $('.rating').raty('score');

        // console.log(data);

        senAjax("/product/saveProduct", data,
            function (jsonData) {
                if(jsonData && jsonData.success) {
                    showSuccessDialog(data.skuName + " 保存成功");
                }
                else {
                    showErrorDialog(data.skuName + " 保存失败");
                }
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                showErrorDialog(data.skuName + " 保存失败");
            }
        );
    }

    function initSwitch() {
        $("#daofou").bootstrapSwitch({
            state: 1,
            baseClass: 'bootstrap-switch',
            onColor: 'success',
            offColor: 'danger',
            onText: '可刀',
            offText: '不刀',
            size: 'large'
        });
    }

    function init_ace_spinner() {
        $('#price').ace_spinner({
            value: 100,
            min: 0.5,
            max: 1000000,
            step: 0.5,
            format: "¥#.00",
            on_sides: true,
            icon_up: 'ace-icon fa fa-plus bigger-110',
            icon_down: 'ace-icon fa fa-minus bigger-110',
            btn_up_class: 'btn-success',
            btn_down_class: 'btn-danger'
        });

        $('#skuNum').ace_spinner({
            value: 1,
            min: 1,
            max: 1000000,
            step: 1,
            on_sides: true,
            icon_up: 'ace-icon fa fa-plus bigger-110',
            icon_down: 'ace-icon fa fa-minus bigger-110',
            btn_up_class: 'btn-success',
            btn_down_class: 'btn-danger'
        });
    }
    
    function init_select2() {
        $("#skuTypeId").select2({
            multiple: false,
            width: '100%',
            ajax: {
                url: '${cxt}/productType/select2ProductTypes',
                dataType: 'json',
                type: 'POST',
                cache: true
            },
            delay: 250,
            allowClear: true,
            placeholder: "请选择商品类目...",
            minimumResultsForSearch: -1,
        });
    }
</script>
</body>
</html>
