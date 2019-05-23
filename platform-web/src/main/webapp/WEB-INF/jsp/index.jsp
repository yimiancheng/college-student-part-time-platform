<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ include file="./common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta charset="utf-8" />
    <title>首页</title>
    <%@ include file="./common/static/headerLink.jspf"%>
</head>
<body class="no-skin">
<jsp:include page="./common/top.jsp" />
<div class="main-container ace-save-state" id="main-container">
    <div class="main-content">
        <div class="main-content-inner">
            <div class="page-content">
                <input type="hidden" id="select_type_id" value="${requestScope.skuTypeId}"/>
                <div class="col-xs-1" id="nav">
                    <%--nav-pills--%>
                     <%--${requestScope}--%>
                        <ul class="nav nav-stacked nav-list nav-scroll">
                            <c:if test="${requestScope.skuTypeId == 0}">
                                <li role="presentation" class="active"><a href="#" type_id="0">全部</a></li>
                            </c:if>
                            <c:if test="${requestScope.skuTypeId != 0}">
                                <li role="presentation"><a href="#" type_id="0">全部</a></li>
                            </c:if>

                            <c:forEach var="item" items="${requestScope.navs.results}">
                                <li role="presentation" class="${item.id == requestScope.skuTypeId ? 'active' : ''}">
                                    <a href="#" type_id="${item.id}">${item.text}</a></li>
                            </c:forEach>
                    </ul>
                </div>
                <div class="col-xs-11">
                    <%--${requestScope}--%>
                   <%-- <div class="col-xs-6 col-sm-4 col-md-2">
                        <!-- #section:pages/search.thumb -->
                        <div class="thumbnail search-thumbnail">
                            <span
                                class="search-promotion label label-success arrowed-in arrowed-in-right">Sponsored</span>

                            <img class="media-object" data-src="holder.js/100px200?theme=gray"
                                 src="https://img10.360buyimg.com/babel/s590x470_jfs/t1/50931/21/394/101259/5cd4edb5Eb3eadd53/8ee369bdd9fdced9.jpg!q90!cc_590x470.webp"/>
                            <div class="caption">
                                <div class="clearfix">
                                    <span class="pull-right label label-grey info-label">London</span>

                                    <div class="pull-left bigger-110">
                                        <i class="ace-icon fa fa-star orange2"></i>

                                        <i class="ace-icon fa fa-star orange2"></i>

                                        <i class="ace-icon fa fa-star orange2"></i>

                                        <i class="ace-icon fa fa-star-half-o orange2"></i>

                                        <i class="ace-icon fa fa-star light-grey"></i>
                                    </div>
                                </div>

                                <h3 class="search-title">
                                    <a href="#" class="blue">Thumbnail label</a>
                                </h3>
                                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam ...</p>
                            </div>
                        </div>

                        <!-- /section:pages/search.thumb -->
                    </div>--%>

                    <c:forEach var="item" items="${requestScope.skus}">
                        <div class="col-xs-6 col-sm-4 col-md-2">
                            <div class="thumbnail search-thumbnail">
                                <c:if test="${item.daofou}">
                                    <span class="search-promotion label label-success arrowed-in arrowed-in-right">
                                    可刀</span>
                                </c:if>

                                <img class="media-object" data-src="holder.js/100px200?theme=social"
                                     src="${item.skuImg}"/>
                                <div class="caption">
                                    <div class="clearfix">
                                        <span class="pull-right label label-danger info-label">¥${item.price}</span>
                                        <span class="pull-right label label-primary info-label">${item.skuAttr}成新</span>
                                    </div>

                                    <h5 class="search-title">
                                        <a href="${ctx}/item?id=${item.id}" class="blue">${item.skuName}</a>
                                    </h5>

                                    <%--<p class="red bolder smaller col-md-offset-8">${item.price}</p>--%>
                                    <%--<p>${item.skuContent}</p>--%>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </div>
        </div>
    </div>
    <jsp:include page="./common/footer.jsp" />
</div>
<!-- /.main-container -->
<%@ include file="./common/static/aceJs.jspf"%>
<script src="${ctx}/ace_static/assets/js/holder.min.js"></script>

<script>
    jQuery(function($) {
       /* $('.thumbnail').on('mouseenter', function() {
            $(this).find('.info-label').addClass('label-primary');
        }).on('mouseleave', function() {
            $(this).find('.info-label').removeClass('label-primary');
        });*/

        $("#nav a").click(function () {
            var type_id = $(this).attr("type_id");

            if(type_id != $("#select_type_id").val()) {
                var win = window;

                if(window.top != window.self) {
                    win = window.top;
                }

                win.location.href = "${cxt}?skuTypeId=" + type_id;
            }
        });
    });
    
</script>
</body>
</html>
