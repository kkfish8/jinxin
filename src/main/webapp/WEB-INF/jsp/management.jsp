<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="pragma" content="no-cache"> 
<meta http-equiv="cache-control" content="no-cache"> 
<meta http-equiv="expires" content="0">   

<title>Dashboard Template for Bootstrap</title>

<link href="../plugin/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../plugin/validform/validform.css" rel="stylesheet">
<link href="../css/management.css" rel="stylesheet">

<script src="../plugin/respond.min.js"></script>
<script src="../plugin/jquery-1.11.3.min.js"></script>
<script src="../plugin/validform/Validform_v5.3.2_min.js"></script>
<script src="../plugin/bootstrap/js/bootstrap.min.js"></script>
<script src="../js/management.js"></script>

</head>

<body>

	<jsp:include page="/WEB-INF/jsp/include-navbar.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 hidden-xs sidebar">
				<ul class="nav nav-sidebar">
					<jsp:include page="/WEB-INF/jsp/include-mainMenu.jsp"></jsp:include>
				</ul>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
				<h2 class="sub-header text-center">欢迎使用本系统</h2>
			</div>
		</div>
	</div>


</body>
</html>
