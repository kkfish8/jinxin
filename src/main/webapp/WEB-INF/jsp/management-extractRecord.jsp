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

<title>专家抽取</title>
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
<script src="../plugin/bootstrap/bootstrap-table/FileSaver.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/tableExport.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/bootstrap-table-export.js"></script>
<script src="../js/management.js"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/jsp/include-navbar.jsp">
		<jsp:param value="extractRecord" name="content"/>
	</jsp:include>
	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 hidden-xs sidebar">
				<ul class="nav nav-sidebar">
					<jsp:include page="/WEB-INF/jsp/include-mainMenu.jsp">
						<jsp:param value="extractRecord" name="content"/>
					</jsp:include>
				</ul>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
						<div id="table-toolbar">
					
					<button type="button" class="btn btn-default only-one" id="see-info" data-toggle="modal" data-target="#myModal">
						<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
						查看信息
					</button>
					<c:if test="${loginedUser.type <= 1 }">
						<button type="button" class="btn btn-default only-more" id="delete-record" disabled="disabled">
							<span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span>
							删除记录
						</button>
						<button type="button" class="btn btn-default" id="extract-expert" data-toggle="modal" data-target="#myModal2">
							<span class="glyphicon glyphicon-log-in" aria-hidden="true"></span>
							抽取专家
						</button>
					</c:if>

					<!-- <button type="button" class="btn btn-default" id="extract-expert">
						<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
						抽取专家
					</button> -->
					
					<%-- <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal2">
					筛选过滤
					</button> --%>
				
				</div>
				
				
				<h3 class="sub-header">专家抽取</h3>
				<table id="main-table" data-toggle="table" data-url="getExtractRecord.do"
				data-click-to-select="true" data-toolbar="#table-toolbar" data-smart-display=true
				data-pagination="true" data-page-list="" data-page-size="50"
				<%-- data-smart-display="true" data-card-view="true"  --%>
				data-maintain-selected="true" data-search="true" data-show-columns="true" data-cache="false"
					data-show-refresh="true"
			        data-show-toggle="true"
			        data-show-export="true">
				    <thead>
				    <tr>
				    	<th data-field="check" data-checkbox="true"></th>
				        <th data-field="id">ID</th>
				        <th data-field="extractRemarks">项目</th>
				        <th data-field="extractPeople">抽取人</th>
				        <th data-field="extractDate">时间</th>
				        <th data-field="extractField">抽取领域</th>
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
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">抽取结果</h4>
				</div>
				<div class="modal-body">
					<table id="extract-table" 
					data-toggle="table" 
					data-smart-display=true
					data-pagination="true" 
					data-page-list="" 
					data-page-size="50"
					data-maintain-selected="true" 
					data-search="true"  
					data-cache="false"
				    data-show-export="true">
					    <thead>
						    <tr>
						        <th data-field="id">ID</th>
						        <th data-field="userName">用户名</th>
						        <th data-field="name">姓名</th>
						        <th data-field="field">领域</th>
						        <th data-field="date">电话</th>
						    </tr>
					    </thead>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="审核通过" class="btn btn-primary" id="myModal1-submit"/>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal 2 -->
	<div class="modal fade" id="myModal2" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">抽取专家</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="field">抽取领域</label>
						<select name="field" id="field" class="form-control select select-primary select-block mbl" style="color:#999;">
						    <c:forEach var="data"  items="${field}" >
								<option value="${data.id}">${data.name}</option>
                 			</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<div class="input-group">
  							<span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-user"></span></span>
						  	<input type="text" id="extract-num" class="form-control" placeholder="抽取人数" aria-describedby="basic-addon1">
						</div>
					</div>
					<textarea id="extract-mark" class="form-control" rows="3" placeholder="请输入项目名"></textarea>
					
					
					<table id="extract_now"
					data-toggle="table" 
					data-smart-display=true
					data-pagination="true" 
					data-page-list="" 
					data-page-size="50"
					data-maintain-selected="true" 
					data-search="true"  
					data-cache="false"
				    data-show-export="true">
						<thead>
							<tr>
								<th data-field="id">ID</th>
								<th data-field="userName">用户名</th>
								<th data-field="name">姓名</th>
								<th data-field="field">领域</th>
								<th data-field="date">电话号码</th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="开始抽取" class="btn btn-primary" id="myModal2-submit"/>
				</div>
			</div>
		</div>
	</div>

</body>
<script>
$(document).ready(function() {

	$("#delete-record").click(function() {
		
		var rows = $("#main-table").bootstrapTable("getSelections");

		var IDArray = [];
		for (var i in rows) {
			IDArray.push(rows[i].id);
		}
		
		var sure = confirm("确定删除这 " + IDArray.length + " 项吗？");
		if(!sure) {
			return;
		}
		
		var URL = "deleteRecord.do";
		$.post(URL, 
			{IDArray:"[" + IDArray.join() + "]"}, 
			function(data,status){
				if(data == "OK") {
					alert("删除成功！");
					$.ajax({
						type:"get",
						dataType:"json",
						url:"/jingxin/admin/getExtractRecord.do",
						success:function(data){
							//$("#main-table").bootstrapTable("load",data);
						}
					});
					$("#main-table").bootstrapTable("remove", {field:"id", values:IDArray});
					$(".only-one").attr("disabled", "disabled");
					$(".only-more").attr("disabled", "disabled");
				}else{
					alert("删除失败！");
				}
			}
		);
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
	
	$("#myModal1-submit").click(function(){
		$.ajax({
			type:"get",
			url:"/jingxin/admin/pass.do?id="+$("#id").text(),
			success:function(data){
				//alert(data);
			}
		});
	});
	//开启模态框1时
	$("#myModal").on("show.bs.modal",function(){
		var rows = $("#main-table").bootstrapTable("getSelections");
		$.ajax({
			type:"get",
			dataType:"json",
			url:"/jingxin/admin/ExtractInfo.do?id="+rows[0].id,
			success:function(data){
				$("#extract-table").bootstrapTable("load", data);
			}
		});
		$("#extract-table").bootstrapTable("removeAll");
	});
	
	//点击抽取专家
	$("#myModal2-submit").click(function(){
		$.ajax({
			type:"post",
			dataType:"json",
			data: {
				field: $("#field").val(),
				num: $("#extract-num").val(),
				mark:$("#extract-mark").val()
			},
			url:"/jingxin/admin/startExtract.do",
			success:function(data){
				$("#extract_now").bootstrapTable("load", data);
			}
		});
	});
	//关闭模态框2的时候
	$("#myModal2").on("hidden.bs.modal",function(){
		$("#extract_now").bootstrapTable("removeAll");
		$.ajax({
			type:"get",
			dataType:"json",
			url:"/jingxin/admin/getExtractRecord.do",
			success:function(data){
				$("#main-table").bootstrapTable("load",data);
			}
		});
	});
	/* $.ajax({
		type:"get",
		dataType:"json",
		url:"/jingxin/admin/getExtractRecord.do",
		success:function(data){
			//alert(data);
		}
	}); */
	
});
</script>
</html>