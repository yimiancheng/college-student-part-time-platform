<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="base.jsp" %>
<script type="text/javascript">
    function activeLeftMenu(href) {
        href = href && href != "/" ? href : "";

        $("#sidebar li").removeClass("active");
        $("#sidebar li").removeClass("open");

        var ativeA = $("#sidebar li").find("a[href='" + href + "']");

        if(!ativeA || ativeA.length != 1) {
            return;
        }

        var parentTxt = null;

        var parent = $(ativeA).parent().parent();

        try {
            if(parent && "submenu" == parent.attr("class")) {
                var pLi = parent.parent();
                pLi.addClass("active open");
                parentTxt = pLi.children("a").children("span").text().trim();
            }
        }
        catch (e) {
            console.log("error: " + e);
        }

        ativeA = ativeA[0];
        $(ativeA).parent('li').addClass("active");

        var $span = $(ativeA).find("span");
        var text = $span.attr("text");
        text = text ? text.trim() : $span.text().trim();

        if (!text) {
            return;
        }

        if (parentTxt) {
            text = parentTxt + "|" + text;
        }

        var $breadcrumb = $("#breadcrumb");
        var titles = text.split("|");
        var html = "";
        var len = titles.length;

        for(var i = 0; i < len; i++) {
            if (i == len - 1 && i != 0) {
                html += '<li class="active">' + titles[i] + '</li>';
            }
            else if (i == 0) {
                html += '<li class="active"><i class="ace-icon fa fa-home home-icon"></i><a href="#">' + titles[i] + '</a></li>';
            }
            else {
                html += '<li><a href="#">' + titles[i] + '</a></li>';
            }
        }

        $breadcrumb.empty();
        $breadcrumb.html(html);
    }
</script>

<script type="text/javascript">
    try{ace.settings.loadState('main-container')}catch(e){}
</script>

<div id="sidebar" class="sidebar responsive ace-save-state">
    <script type="text/javascript">
        try{ace.settings.loadState('sidebar')}catch(e){}
    </script>

    <ul class="nav nav-list" id="menu">
        <li class="">
            <a href="#" class="dropdown-toggle">
                <i class="menu-icon fa fa-desktop"></i>
                <span class="menu-text"> 商品管理 </span>
                <b class="arrow fa fa-angle-down"></b>
            </a>
            <b class="arrow"></b>
            <ul class="submenu">
                <li class="">
                    <a href="${ctx}/product">
                        <i class="menu-icon glyphicon glyphicon-list-alt"></i>
                        <span class="menu-text"> 我的商品 </span>
                    </a>

                    <b class="arrow"></b>

                </li>
                <li class="">
                    <a href="${ctx}/product/page">
                        <i class="menu-icon glyphicon glyphicon-list-alt"></i>
                        <span class="menu-text"> 商品添加 </span>
                    </a>

                    <b class="arrow"></b>

                </li>

                <c:if test="${user.userrole == 'SYS_MNG'}">
                    <li class="">
                        <a href="${ctx}/productType/page">
                            <i class="menu-icon glyphicon glyphicon-list-alt"></i>
                            <span class="menu-text"> 商品类目管理 </span>
                        </a>

                        <b class="arrow"></b>
                    </li>
                </c:if>
            </ul>
        </li>

        <li>
            <a href="#" class="dropdown-toggle">
                <i class="menu-icon glyphicon glyphicon-th"></i>
                <span class="menu-text">订单管理</span>
                <b class="arrow fa fa-angle-down"></b>
            </a>

            <b class="arrow"></b>

            <ul class="submenu">
                <li class="">
                    <a href="${ctx}/my/order">
                        <i class="menu-icon glyphicon glyphicon-list-alt"></i>
                        <span class="menu-text"> 我的订单 </span>
                    </a>

                    <b class="arrow"></b>
                </li>

                <li class="">
                    <a href="${ctx}/my/order/buypage">
                        <i class="menu-icon glyphicon glyphicon-list-alt"></i>
                        <span class="menu-text"> 销售订单 </span>
                    </a>

                    <b class="arrow"></b>
                </li>
            </ul>
        </li>

        <li>
            <a href="${ctx}/my/">
                <i class="menu-icon glyphicon glyphicon-heart"></i>
                <span class="menu-text"> 我的收藏 </span>
            </a>
        </li>

        <c:if test="${user.admin != null && user.admin}">
            <li>
                <a href="${ctx}/user">
                    <i class="menu-icon glyphicon glyphicon-user"></i>
                    <span class="menu-text"> 用户管理 </span>
                </a>
            </li>
        </c:if>

    </ul><!-- /.nav-list -->

    <div class="sidebar-toggle sidebar-collapse" id="sidebar-collapse">
        <i id="sidebar-toggle-icon" class="ace-icon fa fa-angle-double-left ace-save-state" data-icon1="ace-icon fa fa-angle-double-left" data-icon2="ace-icon fa fa-angle-double-right"></i>
    </div>
</div>
