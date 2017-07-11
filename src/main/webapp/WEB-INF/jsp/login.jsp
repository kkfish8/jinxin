<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   
<script type="text/javascript" src="plugin/jquery-1.11.3.min.js"></script>
<script type="text/javascript"
	src="plugin/validform/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<link rel="stylesheet" type="text/css"
	href="plugin/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/login.css">
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/foot.css" type="text/css">
<title>登录</title>
</head>
<body>

	<div class="top">
		<img src="img/school.png" style="float: right" class="topImg">
		<div class="top_img">
			<img src="img/LOGO2.png" class="logo">
		</div>
		<div class="top_nav">
			<ul>
				<a href="index.do"><li>首页</li></a>
				<a href="zjfc.do"><li>专家风采</li></a>
				<a href="news.do"><li>新闻动态</li></a>
				<a href="gonggao.do"><li>通知公告</li></a>
				<a href="download.do"><li>资料下载</li></a>
			</ul>
		</div>
	</div>
	<div class="forgetPass">
		<form class="subform" action="login.do" method="post">
			<table class="table">
				<tr>
					<td colspan="3"><span class="span" style="font-weight:500;letter-spacing:10px;">登录</span></td>
				</tr>
				<tr>
					<td><label for="userName">用户名：</label></td>
					<td colspan="2"><input type="text" name="userName"
						id="userName" class="form-control" datatype="s6-16" errormsg=" "
						nullmsg=" " sucmsg=" " /></td>
				</tr>
				<tr>
					<td><label for="passWord">密&nbsp;码：</label></td>
					<td colspan="2"><input type="password" name="passWord"
						id="passWord" class="form-control" datatype="s6-16" errormsg=" "
						nullmsg=" " sucmsg=" " /></td>
				</tr>
				<tr>
					<td><label for="testCode">验证码：</label></td>
					<td><input maxlength="6" type="text" class="form-control"
						name="testCode" id="testCode" datatype="s4-4" errormsg=" "
						nullmsg=" " sucmsg=" " /></td>
					<td><img id="imgObj" alt="验证码" src="code.do"
						onclick="changeImg()"></td>
				</tr>
				<tr>
					<td></td>
					<td colspan="3">

						<button name="sub" value="登录" class="btn btn-primary sub-btn">登录</button>
						<a href="forgetPassWord.do">忘记密码</a>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<span>没有账号？</span><a href="register.do" style="color:#3a416e;">立即注册</a>
					</td>
				</tr>
			</table>
		</form>

	</div>

	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>
</body>
</html>