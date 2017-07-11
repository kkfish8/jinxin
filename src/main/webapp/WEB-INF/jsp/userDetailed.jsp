<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>详细资料</title>
<link rel="stylesheet" href="../css/top.css" type="text/css">
<link rel="stylesheet" href="../css/userInfo.css" type="text/css">
<link rel="stylesheet" href="../css/foot.css" type="text/css">
<script>
var isApply = ${isApply};
function AddApply(){
	if(isApply){
		alert("您已经是专家，无需申请");
	}else{
		document.location.href = "expert.do";
	}
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
				<a href="../news.do"><li>新闻动态</li></a>
				<a href="../gonggao.do"><li>通知公告</li></a>
				<a href="../download.do"><li>资料下载</li></a>
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
	<div class="userInfo">
		<div class="user_left">
			<c:choose>
						<c:when test="${isApply==true}">
							<img src="../${app.inchPhoto }" class="user_img"><br> 
						</c:when>
						<c:when test="${isApply==false}">
							<img src="../img/no_head.jpeg" class="user_img"><br> 
						</c:when>
					</c:choose>
			
			<span class="user_name">${us.name }</span>
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
				<a href="javascript:AddApply();"><li>加入专家</li></a>
				<a href="logout.do"><li>退出登录</li></a>
			</ul>
		</div>
		<div class="user_right">
			<div class="user_right_title">
				<ul class="user_right_tab" id="user_right_tab">
					<li><a href="userInfo.do">基本资料</a></li>
					<li class="active"><a href="javascript:checkIsApply();">详细资料</a></li>
					<li><a href="changeInfo.do">修改资料</a></li>
				</ul>
			</div>
			<div class="user_right_content">
				<div class="right_contetn_basis" id="right_content_table">

					<div class="right_contetn_title">
						<span>学术信息</span>
					</div>
					<!-- 详细信息 -->
					<table>
						<tr>
							<td class="right_table_name">熟悉的技术领域：</td>
						</tr>
						<tr>
							<td colspan="2" class="right_table_detailed"><span>${app.familiarField }</span></td>
						</tr>
						
						<tr>
							<td class="right_table_name">现在的研究领域：</td>
						</tr>
						<tr>
							<td colspan="2" class="right_table_detailed"><span>${app.projectDevelopment }</span></td>
						</tr>

						<tr>
							<td class="right_table_name">科研项目研究情况：</td>
						</tr>
						<tr>
							<td colspan="2" class="right_table_detailed"><span>${app.researchProject }</span></td>
						</tr>

						<tr>
							<td class="right_table_name">论文发表情况：</td>
						</tr>
						<tr>
							<td colspan="2" class="right_table_detailed"><span>${app.publishedPapers }</span></td>
						</tr>

						<tr>
							<td class="right_table_name">专著发表情况：</td>
						</tr>
						<tr>
							<td colspan="2" class="right_table_detailed"><span>${app.publishedMonograph }</span></td>
						</tr>
						
						<tr>
							<td class="right_table_name">获得省市科学奖励情况：</td>
						</tr>
						<tr>
							<td colspan="2" class="right_table_detailed"><span>${app.scienceTechnology }</span></td>
						</tr>
						
						<tr>
							<td class="right_table_name">获得知识产权情况：</td>
						</tr>
						<tr>
							<td colspan="2" class="right_table_detailed"><span>${app.onlyProperty }</span></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>
</body>
</html>

