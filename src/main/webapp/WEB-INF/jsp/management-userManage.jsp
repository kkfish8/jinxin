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

<script src="../plugin/bootstrap/bootstrap-table/FileSaver.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/tableExport.min.js"></script>
<script src="../plugin/bootstrap/bootstrap-table/bootstrap-table-export.js"></script>

<script src="../js/management.js"></script>

</head>

<body>

	<jsp:include page="/WEB-INF/jsp/include-navbar.jsp">
		<jsp:param value="userManage" name="content"/>
	</jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 hidden-xs sidebar">
				<ul class="nav nav-sidebar">
					<jsp:include page="/WEB-INF/jsp/include-mainMenu.jsp">
						<jsp:param value="userManage" name="content"/>
					</jsp:include>
				</ul>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
				
				
				
				<h3 class="sub-header">用户管理</h3>
				
				<div id="table-toolbar">
					
					<c:if test="${loginedUser.type <= 1 }">
						<button type="button" class="btn btn-default" id="add-user" data-toggle="modal" data-target="#myModal">
							<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
							增加用户
						</button>
						<button type="button" class="btn btn-default only-more" id="delete-user" disabled="disabled">
							<span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>
							删除用户
						</button>
						<button type="button" class="btn btn-default only-more" id="edit-user" disabled="disabled" data-toggle="modal" data-target="#myModal2">
							<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
							编辑用户
						</button>
					</c:if>
			
				
				</div>
				<table id="main-table" data-toggle="table" data-url="management-userInfo.do"
				data-click-to-select="true" data-toolbar="#table-toolbar" data-smart-display="true"
				data-pagination="true" data-page-list="" data-page-size="50" data-cache="false"
				data-maintain-selected="true" data-search="true" data-show-columns="true"
				
	           	data-show-refresh="true"
	           	data-show-toggle="true"
	        	data-show-export="true"         
           
				><!-- data-export-data-type="basic" -->
				    <thead>
				    <tr>
				    	<th data-field="check" data-checkbox="true"></th>
				        <th data-field="id">ID</th>
				        <th data-field="username">用户名</th>
				        <th data-field="truename">真实姓名</th>
				        <th data-field="email">邮箱</th>
				        <th data-field="type">用户类型</th>
				        <th data-field="blacklist">黑名单</th>
				        <th data-field="sex">性别</th>
				        <th data-field="tel">电话</th>
				        <th data-field="field">领域</th>
				        <th data-field="participate">参与次数</th>
				        <th data-field="absent">缺席次数</th>
				        <th data-field="contract">签约时间</th>
				        <th data-field="lastlogin">最后登录时间</th>
				        

				    </tr>
				    </thead>
				   
				</table>



			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<form class="modal-content" id = "addUser" action="management-addUser.do" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">增加用户</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="username">用户名</label>
						<input type="text" class="form-control" id="username" datatype="*6-15" name="username" placeholder="用户名">
					</div>
						
					<div class="form-group">
						<label for="password">密码</label>
						<input type="password" class="form-control" datatype="*6-15" name="password" id="password">
					</div>
					<div class="form-group">
						<label for="repass">再次输入</label>
						<input type="password" class="form-control" datatype="*" recheck="password" id="repass">
					</div>
					<div class="form-group">
						<label for="truename">真实姓名</label>
						<input type="text" class="form-control" id="truename" datatype="*" name="truename" placeholder="真实姓名">
					</div>
					<div class="form-group">
						<label >性别：</label>
						<input type="radio" name="sex" value="男" id="man" checked="checked"/><label for="man">男</label> 
						<input type="radio" name="sex" value="女" id="women"/><label for="women">女</label> 
					</div>
					<div class="form-group">
						<label for="email">邮箱</label>
						<input type="text" class="form-control" id="email" datatype="e" name="email" placeholder="邮箱">
					</div>
					<div class="form-group">
						<label for="tel">手机号码</label>(可以不填写)
						<input type="text" class="form-control" id="tel"  name="tel" placeholder="手机号码">
					</div>
					<div class="form-group">
						<label for="usertype">用户类型</label>
						<select name="usertype" id="usertype" class="form-control select select-primary select-block mbl" style="color:#999;">
						
						    <option value="5">普通用户</option>
						    <option value="4">普通专家</option>
						    <option value="3">首席专家</option>
						    <c:if test="${loginedUser.type < 2 }">
						    	<option value="2">管理员</option>
						    </c:if>
						    <c:if test="${loginedUser.type == 0 }">
						    	<option value="1">系统管理员</option>
						    </c:if>
						</select>
					</div>
					<div class="form-group">
						<label for="contract">签约时间</label>
						<input type="date" class="form-control" id="contract"  name="contract" placeholder="签约时间">
					</div>
					<div class="form-group">
						<label for="field">领域</label>
						<select name="field" id="field" class="form-control select select-primary select-block mbl" style="color:#999;">
						    <c:forEach var="data"   items="${field}" >
								<option value="${data.name}">${data.name}</option>
                 			</c:forEach>
						</select>
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
			<form class="modal-content" id="editUser"  action="management-editUser.do" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">编辑用户</h4>
				</div>
				<div class="modal-body">
					<input type="hidden" id="edit-id" name="IDArray" />
					<div class="form-group">
						<label for="editusername">用户名：</label>
						<span id="editusername" name="editusername"></span>
					</div>
						
					<div class="form-group">
						<label for="editpass">密码</label>（不更改时，不填写！）
						<input type="password" class="form-control" id="editpass" name="editpass">
					</div>
					<div class="form-group">
						<label for="editrepass">确认输入</label>
						<input type="password" class="form-control" id="editrepass"  recheck="editpass" name="editrepass">
					</div>
					<div class="form-group">
						<label for="edittruename">真实姓名</label>
						<input type="text" class="form-control" id="edittruename" datatype="*" name="edittruename" placeholder="真实姓名">
					</div>
					<div class="form-group">
						<label for="editsex">性别</label>
						<select name="editsex" id="editsex" class="form-control select select-primary select-block mbl" style="color:#999;">
						    <option value="男">男</option>
						    <option value="女">女</option>
						</select>
					</div>
					<div class="form-group">
						<label for="editblack">拉黑</label>
						<select name="editblack" id="editblack" class="form-control select select-primary select-block mbl" style="color:#999;">
						    <option value="否">否</option>
						    <option value="是">是</option>
						</select>
					</div>
					<div class="form-group">
						<label for="editeamil">邮箱</label>
						<input type="text" class="form-control" id="editeamil" name="editeamil" datatype="e" placeholder="邮箱">
					</div>
					<div class="form-group">
						<label for="edittel">手机号码</label>(可以不填写)
						<input type="text" class="form-control" id="edittel"  name="edittel" placeholder="手机号码">
					</div>
					<div class="form-group">
						<label for="edittype">用户类型</label>
						<select name="edittype" id="edittype" class="form-control select select-primary select-block mbl" style="color:#999;">
						    <option value="普通用户">普通用户</option>
						    <option value="普通专家">普通专家</option>
						    <option value="首席专家">首席专家</option>
						    <c:if test="${loginedUser.type < 2 }">
						    	<option value="管理员">管理员</option>
						    </c:if>
						    <c:if test="${loginedUser.type == 0 }">
						    	<option value="系统管理员">系统管理员</option>
						    </c:if>
						</select>
					</div>
					<div class="form-group">
						<label for="editcontract">签约时间</label>
						<input type="date" class="form-control" id="editcontract"  name="editcontract" placeholder="签约时间">
					</div>
					<div class="form-group">
						<label for="editfield">领域</label>
						<select name="editfield" id="editfield" class="form-control select select-primary select-block mbl" style="color:#999;">
						    <c:forEach var="data"   items="${field}" >
								<option value="${data.name}">${data.name}</option>
                 			</c:forEach>
						</select>
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

	//$('#main-table').tableExport({type:'excel'});
	
	$("#delete-user").click(function() {
		
		var rows = $("#main-table").bootstrapTable("getSelections");

		var IDArray = [];
		for (var i in rows) {
			IDArray.push(rows[i].id);
		}
		
		var sure = confirm("确定删除这 " + IDArray.length + " 项吗？");
		if(!sure) {
			return;
		}
		
		
		var URL = "deleteUser.do";
		$.post(URL, 
			{IDArray:"[" + IDArray.join() + "]"}, 
			function(data,status){
				if(data != "ID"){
					if(data == "OK") {
						alert("删除成功！");
						$("#main-table").bootstrapTable("remove", {field:"id", values:IDArray});
						$(".only-one").attr("disabled", "disabled");
						$(".only-more").attr("disabled", "disabled");
					}else{
						alert("删除失败！");
					}
				}else{
					alert("不可删除ID为1的用户！");
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

		$("#myModal2 [name='editusername']").html(equals("username"));
		$("#myModal2 [name='edittruename']").val(equals("truename"));
		$("#myModal2 [name='editsex']").val(equals("sex"));
		$("#myModal2 [name='editeamil']").val(equals("email"));
		$("#myModal2 [name='editblack']").val(equals("blacklist"));
		$("#myModal2 [name='edittel']").val(equals("tel"));
		$("#myModal2 [name='editcontract']").val(equals("contract"));
		$("#myModal2 [name='edittype']").val(equals("type"));
		$("#myModal2 [name='editfield']").val(equals("field"));
		
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
	
	
	$("#remove-group-device").click(function() {
		var rows = $("#modal-table1").bootstrapTable("getSelections");

		var IDArray = [];
		for (var i in rows) {
			IDArray.push(rows[i].id);
		}
		
		var URL = "removeGroupDevice.do";
		$.post(URL, 
			{id:IDArray.join()}, 
			function(data,status){
				if(data == "OK") {
					$("#modal-table1").bootstrapTable("remove", {field:"id", values:IDArray});
					$(".modal-more").attr("disabled", "disabled");
				}
			}
		);
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
