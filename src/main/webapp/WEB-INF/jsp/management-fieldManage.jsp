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

<title>用户管理</title>

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
		<jsp:param value="fieldManage" name="content"/>
	</jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 hidden-xs sidebar">
				<ul class="nav nav-sidebar">
					<jsp:include page="/WEB-INF/jsp/include-mainMenu.jsp">
						<jsp:param value="fieldManage" name="content"/>
					</jsp:include>
				</ul>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
				
				<h3 class="sub-header">领域管理</h3>
				
				<div id="table-toolbar">
					
					<c:if test="${loginedUser.type <= 1 }">
						<button type="button" class="btn btn-default" id="add-user" data-toggle="modal" data-target="#myModal">
							<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
							增加领域
						</button>
						<button type="button" class="btn btn-default only-one" id="edit-user" disabled="disabled" data-toggle="modal" data-target="#myModal2">
							<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
							编辑领域
						</button>
						<button type="button" class="btn btn-default only-more" id="delete-field" disabled="disabled">
							<span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>
							删除领域
						</button>
					</c:if>

				</div>
				<table id="main-table" data-toggle="table" data-url="management-fielInfo.do"
				data-click-to-select="true" data-toolbar="#table-toolbar" data-smart-display=true
				data-pagination="true" data-page-list="" data-page-size="50" data-cache="false"
				<%-- data-smart-display="true" data-card-view="true"  --%>
				data-maintain-selected="true" data-search="true" data-show-columns="true"
				
				data-show-refresh="true"
	           	data-show-toggle="true"
	           	data-show-export="true"  
          		>
				    <thead>
				    <tr>
				    	<th data-field="check" data-checkbox="true"></th>
				        <th data-field="id">ID</th>
				        <th data-field="name">领域</th>			        
				        <th data-field="note">备注</th>			        

				    </tr>
				    </thead>
				   
				</table>



			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<form class="modal-content" id = "addUser" action="management-addField.do" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">增加领域</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="name">领域</label>
						<input type="text" class="form-control" id="name" datatype="*" name="name" placeholder="领域">
					</div>
					<div class="form-group">
						<label for="note">备注</label>
						<input type="text" class="form-control" id="note" name="note" placeholder="领域">
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="提交" class="btn btn-primary" id="myModal1-submit"/>
				</div>
			</form>
		</div>
	</div>
	<!-- 修改 -->
	<div class="modal fade" id="myModal2" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<form class="modal-content" id="editUser"  action="management-editField.do" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">编辑领域</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="edit-id" name="IDArray" />
					<div class="form-group">
						<label for="editid">领域ID：</label>
						<span id="editid" name="editid"></span>
					</div>					
					<div class="form-group">
						<label for="editname">领域：</label>
						<input type="text" class="form-control" id="editname" name="editname"/>
					</div>		
					<div class="form-group">
						<label for="editnote">备注</label>
						<input type="text" class="form-control" id="editnote" name="editnote" placeholder="领域">
					</div>			
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary" >提交</button>
				</div>
			</form>
		</div>
	</div>

	

</body>
<script>
$(document).ready(function() {

	$("#delete-field").click(function() {
		
		var rows = $("#main-table").bootstrapTable("getSelections");

		var IDArray = [];
		for (var i in rows) {
			IDArray.push(rows[i].id);
		}
		
		var sure = confirm("确定删除这 " + IDArray.length + " 项吗？");
		if(!sure) {
			return;
		}
		
		
		var URL = "deleteField.do";
		$.post(URL, 
			{IDArray:"[" + IDArray.join() + "]"}, 
			function(data,status){
				if(data == "OK") {
					alert("删除成功！");
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
	
	
	$("#edit-user").click(function() {
		
		var rows = $("#main-table").bootstrapTable("getSelections");
	
		
		//将选中行的ID添加到表单
		var IDArray = [];
		for (var i in rows) {
			IDArray.push(rows[i].id);
		}
		
		$("#edit-id").val("[" + IDArray.join() + "]");

		$("#myModal2 [name='editid']").html(equals("id"));
		$("#myModal2 [name='editname']").val(equals("name"));

		
		//比较选择的字段的值是否相等
		function equals(field) {
			var temp = "";
			try {
				temp = rows[0][field];
				for (var i = 1; i < rows.length; i++) {
					if(temp != rows[i][field]) {
						temp = "";
						break;
					}
				}
			} catch (e) {
				temp = "";
			}
			return temp;
		}

		
	});
	
			
	$("#add-strategy").click(function() {
			
		var $item = $(strategyHtml);
			
		$item.appendTo("#strategy-list");
		$item.find(".remove-strategy").click(function() {
			$item.remove();
		});
	});
	
	$("form").Validform();

});

</script>
</html>
