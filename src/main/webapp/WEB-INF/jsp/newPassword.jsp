<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   <title>修改密码</title>
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/forgetPass.css" type="text/css">
<link rel="stylesheet" href="css/foot.css" type="text/css">
<script src="plugin/jquery-1.11.3.min.js"></script>
<script>
	var isSub = $
	{
		isSub
	};
	var sid = "${sid}";
	var userid = $
	{
		userid
	};
	$(document).ready(function() {
		$(".forgetPass_frim").click(function() {
			if (isSub == false)
				return;
			var pass = $('#newPassWord').val();
			var pass1 = $('#newPassWord1').val();

			if (pass != pass1) {
				alert("两次密码错入不正确");
				return;
			}

			$.post("ModPassWordAction.do", {
				"password" : pass,
				"userid" : userid,
				"sid" : sid
			}, function(data) {
				alert(data);
				document.location.href = "loginpage.do";
			});
		});
	})
</script>
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
		<div class="forgetPass_title">
			<div style="float: left;">修改密码</div>
			<span style="color: #f00; margin: 10px;">${res }</span>
		</div>
		<table>
			<tr>
				<td><label>新密码：</label></td>
				<td><input type="text" placeholder="请输入您的新密码"
					class="forgetPass_input" id="newPassWord"></td>
			</tr>
			<tr>
				<td><label>再次输入：</label></td>
				<td><input type="text" placeholder="请再次输入您的新密码"
					class="forgetPass_input" id="newPassWord1"></td>
			</tr>

			<tr>
				<td colspan="2"><input type="submit" value="确 定"
					class="forgetPass_frim"></td>
			</tr>
		</table>
	</div>

	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>
</body>
</html>
