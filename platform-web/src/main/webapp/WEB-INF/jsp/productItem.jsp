<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="./common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>商详页</title>
    <%@ include file="./common/static/headerLink.jspf"%>
</head>
<body class="no-skin">
<jsp:include page="./common/top.jsp" />
<div class="main-container ace-save-state" id="main-container">
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="row">
                    <div class="col-xs-3">
                        <img id="skuImg" class="media-object" style="width: 100%; display: block;" src="">
                    </div>

                    <div class="col-xs-9">
                        <div id="info">
                            <input type="hidden" id="skuID", value="${requestScope.id}">
                            <h3 id="skuName" class="header smaller lighter"></h3>
                            <h4 class="no-padding-left">
                                <strong id="price" class="red"></strong>
                                <small id="daofou" class="green"></small>
                            </h4>
                            <h4 class="no-padding-left">
                                <small id="skuAttr" class="bolder lighter"></small>
                            </h4>
                            <h4 class="no-padding-left">
                                <small id="tradePosition" class="bolder lighter"></small>
                            </h4>
                            <h4 class="no-padding-left">
                                <small id="skuContent" class="bolder lighter"></small>
                            </h4>
                            <h4 class="no-padding-left">
                                <small id="numStock" class="bolder lighter"></small>
                            </h4>
                            <h4 class="no-padding-left">
                                <small id="creatorname" class="bolder lighter"></small>
                            </h4>

                           <%-- ${requestScope.product}--%>

                            <div class="alert alert-danger" id="item_info_div">
                                <button type="button" class="close" data-dismiss="alert">
                                    <i class="ace-icon fa fa-times"></i>
                                </button>

                                <strong>
                                    <i class="ace-icon fa fa-times"></i>
                                    <span>注意！</span>
                                </strong>
                                    <span id="item_info"></span>
                                <br>
                            </div>
                        </div>

                        <div id="error" class="well well-sm"></div>

                        <div id="submitbar" class="btn-group pull-right" style="margin-top: 10px;">
                            <button id="btn_like" type="button" class="btn btn-info">
                                <span class="ace-icon fa fa-heart" aria-hidden="true"></span>收藏
                            </button>
                            <button id="btn_buy" type="button" class="btn btn-success">
                                <span class="ace-icon fa fa-lock" aria-hidden="true"></span>购买
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="./common/footer.jsp" />
</div>
<!-- /.main-container -->
<%@ include file="./common/static/aceJs.jspf"%>

<script>
    var productItem = '${requestScope.sysProduct}';
    var productError = '${requestScope.error}';
    var skuContent = '${requestScope.skuContent}';

    jQuery(function($) {
        init_btn();
        
        $("#error").hide();
        $("#item_info_div").hide();
        if(!productItem && !productError) {
            return;
        }

        if(productError) {
           // productJson = productJson.replace("error:", "");
            $("#error").html(productError);
            $("#error").show();
            $("#info").hide();
            $("#submitbar").hide();
            return;
        }

        var product = null;

        try {
            product = eval("(" + productItem + ")");
        }
        catch (e) {
            product = JSON.parse(productItem);
        }

        var skuImg = product.skuImg;

        if(skuImg) {
            $("#skuImg").attr("src", product.skuImg);
        }
        else {
            $("#skuImg").attr("src", "https://img14.360buyimg.com/n0/jfs/t1/14966/37/12919/61513/5c9c212eEc1b16e93/6d59a2ad48601641.jpg");
        }

        $("#skuName").html(product.skuName);
        $("#skuAttr").html("商品成色：" + product.skuAttr + "成新");
        $("#price").html(product.price + '元');
        $("#daofou").html((product.daofou ? '可刀' : '不可刀'));
        $("#tradePosition").html("交易地点：" + product.tradePosition);
        // skuContent.replace('"', "")
        $("#skuContent").html("商品描述：" + skuContent.substr(1, skuContent.length - 1));

        var productStock = product.productStock;
        var stock = 0;

        if(productStock) {
            var num = productStock.num ? productStock.num : 0;
            var numStock = productStock.numStock ? productStock.numStock : 0;
            stock = (num - numStock);
        }

        $("#numStock").html("可售库存：" + stock);
        $("#creatorname").html("卖家：" + product.creatorname);

        if(stock == 0) {
            $("#item_info_div").show();
            $("#item_info").html("可售库存为0");
            $("#submitbar").hide();
        }

        var buyDate = product.buyDate;

        if(buyDate) {
            buyDate = moment(buyDate, "YYYY-MM-DD HH:mm:ss");

            if(buyDate.isAfter(moment())) {
                $("#item_info_div").show();
                $("#item_info").html("商品还未开售，售卖时间为：" + product.buyDate);
                $("#submitbar").hide();
            }
        }

    });
    
    function init_btn() {
        $("#btn_buy").click(function () {
            if(!isLogin) {
                showErrorDialog("请先登录 <a href='${ctx}/login?returnUrl=" +
                    window.location.href + "'>登录</a>");
            }
            else if($("#skuID").val() > 0){
                window.location.href = "${ctx}/trade?id=" + $("#skuID").val();
            }
        });

        $("#btn_like").click(function () {
            if(!isLogin) {
                showErrorDialog("请先登录 <a href='${ctx}/login?returnUrl=" +
                    window.location.href + "'>登录</a>");
                return;
            }

            var data = {};
            data.skuId = $("#skuID").val();
            data.skuName = $("#skuName").html();
            data.returnUrl = window.location.href;

            senAjax("/my/addSkuLike", data,
                function (jsonData) {
                    if(jsonData && jsonData.success) {
                        showSuccessDialog(data.skuName + " 收藏成功");
                    }
                    else {
                        showErrorDialog(data.skuName + " 收藏失败");
                    }
                },
                function (XMLHttpRequest, textStatus, errorThrown) {
                    showErrorDialog(data.skuName + " 收藏失败");
                }
            );
        });
    }
</script>
</body>
</html>
