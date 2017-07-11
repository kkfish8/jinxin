<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<title>个人中心</title>
<link rel="stylesheet" href="../css/top.css" type="text/css">
<link rel="stylesheet" href="../css/foot.css" type="text/css">
<link rel="stylesheet" href="../plugin/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="../plugin/bootstrap/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="../plugin/validform/validform.css">
<link rel="stylesheet" href="../css/expert.css" type="text/css">
</head>

<body style="table-radius: 0px;">
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
							<a href="../loginpage.do"><li class="top_login">登录</li></a>
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
				<a href="userInfo.do"><li>个人中心</li></a>
				<a href="expert.do"><li class="active">加入专家</li></a>
				<a href="logout.do"><li>退出登录</li></a>
			</ul>
		</div>
		<div class="user_right">
			<div class="r_top">
				<div class="r_top1" onclick="r(0)">1.基本信息</div>
				<div class="r_top2" onclick="r(1)">2.工作经历</div>
				<div class="r_top3" onclick="r(2)">3.研究成果</div>
			</div>
			<form class="demoform" action="SaveApply.do" method="post"
				enctype="multipart/form-data">
				<div class="main">

					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">真实姓名</span> <input
							type="text" name="name" class="form-control" datatype="z2-10"
							nullmsg="请输入姓名" errormsg="名字至少2个汉字，只能为汉字," placeholder="请输入姓名">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">性别</span> 
						<select name=sex id="sex" class="form-control select select-primary select-block mbl" style="color:#999;">
								<option value="男">男</option>
								<option value="女">女</option>
						</select>
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">出生日期</span> <input
							type="date" name="birthday" class="form-control" datatype="*"
							nullmsg="请输入出生日期" placeholder="格式:2015-01-01">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">证件号码</span> <input
							type="text" name="number" class="form-control" datatype="*"
							nullmsg="请输入证件号码" placeholder="请输入证件号码">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">政治面貌</span> <input
							type="text" name="status" class="form-control" datatype="*"
							nullmsg="请输入政治面貌" placeholder="请输入政治面貌">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">单位类型</span> <input
							type="text" name="unit" class="form-control" datatype="*"
							nullmsg="请输入单位类型" placeholder="请输入单位类型">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">工作单位</span> <input
							type="text" name="work " class="form-control" datatype="*"
							nullmsg="请输入工作单位" placeholder="请输入工作单位">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">所在部门</span> <input
							type="text" name="department" class="form-control" datatype="*"
							nullmsg="请输入所在部门" placeholder="请输入所在部门">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">工作地点</span> <input
							type="text" name="place" class="form-control" datatype="*"
							nullmsg="请输入工作地点" placeholder="请输入工作地点">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">工作职务</span> <input
							type="text" datatype="*" nullmsg="请输入职务" placeholder="请输入职务"
							name="duties" class="form-control">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">工作职称</span> <input
							type="text" name="Title" class="form-control" datatype="*"
							nullmsg="请输入职称" placeholder="请输入职称">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">通讯地址</span> <input
							type="text" name="address" class="form-control" datatype="*"
							nullmsg="请输入通讯地址" placeholder="请输入通讯地址">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">手机号码</span> <input
							type="text" name="phone" class="form-control" datatype="m"
							nullmsg="请输入手机号码" placeholder="请输入手机号码">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">固定电话</span> <input
							type="text" name="telephone" class="form-control" datatype="*"
							nullmsg="请输入固定电话" placeholder="请输入固定电话">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">电子邮箱</span> <input
							type="text" name="email" class="form-control" datatype="e"
							nullmsg="请输入邮箱" placeholder="请输入邮箱">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">最高学历</span> <input
							type="text" name="Education" class="form-control" datatype="*"
							nullmsg="请输入最高学历" placeholder="请输入最高学历">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">获得学位</span> <input
							type="text" name="degree" class="form-control" datatype="*"
							nullmsg="请输入学位" placeholder="请输入学位">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">学习专业</span> <input
							type="text" name="major" class="form-control" datatype="*"
							nullmsg="请输入专业" placeholder="请输入专业">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">毕业院校</span> <input
							type="text" name="school" class="form-control" datatype="*"
							nullmsg="请输入毕业院校" placeholder="请输入毕业院校">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">从事专业</span> <input
							type="text" name="Engaged" class="form-control" datatype="*"
							nullmsg="请输入从事专业" placeholder="请输入从事专业">
					</div>
					<div class="input-group">
						<div class="btn btn-primary" style="margin-left: 500px;"
							onclick="n(1)">下一步</div>
					</div>
				</div>

				<div class="main1">
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">简历</span> <input
							type="text" datatype="*" nullmsg="请输入简历" name="resume"
							class="form-control">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">科技领域</span> 
						<select name="field" id="field" class="form-control select select-primary select-block mbl" style="color:#999;">
						    <c:forEach var="data"   items="${field}" >
						    	<c:if test="${data.id > 0  }">
									<option value="${data.name}">${data.name}</option>
								</c:if>
                 			</c:forEach>
						</select>
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">省科研项目</span> <input
							type="text" name="Provincial " class="form-control"
							placeholder="承担省级或地市级以上主要科研项目情况">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">发表论文</span> <input
							type="text" name="paper" class="form-control"
							placeholder="发表论文情况">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">发表专著</span> <input
							type="text" name="monograph" class="form-control"
							placeholder="发表专著情况">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">科技奖励</span> <input
							type="text" name="technology" class="form-control"
							placeholder="获得省级或地级市以上科技奖励情况">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">知识产权</span> <input
							type="text" name="intellectual" class="form-control"
							placeholder="知识产权获取情况">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">项目研发</span> <input
							type="text" name="project" class="form-control"
							placeholder="参与项目研发情况">
					</div>
					<div class="input-group">
						<div class="btn btn-primary" style="margin-left: 500px;"
							onclick="n(2)">下一步</div>
					</div>
				</div>

				<div class="main2">
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">寸 照</span> <input
							type="file" datatype="*" nullmsg="请选择寸照" name="licencePhoto"
							class="form-control">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">职称证书扫描件</span> <input
							type="file" name="Titleup" class="form-control"
							placeholder="知识产权获取情况">
					</div>
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">学历（学位）证书扫描件</span>
						<input type="file" name="degreeup" class="form-control"
							placeholder="知识产权获取情况">
					</div>
					<div class="input-group">
						<button class="btn btn-primary"
							style="margin-left: 40%; width: 20%;" id="next">立即加入</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<div class="foot">
		<span>Copyright&copy;2015 广元市经信委 版权所有</span> <span>技术支持：睿意科技</span>
	</div>

	<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
	<script src="../plugin/jquery-1.11.3.min.js"></script>
	<script src="../plugin/validform/Validform_v5.3.2_min.js"></script>

	<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
	<script src="../plugin/bootstrap/js/bootstrap.min.js"></script>
	<script src="../js/userinfo.js"></script>
</body>
</html>
