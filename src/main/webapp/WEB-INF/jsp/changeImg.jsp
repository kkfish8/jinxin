<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   <title>头像修改</title>
<link rel="stylesheet" href="../css/top.css" type="text/css">
<link rel="stylesheet" href="../css/userInfo.css" type="text/css">
<link rel="stylesheet" href="../css/foot.css" type="text/css">
<script src="../plugin/jquery-1.11.3.min.js"></script>
<script>
	function checkIsApply() {
		document.location.href = "userDetailed.do";
	}
</script>
</head>

<body>
	<div class="top">
		<img src="../img/school.png" style="float: right" class="topImg">
		<div class="top_img">
			<img src="../img/LOGO2.png" class="logo">
		</div>
		<div class="top_nav">
			<ul>
				<a href="../index.do"><li>首页</li></a>
				<a href="../zjfc.do"><li>专家风采</li></a>
				<a href="../news.do"><li>新闻</li></a>
				<a href="../gonggao.do"><li>公告</li></a>
				<a href="../download.do"><li>资料</li></a>

				<li class="top_login"><c:choose>
						<c:when test="${sessionScope.user==null}">
							<a href="loginpage.do">登录</a>
						</c:when>
						<c:when test="${sessionScope.user!=null}">
							<a href="logout.do">注销</a>
						</c:when>
					</c:choose></li>
			</ul>
		</div>
	</div>
	<div class="userInfo">
		<div class="user_left">
			
			<c:choose>
						<c:when test="${isApply==true}">
							<img src="${app.inchPhoto }" class="user_img"><br> 
						</c:when>
						<c:when test="${isApply==false}">
							<img src="../img/no_head.jpeg" class="user_img"><br> 
						</c:when>
					</c:choose>
			
			 <span
				class="user_name">姓名</span>
			<div class="user_level">
				<c:choose>
					<c:when test="${us.type==0}">
							超级管理员
					</c:when>
					
					<c:when test="${us.type==1}">
							系统管理员
					</c:when>
					
					<c:when test="${us.type==2}">
							管理员
					</c:when>
					
					<c:when test="${us.type==3}">
							首席专家
					</c:when>
					
					<c:when test="${us.type==4}">
							普通专家
					</c:when>
					
					<c:when test="${us.type==5}">
							普通用户
					</c:when>
				</c:choose>
			</div>
			<ul type="none" class="user_nav">
				<a href="userInfo.do"><li class="active">个人中心</li></a>
				<a href="expert.do"><li>加入专家</li></a>
			</ul>
		</div>
		<div class="user_right">
			<div class="user_right_title">
				<ul class="user_right_tab" id="user_right_tab">
					<li><a href="userInfo.do">基本资料</a></li>
					<li><a href="javascript:checkIsApply();">详细资料</a></li>
					<li><a href="changeInfo.do">修改资料</a></li>
					<li class="active"><a href="changeImg.do">修改头像</a></li>
				</ul>
			</div>
			<div class="user_right_content">
				<div class="right_contetn_basis" id="right_content_table">
					<div class="changeImg">
						<img src="image/userImg.jpg"> <input type="file"
							name="upload" id="file_upload" accept=".jpg,.png,.jpeg,.gif" />
						<button>保存头像</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>

</body>
</html>
