<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>个人中心</title>
<link rel="stylesheet" href="../css/top.css" type="text/css">
<link rel="stylesheet" href="../css/userInfo.css" type="text/css">
<link rel="stylesheet" href="../css/foot.css" type="text/css">
<script>
	var isApply = ${isApply};
	function checkIsApply() {
		if (isApply) {
			document.location.href = "userDetailed.do";
		} else {
			alert("请提交申请后查看");
		}
	}
	
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
					<li class="active"><a href="userInfo.do">基本资料</a></li>
					<li><a href="javascript:checkIsApply();">详细资料</a></li>
					<li><a href="changeInfo.do">修改资料</a></li>
					
				</ul>
			</div>
			<div class="user_right_content">
				<div class="right_contetn_basis" id="right_content_table">
					<div class="right_contetn_title">
									<span>基本信息</span>
								</div>
					<table style="display: block;">
						
						<tr>
							<td class="right_table_name"><span>用户名：</span></td>
							<td><span>${us.username }</span></td>
						</tr>
						<tr>
							<td class="right_table_name">姓名：</td>
							<td><span>${us.name }</span></td>
						</tr>
						<tr>
							<td class="right_table_name">性别：</td>
							<td><span>${us.sex }</span></td>
						</tr>
						<tr>
							<td class="right_table_name">电话：</td>
							<td><span>${us.number }</span></td>
						</tr>
						<tr>
							<td class="right_table_name">E-mail：</td>
							<td><span>${us.mail}</span></td>
						</tr>

						<c:if test="${isApply==true }">

							<tr>
								<td class="right_table_name">出生年月：</td>
								<td><span>${app.brithday }</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">身份证号：</td>
								<td><span>${app.idCard}</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">国家：</td>
								<td><span>中国</span></td>
							</tr>
							
							<tr>
							
								<td class="right_table_name">政治面貌：</td>
								<td><span>${app.politicalStatus}</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">文凭：</td>
								<td><span>${app.education }</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">学位：</td>
								<td><span>${app.academicDegree}</span></td>
							</tr>
							
							<tr>
								<td colspan="2">
									<div class="right_contetn_title">
										<span>工作经历</span>
									</div>
								</td>
							</tr>
							
							<tr>
								<td class="right_table_name">工作类型：</td>
								<td><span>${app.workType }</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">工作名：</td>
								<td><span>${app.workName }</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">工作部门：</td>
								<td><span>${app.department }</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">工作地点：</td>
								<td><span>${app.workAddress }</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">工作职务：</td>
								<td><span>${app.workDuties }</span></td>
							</tr>
							
							<tr>
								<td class="right_table_name">工作职称：</td>
								<td><span>${app.workTitle }</span></td>
							</tr>

							<tr>
								<td class="right_table_name">通讯地址：</td>
								<td><span>${app.mailingAddress }</span></td>
							</tr>

							<tr>
								<td class="right_table_name">专业：</td>
								<td><span>${app.major}</span></td>
							</tr>
							<tr>
								<td class="right_table_name">毕业院校：</td>
								<td><span>${app.graduateSchool }</span></td>
							</tr>
							<tr>
								<td class="right_table_name">现从事的专业：</td>
								<td><span>${app.nowMajor }</span></td>
							</tr>
						</c:if>
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

