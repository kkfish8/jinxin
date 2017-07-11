<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>注册</title>
<link rel="stylesheet" href="plugin/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="plugin/bootstrap/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="plugin/validform/validform.css">
<link rel="stylesheet" type="text/css" href="css/login.css">
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/foot.css" type="text/css">
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
	<div class="container-fluid " style="margin-bottom: 50px">
		<form class="demoform" action="reg.do" method="post" style="color: #999;">
			<br>
			<div class="row">
				<div class="col-md-5"></div>
				<div>
					<span style="font-weight:500;letter-spacing:10px; font-size:30px;color:#222;">用户注册</span>
				</div>
			</div>
			<br>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-1"><span id="basic-addon1" style="float:right;line-height:30px;font-size: 10px;color:#222;">用户名</span></div>
				<div class="col-md-4">
						<input type=text"  name="username" id="username"
						class="form-control" datatype="s6-18" nullmsg="请输入用户名"
						errormsg="用户名至少6个字符,最多18个字符！" placeholder="请输入6-16位用户名">
				</div>
				
			</div>
			<br>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-1"><span style="float:right;line-height:30px;font-size: 10px;color:#222;">密码</span></div>
				<div class="col-md-4">
					<input type="password" name="userpassword" class="form-control"
						name="userpassword" datatype="*6-16" nullmsg="请设置密码！"
						errormsg="密码范围在6~16位之间！" placeholder="请输入6-16位密码">
				</div>
				
			</div>
			<br>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-1"><span id="basic-addon1" style="float:right;line-height:30px;font-size: 10px;color:#222;">重复密码</span></div>
				<div class="col-md-4">
					<input type="password" class="form-control" datatype="*"
						recheck="userpassword" nullmsg="请重复密码！" errormsg="两次密码不一致"
						placeholder="重复密码">
				</div>
				
			</div>
			<br>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-1"><span id="basic-addon1" style="float:right;line-height:30px;font-size: 10px;color:#222;">真实姓名</span></div>
				<div class="col-md-4">
					<input type="text" name="name" class="form-control" datatype="*" nullmsg="请输入姓名!"
						placeholder="真实姓名">
				</div>
				
			</div>
			<br>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-1"><span style="float:right;color:#222;">性别</span></div>
				<div class="col-md-1">
					<input type="radio" name="sex" value="男" style="color:#222;"/>男
				</div>
				<div class="col-md-1">
					<input type="radio" name="sex" value="女" style="color:#222;"/>女
				</div>
				
			</div>
			<br>
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-1"><span id="basic-addon1" style="float:right;line-height:30px;color:#222;">邮箱</span></div>
				<div class="col-md-4">
					<input name="email" type="text" class="form-control"
						placeholder="E-Mail" datatype="e" nullmsg="请输入您常用的邮箱！"
						errormsg="请输入您常用的邮箱！">
				</div>
				
			</div>
			<br>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-2">
					<button type="reset" class="btn btn-primary" style="width: 100%">重置</button>
				</div>
				<div class="col-md-2">
					<button class="btn btn-primary" style="width: 100%" id="reg">注册</button>
				</div>
				<div class="col-md-4"></div>
			</div>
		</form>
	</div>
</div>
	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>
	<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
	<script src="plugin/jquery-1.11.3.min.js"></script>
	<script src="plugin/validform/Validform_v5.3.2_min.js"></script>

	<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
	<script src="plugin/bootstrap/js/bootstrap.min.js"></script>
	<script src="js/app.js"></script>
</body>
</html>