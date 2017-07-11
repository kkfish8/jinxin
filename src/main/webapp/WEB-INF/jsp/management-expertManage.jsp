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

<title>专家审核</title>

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
		<jsp:param value="expertManage" name="content"/>
	</jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 hidden-xs sidebar">
				<ul class="nav nav-sidebar">
					<jsp:include page="/WEB-INF/jsp/include-mainMenu.jsp">
						<jsp:param value="expertManage" name="content"/>
					</jsp:include>
				</ul>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
						<div id="table-toolbar">
					
					<button type="button" class="btn btn-default only-one"  id="add-user" data-toggle="modal" data-target="#myModal">
						<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
						查看信息
					</button>
					<c:if test="${loginedUser.type <= 1 }">
						<button type="button" class="btn btn-default only-more" id="delete-user" disabled="disabled">
							<span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>
							删除用户
						</button>
					</c:if>
					
					<%-- <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal2">
					筛选过滤
					</button> --%>
				
				</div>
				
				
				<h3 class="sub-header">专家审核</h3>
				<table id="main-table" data-toggle="table" data-url="expertManage.do"
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
				        <th data-field="id">ID</th>
				        <th data-field="user">用户名</th>
				        <th data-field="name">真实姓名</th>
				        <th data-field="mail">邮箱</th>
				        <th data-field="blacklist">黑名单</th>
				        <th data-field="sex">性别</th>
				        <th data-field="phonenumber">电话</th>
				        <th data-field="field">领域</th>
				        <th data-field="ispass">是否通过</th>
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
					<h4 class="modal-title" id="myModalLabel">审核专家</h4>
				</div>
				<div class="modal-body">
					<label for="id" style="width:18%;">ID:</label><label id="id" style="width:82%;"></label>
					<label for="user" style="width:18%;">用户名:</label><label id="user" style="width:82%;"></label>
					<label for="name" style="width:18%;">真实姓名:</label><label id="name" style="width:82%;"></label>
					<label for="sex" style="width:18%;">性别:</label><label id="sex" style="width:82%;"></label>
					<label for="mail" style="width:18%;">邮箱:</label><label id="mail" style="width:82%;"></label>
					<label for="phonenumber" style="width:18%;">电话:</label><label id="phonenumber" style="width:82%;"></label>
					<label for="field" style="width:18%;">专业领域:</label><label id="field" style="width:82%;"></label>
					<label for="brithday" style="width:18%;">生日:</label><label id="brithday" style="width:82%;"></label>
					<label for="idcard" style="width:18%;">身份证:</label><label id="idcard" style="width:82%;"></label>
					<label for="politicalstatus" style="width:18%;">政治面貌:</label><label id="politicalstatus" style="width:82%;"></label>
					<label for="worktype" style="width:18%;">工作类型:</label><label id="worktype" style="width:82%;"></label>
					<label for="workname" style="width:18%;">工作名字:</label><label id="workname" style="width:85%;"></label>
					<label for="department" style="width:18%;">部门:</label><label id="department" style="width:82%;"></label>
					<label for="workaddress" style="width:18%;">工作地址:</label><label id="workaddress" style="width:82%;"></label>
					<label for="workduties" style="width:18%;">工作职位:</label><label id="workduties" style="width:85%;"></label>
					<label for="worktitle" style="width:18%;">职称:</label><label id="worktitle" style="width:82%;"></label>
					<label for="mailingaddress" style="width:18%;">邮寄地址:</label><label id="mailingaddress" style="width:85%;"></label>
					<label for="fixedTelephone" style="width:18%;">固定电话:</label><label id="fixedTelephone" style="width:82%;"></label>
					<label for="education" style="width:18%;">学历:</label><label id="education" style="width:82%;"></label>
					<label for="academicdegree" style="width:18%;">学位:</label><label id="academicdegree" style="width:82%;"></label>
					<label for="major" style="width:18%;">专业:</label><label id="major" style="width:82%;"></label>
					<label for="graduateSchool" style="width:18%;">毕业学校:</label><label id="graduateSchool" style="width:82%;"></label>
					<label for="nowmajor" style="width:18%;">从事专业:</label><label id="nowmajor" style="width:82%;"></label>
					<label for="jobresume" style="width:18%;">工作简历:</label><label id="jobresume" style="width:82%;"></label>
					<label for="familiarField" style="width:18%;">科技领域:</label><label id="familiarField" style="width:82%;"></label>
					<label for="researchproject" style="width:18%;">科研项目:</label><label id="researchproject" style="width:82%;"></label>
					<label for="publishedpapers" style="width:18%;">发表论文:</label><label id="publishedpapers" style="width:82%;"></label>
					<label for="publishedMonograph" style="width:18%;">出版专著:</label><label id="publishedMonograph" style="width:82%;"></label>
					<label for="sciencetechnology" style="width:18%;">获得科技奖励:</label><label id="sciencetechnology" style="width:82%;"></label>
					<label for="onlyproperty" style="width:18%;">知识产权:</label><label id="onlyproperty" style="width:82%;"></label>
					<label for="ispass" style="width:18%;">是否通过:</label><label id="ispass" style="width:82%;"></label>
					<label for="inchPhoto" style="width:18%;">寸照:</label><img id="inchPhoto" width="200" height="250"><br>
					<label for="professionalpath" style="width:18%;">职称证书扫描件:</label><img id="professionalpath" width="570" height="800"><br>
					<label for="educationPath" style="width:18%;">学历证书扫描件:</label><img id="educationPath" width="570" height="800">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="审核通过" class="btn btn-primary" id="myModal1-submit"/>
				</div>
			</div>
		</div>
	</div>
	
	

</body>
<script>
$(document).ready(function() {

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
		
		
		var URL = "deleteapply.do";
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
	
	
	$("#add-user").click(function() {
		
		var rows = $("#main-table").bootstrapTable("getSelections");
	
		
		//将选中行的ID添加到表单
		var IDArray = [];
		for (var i in rows) {
			IDArray.push(rows[i].id);
		}
		
		
		$("#id").val("[" + IDArray.join() + "]");
		$("#myModal #id").html(equals("id"));
		$("#myModal #user").html(equals("user"));
		$("#myModal #name").html(equals("name"));
		$("#myModal #sex").html(equals("sex"));
		$("#myModal #mail").html(equals("mail"));
		$("#myModal #phonenumber").html(equals("phonenumber"));
		$("#myModal #field").html(equals("field"));
		$("#myModal #brithday").html(equals("brithday"));
		$("#myModal #idcard").html(equals("idcard"));
		$("#myModal #politicalstatus").html(equals("politicalstatus"));
		$("#myModal #worktype").html(equals("worktype"));
		$("#myModal #workname").html(equals("workname"));
		$("#myModal #department").html(equals("department"));
		$("#myModal #workaddress").html(equals("workaddress"));
		$("#myModal #worktype").html(equals("worktype"));
		$("#myModal #workduties").html(equals("workduties"));
		$("#myModal #worktitle").html(equals("worktitle"));
		$("#myModal #mailingaddress").html(equals("mailingaddress"));
		$("#myModal #fixedTelephone").html(equals("fixedTelephone"));
		$("#myModal #education").html(equals("education"));
		$("#myModal #academicdegree").html(equals("academicdegree"));
		$("#myModal #major").html(equals("major"));
		$("#myModal #nowmajor").html(equals("nowmajor"));
		$("#myModal #graduateSchool").html(equals("graduateSchool"));
		$("#myModal #jobresume").html(equals("jobresume"));
		$("#myModal #familiarField").html(equals("familiarField"));
		$("#myModal #researchproject").html(equals("researchproject"));
		$("#myModal #publishedpapers").html(equals("publishedpapers"));
		$("#myModal #publishedMonograph").html(equals("publishedMonograph"));
		$("#myModal #sciencetechnology").html(equals("sciencetechnology"));
		$("#myModal #onlyproperty").html(equals("onlyproperty"));
		$("#myModal #ispass").html(equals("ispass"));
		$("#myModal #inchPhoto").attr("src","../"+equals("inchPhoto"));
		$("#myModal #professionalpath").attr("src",".."+equals("professionalpath"));
		$("#myModal #educationPath").attr("src",".."+equals("educationPath"));
		
		
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
	$("#myModal1-submit").click(function(){
		if($("#ispass").text() == '未通过'){
		$.ajax({
			type:"get",
			url:"/jingxin/admin/pass.do?id="+$("#id").text()+"&mail="+$("#mail").text()+"&user="+$("#user").text(),
			success:function(data){
				alert(data);
				$('#myModal').modal('hide');
			}
		});}else{
			alert("已经是专家");
			$('#myModal').modal('hide');
		}
	});

});

</script>
</html>
