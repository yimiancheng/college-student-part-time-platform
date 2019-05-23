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

                    <c:if test="${!sessionScope.order.success}">
                        <div class="alert alert-danger" id="item_info_div">
                            <button type="button" class="close" data-dismiss="alert">
                                <i class="ace-icon fa fa-times"></i>
                            </button>

                            <strong>
                                <i class="ace-icon fa fa-times"></i>
                                <span>注意！</span>
                            </strong>
                                ${order.resultMessage}
                            <br>
                        </div>
                    </c:if>

                    <c:if test="${sessionScope.order.success}">
                        <h3 class="header smaller lighter red">感谢您，订单提交成功！</h3>
                        <div class="well well-sm">
                            <div class="alert alert-warning">
                                <h3 class="green smaller lighter">卖家信息</h3>

                                <h4 class="no-padding-left">
                                    <small class="bolder lighter">账号：</small>
                                    <small class="bolder lighter red">${order.result.userVo.username}</small>
                                </h4>

                                <c:if test="${not empty order.result.userVo.usernick}">
                                    <h4 class="no-padding-left">
                                        <small class="bolder lighter">姓名：</small>
                                        <small class="bolder lighter red">${order.result.userVo.usernick}</small>
                                    </h4>
                                </c:if>

                                <c:if test="${not empty order.result.userVo.wxid}">
                                    <h4 class="no-padding-left">
                                        <small class="bolder lighter">微信：</small>
                                        <small class="bolder lighter red">${order.result.userVo.wxid}</small>
                                    </h4>
                                </c:if>

                                <c:if test="${not empty order.result.userVo.phone}">
                                    <h4 class="no-padding-left">
                                        <small class="bolder lighter">手机：</small>
                                        <small class="bolder lighter red">${order.result.userVo.phone}</small>
                                    </h4>
                                </c:if>

                                <c:if test="${not empty order.result.userVo.userContent}">
                                    <h4 class="no-padding-left">
                                        <small class="bolder lighter">签名：</small>
                                        <small class="bolder lighter red">${order.result.userVo.userContent}</small>
                                    </h4>
                                </c:if>

                            </div>

                            <div class="btn-group no-padding-left">
                                <button id="btn_order" type="button" class="btn btn-success">
                                    查看订单
                                </button>

                                <button id="btn_homePage" type="button" class="btn btn-info">
                                    跳转首页
                                </button>
                            </div>

                            <div class="hr hr10 hr-dotted"></div>

                            <ul class="list-group list-view">
                                <li class="list-group-item list-group-item-success">1 ：商家发货后，用户需在后台确认收货。</li>
                                <li class="list-group-item list-group-item-success">2 ：商家如未及时沟通，请及时与商家联系。</li>
                                <li class="list-group-item list-group-item-success">3 ：商家发货前，订单可取消。</li>
                            </ul>
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

<script>
    jQuery(function($) {
        $("#btn_order").click(function () {
            window.location.href = "${ctx}/my/order";
        });

        $("#btn_homePage").click(function () {
            window.location.href = "${ctx}/index";
        });
    });

</script>
</body>
</html>
