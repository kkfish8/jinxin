<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<meta http-equiv="expires" content="0">   
<title>新闻动态</title>
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/subpage.css" type="text/css">
<link rel="stylesheet" href="css/subpage_nav.css" type="text/css">
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
							<a href="logined/userInfo.do"><li class="top_login">${sessionScope.user}</li></a>
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
					<span>首页</span> <span> > </span> <span style="color: #f90;">动态新闻</span>
				</div>
				<div id="subContent_right_content">
					<ul id="subContent_right_content_nav">
						<c:forEach var="a" items="${article}">
							<li><a href="article.do?id=${a.id}">${a.title}</a><span><fmt:formatDate value="${a.publishDate}" pattern="yyyy-MM-dd"/></span></li>
						</c:forEach>
						
					</ul>
					<ul id="subContent_right_content_num">
						<c:if test="${page!=1}">
						<li><a href="news.do?page=${page-1 }">上一页</a></li>
						</c:if>
						
						<c:if test="${count==15 }">
							<li><a href="news.do?page=${page+1 }">下一页</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>


</body>
</html>
