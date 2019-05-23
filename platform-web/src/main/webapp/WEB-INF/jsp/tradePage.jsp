<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="./common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>结算页</title>
    <%@ include file="./common/static/headerLink.jspf"%>
</head>
<body class="no-skin">
<jsp:include page="./common/top.jsp" />
<div class="main-container ace-save-state" id="main-container">
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <div class="container">
                    <c:if test="${not empty requestScope.error}">
                        <div class="alert alert-danger" id="item_info_div">
                            <button type="button" class="close" data-dismiss="alert">
                                <i class="ace-icon fa fa-times"></i>
                            </button>

                            <strong>
                                <i class="ace-icon fa fa-times"></i>
                                <span>注意！</span>
                            </strong>
                                ${requestScope.error}
                            <br>
                        </div>
                    </c:if>

                    <c:if test="${not empty requestScope.sysProduct && empty requestScope.error}">
                        <h3 class="header smaller lighter red">送货清单</h3>
                        <div class="well well-sm">
                            <h4 class="no-padding-left">
                                <small class="bolder lighter">商家：</small>
                                <small id="creatorname" class="bolder lighter">${requestScope.sysProduct.creatorname}</small>
                            </h4>

                            <h4 class="no-padding-left">
                                <small class="bolder lighter">商品：</small>
                                <small id="skuName" class="bolder lighter">${requestScope.sysProduct.skuName}</small>
                            </h4>

                            <h4 class="no-padding-left">
                                <small class="bolder lighter">价格：</small>
                                <small id="price" class="bolder lighter red">${requestScope.sysProduct.price}</small>
                            </h4>

                            <h4 class="no-padding-left">
                                <small class="bolder lighter">数量：</small>
                                <input id="buyNum" type="text" />
                            </h4>

                            <h4 class="no-padding-left">
                                <small class="bolder lighter">总价：</small>
                                <%--<input id="orderPrice" type="text" />--%>
                                <small id="orderPrice" class="bolder lighter red"></small>
                            </h4>

                            <input type="hidden" id="skuUserId" value="${requestScope.sysProduct.userId}"/>
                            <input type="hidden" id="skuId" value="${requestScope.id}"/>
                            <input type="hidden" id="canBuyNum" value="${empty requestScope.buyStock ? 0 :
                                requestScope.buyStock}"/>

                            <div class="form-group">
                                <h4 class="no-padding-left">
                                    <small class="bolder lighter">备注：</small>
                                </h4>

                                <textarea class="form-control autosize-transition" id="orderContent"
                                          placeholder="订单备注 ..."></textarea>
                            </div>

                            <div class="btn-group col-xs-offset-11">
                                <button id="btn_buy" type="button" class="btn btn-success">
                                    <span class="ace-icon fa fa-filter" aria-hidden="true"></span>提交订单
                                </button>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="./common/footer.jsp" />
</div>
<!-- /.main-container -->
<%@ include file="./common/static/aceJs.jspf"%>
<script src="${ctx}/ace_static/assets/js/spinbox.min.js"></script>

<script>
    jQuery(function($) {
        var canBuyNum = $("#canBuyNum").val();
        canBuyNum = typeof(canBuyNum) == "undefined" || canBuyNum == null ? 0 : Number(canBuyNum);
        var price = $("#price").html();
        price = Number(price);

        //$('#spinner1').ace_spinner('disable').ace_spinner('value', 11);
        //or
        //$('#spinner1').closest('.ace-spinner').spinner('disable').spinner('enable').spinner('value', 11);//disable, enable or change value
        //$('#spinner1').closest('.ace-spinner').spinner('value', 0);//reset to 0

        $('#buyNum').ace_spinner({
            value: 1,
            min: 1,
            max: canBuyNum,
            step: 1,
            on_sides: true,
            icon_up: 'ace-icon fa fa-plus bigger-110',
            icon_down: 'ace-icon fa fa-minus bigger-110',
            btn_up_class: 'btn-success',
            btn_down_class: 'btn-danger'
        })
        .closest('.ace-spinner')
        .on("changed.fu.spinbox", function() {
            var orderPrice = $('#buyNum').val() * price;
            $("#orderPrice").html(orderPrice);
        });

       /* $('#buyNum').change(function () {
            console.log(2, $(this).val());
        });*/

        var orderPrice = $('#buyNum').val() * price;
        // console.log(orderPrice, $('#buyNum').val(), );
        $("#orderPrice").html(orderPrice);
        
        $("#btn_buy").click(function () {
            buySku();
        });
    });
    
    function buySku() {
        var data = {};
        data.skuId = $("#skuId").val();
        data.skuUserId = $("#skuUserId").val();
        data.skuNum = $("#buyNum").val();
        data.skuPrice = $("#price").html();
        data.orderPrice = $("#orderPrice").html();
        data.orderContent = $("#orderContent").val();

        senAjax("/order/submitOrder", data,
            function (uuid) {
                var form = document.createElement("form");
                document.body.appendChild(form);
                var uuidDom = generateHideElement("uuid", uuid);
                form.appendChild(uuidDom);
                form.method = "post";
                form.action = "/order/";
                console.log(form);
                form.submit();
            },
            function (XMLHttpRequest, textStatus, errorThrown) {
                // do nothing
            }
        );
    }

    var generateHideElement = function (name, value) {
        var tempInput = document.createElement("input");
        tempInput.type = "hidden";
        tempInput.name = name;
        tempInput.value = value;
        return tempInput;
    }

</script>
</body>
</html>
