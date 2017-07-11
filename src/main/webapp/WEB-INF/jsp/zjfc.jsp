<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>专家风采</title>
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/subpage.css" type="text/css">
<link rel="stylesheet" href="css/subpage_mien.css" type="text/css">
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
				<div id="subContent_left_title">专业领域</div>
				<ul type="none">
					<c:forEach var="d" items="${field }" begin="1">
						<a href="zjfc.do?id=${d.id }"><li>${d.name }</li></a>
					</c:forEach>
					
					
				</ul>
			</div>
 			<div id="subContent_right">
				<div class="mien">
					<div class="mien_title">专家风采</div>
					<c:forEach var="a" items="${app }">
					<div class="mien_info">
						<img src="${a.inchPhoto }" class="mien_info_img">
						<div class="info">
							<table>
								<tr>
									<td>姓名：</td>
									<td>${a.name }</td>
								</tr>
								<tr>
									<td>专家职称：</td>
									<td>${a.nowMajor }</td>
								</tr>
								<tr>
									<td valign="top">个人简介：</td>
									<td>我毕业于${a.graduateSchool }, ${a.education }学历。${a.academicDegree }学位。现在从事的是${a.nowMajor }。
									</td>
								</tr>
							</table>
						</div>
					</div>
					</c:forEach>
					

					<ul id="subContent_right_content_num">
					<c:if test="${page!=1 }">
						<li><a href="zjfc.do?page=${page-1}&id=${id}">上一页</a></li>
					</c:if>
						
						<c:if test="${count==10 }">
						<li><a href="zjfc.do?page=${page+1 }&id=${id}">下一页</a></li>
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
