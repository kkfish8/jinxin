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

<title>首页管理</title>

<link href="../plugin/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../plugin/bootstrap/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
<link href="../plugin/validform/validform.css" rel="stylesheet">
<link href="../css/management.css" rel="stylesheet">

<script src="../plugin/respond.min.js"></script>
<script src="../plugin/jquery-1.11.3.min.js"></script>
<script src="../plugin/validform/Validform_v5.3.2_min.js"></script>
<script src="../plugin/bootstrap/js/bootstrap.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/bootstrap-table.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
<script src="../js/management.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/FileSaver.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/tableExport.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/bootstrap-table-export.js"></script>

</head>

<body>

	<jsp:include page="/WEB-INF/jsp/include-navbar.jsp">
		<jsp:param value="indexmanage" name="content"/>
	</jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 hidden-xs sidebar">
				<ul class="nav nav-sidebar">
					<jsp:include page="/WEB-INF/jsp/include-mainMenu.jsp">
						<jsp:param value="indexmanage" name="content"/>
					</jsp:include>
				</ul>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
						<div id="table-toolbar">
					<c:if test="${loginedUser.type <= 1 }">	
						<button type="button" class="btn btn-default"  id="add-user" data-toggle="modal" data-target="#myModal">
							<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
							标题修改
						</button>
						
						<button type="button" class="btn btn-default only-one"  id="change-image" data-toggle="modal" data-target="#myModal2">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
							轮播修改
						</button>
					</c:if>
					
					<%-- <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal2">
					筛选过滤
					</button> --%>
				
				</div>
				
				
				<h3 class="sub-header">首页管理</h3>
				<table id="main-table" data-toggle="table" data-url="setindex.do"
				data-click-to-select="true" data-toolbar="#table-toolbar" data-smart-display=true
				data-pagination="true" data-page-list="" data-page-size="50"
				<%-- data-smart-display="true" data-card-view="true"  --%>
				data-maintain-selected="true" data-search="true" data-show-columns="true"
				 data-show-refresh="true"
           data-show-toggle="true"
           data-show-export="true"
           data-cache="false">
				    <thead>
				    <tr>
				    	<th data-field="check" data-checkbox="true"></th>
				        <th data-field="name">name</th>
				        <th data-field="value">value</th>
				    </tr>
				    </thead>
				</table>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			<form>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">首页管理</h4>
				</div>
				<div class="modal-body">
					<label for="name" style="margin-right:20px">标题:</label><input id="value" style="width:60%"></input>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="修改" class="btn btn-primary" id="myModal1-submit"/>
				</div>
				</form>
			</div>
		</div>
	</div>
	
	<!-- Modal2 -->
	<div class="modal fade" id="myModal2" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
			<form action="Update_Index.do" method="post"  enctype="multipart/form-data">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">轮播管理</h4>
				</div>
				<div class="modal-body">
					<label for="name" id="lunbo"></label>
					<input type="file" id="value" name="fileupload" />
					<input type="hidden" id="hidden_key" name="key" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="上传" class="btn btn-primary" id="myModal2-submit"/>
				</div>
				</form>
			</div>
		</div>
	</div>
	
	

</body>
<script>
$(document).ready(function() {
	//点击修改轮播按钮时候
	$("#change-image").click(function(){
		var rows = $("#main-table").bootstrapTable("getSelections");
		if(rows[0].name=="lunbo1"){
			$("#lunbo").text("轮播一");
		}else if(rows[0].name == "lunbo2"){
			$("#lunbo").text("轮播二");
		}else if(rows[0].name == "lunbo3"){
			$("#lunbo").text("轮播三");
		}
		$('#hidden_key').val(rows[0].name);
	});
	
	//按钮的启用和禁用
	$("#main-table").on('load-success.bs.table check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function() {
		
		var rows = $(this).bootstrapTable("getSelections");
		if(rows.length == 1) {
			$(".only-one").removeAttr("disabled");
			$(".only-more").removeAttr("disabled");
		} else if(rows.length > 1){
			$(".only-more").removeAttr("disabled");
			$(".only-one").attr("disabled", "disabled");
		} else {
			$(".only-one").attr("disabled", "disabled");
			$(".only-more").attr("disabled", "disabled");
		}
	});
	
	
	$("#modal-table1").on('load-success.bs.table check.bs.table uncheck.bs.table check-all.bs.table uncheck-all.bs.table', function() {
		
		var rows = $(this).bootstrapTable("getSelections");
		if(rows.length == 1) {
			$(".modal-more").removeAttr("disabled");
		} else if(rows.length > 1){
			$(".modal-more").removeAttr("disabled");
		} else {
			$(".modal-more").attr("disabled", "disabled");
		}
	});
	
	$("#myModal").on("hidden.bs.modal", function() {
		$("#device-table").hide();
	});
	
	
	$("#add-user").click(function() {
		$.ajax({
			type:"post",
			url:"/jingxin/admin/title.do",
			success:function(data){
				$("#value").val(data);
			}
		});
	});
	
	$("#myModal1-submit").click(function(){
		$.ajax({
			type:"post",
			url:"/jingxin/admin/set.do",
			data:"value="+$("#value").val(),
			success:function(data){
				alert(data);
				$('#myModal').modal('hide');
			}
		});
	});
	//上传轮播点击事件
	$("#myModal2-submit").click(function(){
		
	});
});

</script>
</html>
