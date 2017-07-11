<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   
<title><c:out value="${data.title }"></c:out></title>
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/subpage.css" type="text/css">
<link rel="stylesheet" href="css/subpage_article.css" type="text/css">
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
				
				<c:choose>
						<c:when test="${sessionScope.user==null}">
							<a href="loginpage.do"><li class="top_login">登录</li></a>
						</c:when>
						<c:when test="${sessionScope.user!=null}">
							<a href="logout.do"><li class="top_login">注销</li></a>
						</c:when>
					</c:choose>
			</ul>
		</div>
	</div>
	<div id="subpage">
		<div id="subContent">
			<div id="subContent_left">
				<div id="subContent_left_title">站点导航</div>
				<ul type="none">
					<a href="index.do"><li>首页</li></a>
					<a href="zjfc.do"><li>专家风采</li></a>
					<a href="news.do"><li>动态新闻</li></a>
					<a href="gonggao.do"><li>通知公告</li></a>
					<a href="download.do"><li>资料下载</li></a>
				</ul>
			</div>
			<div id="subContent_right">
				<div id="subContent_right_title">
					<h2>
						<c:out value="${data.title }"></c:out>
					</h2>
					<div id="subContent_right_title_info">
						<span><c:out value="${data.publishDate }"></c:out></span> &nbsp; <span>发表人:${data.user.username }</span>
						<span></span>
					</div>
				</div>
				<div id="subContent_right_content">
					<span>${data.content}</span>

				</div>
			</div>
		</div>
	</div>
	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>
</body>
</html>
