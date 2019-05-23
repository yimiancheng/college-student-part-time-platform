<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    var isLogin = ${not empty user.id};

    jQuery(function($) {
		if(isLogin) {
            $(".loginAfter").show();
            $(".loginBefore").hide();
		}
		else {
            $(".loginAfter").hide();
            $(".loginBefore").show();
		}
    });

    function dologout(){
        var param = {
            "param": (new Date()).getMilliseconds()
		};

        $.ajax({
            type:'post',
            url:"${ctx}/logoutAction",
            data: param,
            dataType: 'json',
            cache:false,
            success:function(msg){
                top.location.reload();
            }
        })
    }
</script>

<div id="navbar" class="navbar navbar-default ace-save-state">
	<div class="navbar-container ace-save-state" id="navbar-container">
		<button type="button" class="navbar-toggle menu-toggler pull-left" id="menu-toggler" data-target="#sidebar">
			<span class="sr-only">Toggle sidebar</span>

			<span class="icon-bar"></span>

			<span class="icon-bar"></span>

			<span class="icon-bar"></span>
		</button>

		<div class="navbar-header pull-left">
			<a href="${cxt}/index" class="navbar-brand">
				<small>
					<i class="fa fa-leaf"></i>
					二手书交易平台
				</small>
			</a>
		</div>

		<div class="navbar-buttons navbar-header pull-right" role="navigation">
			<ul class="nav ace-nav">
				<li class="light-blue dropdown-modal">
					<a data-toggle="dropdown" href="#" class="dropdown-toggle">
						<img class="nav-user-photo" src="${cxt}/ace_static/assets/images/avatars/avatar3.png"
							 alt="Jason's Photo" />
						<span class="user-info">
							<small>Welcome,</small>
							${empty user.usernick ? user.username : user.usernick}
						</span>

						<i class="ace-icon fa fa-caret-down"></i>
					</a>

					<ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						<li class="loginAfter">
							<a href="${ctx}/backend">
								<i class="ace-icon fa  fa-asterisk"></i>
								我的后台
							</a>
						</li>

						<li class="loginAfter">
							<a href="#" onclick="dologout()">
								<i class="ace-icon fa fa-power-off"></i>
								退出
							</a>
						</li>

						<li class="loginBefore">
							<a href="${ctx}/login">
								<i class="ace-icon fa fa-bullhorn"></i>
								登录
							</a>
						</li>

					</ul>
				</li>
			</ul>
		</div>

	</div><!-- /.navbar-container -->
</div>