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
<title>${title }</title>
<link href="plugin/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="plugin/jquery-1.11.3.min.js"></script>
<script src="plugin/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/top.css" type="text/css">
<link rel="stylesheet" href="css/middle.css" type="text/css">
<link rel="stylesheet" href="css/foot.css" type="text/css">
<script type="text/javascript" src="plugin/jquery.SuperSlide.2.1.1.js"></script>
<script src="js/index.js"></script>
<script>
	$(function(){
		$('#myCarousel').carousel({
			  interval: 4000
			});
	});
</script>
</head>
                                                
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

				<a href="admin/management-extractRecord.do"><li class="top_login" style="right: 100px">抽取专家</li></a>
				<c:choose>
						<c:when test="${sessionScope.user==null}">
							<a href="loginpage.do"><li class="top_login">登录</li></a>
						</c:when>
						<c:when test="${sessionScope.user!=null}">
							<a href="logined/userInfo.do"><li class="top_login">用户中心</li></a>
						</c:when>
					</c:choose>
				
			</ul>
		</div>
	</div>
	<div class="middle">
		<div class="middle_one">
			<div style="width:450px;height:250px;float:left;border-radius:8px;" >
				<div id="myCarousel" class="carousel slide">
				   <!-- 轮播（Carousel）指标 -->
				   <ol class="carousel-indicators" style="bottom:0px;">
				      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				      <li data-target="#myCarousel" data-slide-to="1"></li>
				      <li data-target="#myCarousel" data-slide-to="2"></li>
				   </ol>   
				   <!-- 轮播（Carousel）项目 -->
				   <div class="carousel-inner">
				      <div class="item active">
				         <img src="${lunbo1}" alt="第一张幻灯片" style="width:450px;height:250px;">
				      </div>
				      <div class="item">
				         <img src="${lunbo2}" alt="第二张幻灯片" style="width:450px;height:250px;">
				      </div>
				      <div class="item">
				         <img src="${lunbo3}" alt="第三张幻灯片" style="width:450px;height:250px;">
				      </div>
				   </div>
				</div>
			</div>
			
			<div class="middle_nav">
				<ul class="nav_tab" id="nav_tab">
					<li class="active">综合</li>
					<a href="news.do"><li>新闻</li></a>
					<a href="gonggao.do"><li>公告</li></a>
					<a href="download.do"><li>资料</li></a>
				</ul>
				<div id="nav_content">
					<ul class="nav_content" style="display: block;">
						<c:forEach var="news" items="${allList}">
							<li>
								<div class="nav_li">
									<a href='article.do?id=<c:out value="${news.id }" />'>
										<c:out value="${news.title }" /></a>
									<P class="nav_time">
										<fmt:formatDate value="${news.publishDate }" pattern="yyyy-MM-dd"/>
									</P>
								</div>
							</li>
						</c:forEach>
					</ul>
					<ul class="nav_content">
						<c:forEach var="news" items="${new1}">
							<li>
								<div class="nav_li">
									<a href='article.do?id=<c:out value="${news.id }" />'>
										<c:out value="${news.title }" /></a>
									<P class="nav_time">
										<fmt:formatDate value="${news.publishDate }" pattern="yyyy-MM-dd"/>
									</P>
								</div>
							</li>
						</c:forEach>
					</ul>
					<ul class="nav_content">
						<c:forEach var="news" items="${new2}">
							<li>
								<div class="nav_li">
									<a href='article.do?id=<c:out value="${news.id }" />'>
										<c:out value="${news.title }" /></a>
									<P class="nav_time">
										<fmt:formatDate value="${news.publishDate }" pattern="yyyy-MM-dd"/>
									</P>
								</div>
							</li>
						</c:forEach>
					</ul>
					<ul class="nav_content">
						<c:forEach var="news" items="${new3}">
							<li>
								<div class="nav_li">
									<a href='article.do?id=<c:out value="${news.id }" />'>
										<c:out value="${news.title }" /></a>
									<P class="nav_time">
										<fmt:formatDate value="${news.publishDate }" pattern="yyyy-MM-dd"/>
									</P>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="newExperts">
			<div class="newExperts_title">
				<h3>新申报专家入库流程</h3>
			</div>
			<div class="newExperts_content">
				<div class="newExperts_left">
					<ul>
						<li><span>1.<a href="register.do">用户注册</a></span></li>
						<img src="img/jiantou.png">
						<li><span>2.<a href="loginpage.do">用户登录</a></span></li>
						<img src="img/jiantou.png">
						<li><span>3.在线填报</span></li>
						<img src="img/jiantou.png">
						<li><span>4.管理审核</span></li>
						<img src="img/jiantou.png">
						<li><span>5.成为专家</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技<a
			href="admin/management.do">后台管理</a></span>
	</div>
	<script type="text/javascript">
		$(".picMarquee-left").
		slide({mainCell:".bd ul",autoPlay:true,effect:"leftMarquee",vis:3,interTime:50,trigger:"click"});
	</script>
</body>
</html>
