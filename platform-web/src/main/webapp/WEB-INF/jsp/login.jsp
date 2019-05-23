<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta charset="utf-8"/>
    <title>账号登录</title>
    <meta name="description" content="User login page"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>

    <link rel="icon" href="${ctx}/ace_static/img/favicon.ico" mce_href="${ctx}/ace_static/img/favicon.ico"
          type="image/x-icon"/>

    <link rel="stylesheet" href="${ctx}/ace_static/assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${ctx}/ace_static/assets/font-awesome/4.5.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="${ctx}/ace_static/assets/css/ace.min.css" class="ace-main-stylesheet"
          id="main-ace-style"/>
    <link rel="stylesheet" href="${ctx}/ace_static/assets/css/ace-skins.min.css"/>
    <link rel="stylesheet" href="${ctx}/ace_static/assets/css/ace-rtl.min.css"/>
    <script src="${ctx}/ace_static/assets/js/ace-extra.min.js"></script>
    <script src="${ctx}/ace_static/assets/js/jquery-2.1.4.min.js"></script>
</head>

<body class="login-layout" style="background-color: #DFE0E2">
<div class="main-container">
    <div class="main-content">
        <div class="row">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="login-container">
                    <div class="position-relative" style="margin-top: 10%;">
                        <div id="login-box" class="login-box visible widget-box no-border"
                             style="background-color: #DFE0E2">
                            <div class="widget-body">
                                <div class="widget-main">
                                    <h4 class="header blue lighter bigger">
                                        <i class="icon-coffee green"></i>
                                        二手书交易平台管理系统
                                    </h4>

                                    <div class="space-6"></div>

                                    <form>
                                        <fieldset>
                                            <label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="text" class="form-control"
                                                                   placeholder="Username" id="username"/>
															<i class="icon-user"></i>
														</span>
                                            </label>

                                            <label class="block clearfix">
														<span class="block input-icon input-icon-right">
															<input type="password" class="form-control"
                                                                   placeholder="Password" id="password"/>
															<i class="icon-lock"></i>
														</span>
                                            </label>

                                            <label class="red help-block" id="error">
                                            </label>

                                            <div class="space"></div>

                                            <div class="clearfix">
                                                <button type="button" class="width-35 pull-right btn btn-sm btn-primary"
                                                        id="login">
                                                    <i class="icon-key"></i>
                                                    登录
                                                </button>
                                            </div>

                                            <div class="space-4"></div>
                                        </fieldset>
                                    </form>

                                    <div class="social-or-login center">
                                        <span class="smaller-110">登录问题，请联系：0411-84708320</span>
                                    </div>
                                </div><!-- /widget-main -->

                            </div><!-- /widget-body -->
                        </div><!-- /login-box -->
                        </di>
                    </div><!-- /.col -->
                </div><!-- /.row -->
            </div>
        </div><!-- /.main-container -->

        <!-- basic scripts -->

        <!-- inline scripts related to this page -->

        <script type="text/javascript">
            jQuery(function ($) {
                $('#login').click(function () {
                    login();
                });

                document.onkeydown = function (event) {
                    var e = event || window.event || arguments.callee.caller.arguments[0];

                    if (e && e.keyCode == 13) {
                        $('#login').click();
                    }
                };
            });


            function getQueryString(name) {
                var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
                var r = window.location.search.substr(1).match(reg);
                if(r!=null)return  unescape(r[2]); return null;
            }

            function login() {
                var username = $('#username').val();
                var password = $('#password').val();

                if (!username || !password) {
                    $("#error").text("用户名密码不能为空！");
                    return;
                }

                $.ajax({
                    url: "${ctx}/loginAction",
                    data: {
                        username: username,
                        password: password,
                        returnUrl: getQueryString("returnUrl")
                    },
                    type: "post",
                    dataType: "json",
                    beforeSend: function () {
                        $("#login").attr("disabled", true);
                        $("#error").text("");
                    },
                    complete: function (XMLHttpRequest, textStatus) {
                        $("#login").attr("disabled", false);
                    },
                    success: function (result) {
                        if (!result.success) {
                            $("#error").text(result.resultMessage);
                        }
                        else {
                            top.location.href = result.resultMessage ? result.resultMessage : "${ctx}/";
                        }
                    },
                    error: function (e) {
                        $("#login").attr("disabled", false);
                        $("#error").text("网络问题，请刷新重试！");
                    }
                });
            }

        </script>
</body>
</html>

