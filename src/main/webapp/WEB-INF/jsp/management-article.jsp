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

<title>文章管理</title>

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
<script charset="utf-8" src="../plugin/editor/kindeditor.js"></script>
<script charset="utf-8" src="../plugin/editor/lang/zh_CN.js"></script>

</head>

<body>

	<jsp:include page="/WEB-INF/jsp/include-navbar.jsp">
		<jsp:param value="article" name="content"/>
	</jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 hidden-xs sidebar">
				<ul class="nav nav-sidebar">
					<jsp:include page="/WEB-INF/jsp/include-mainMenu.jsp">
						<jsp:param value="article" name="content"/>
					</jsp:include>
				</ul>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
						<div id="table-toolbar">
					<c:if test="${loginedUser.type <= 1 }">
						<button type="button" class="btn btn-default" id="add-user" data-toggle="modal" data-target="#myModal">
							<span class="glyphicon glyphicon-plus-sign" aria-hidden="true"></span>
							发表文章
						</button>
						<button type="button" class="btn btn-default only-one"  id="edit-article" data-toggle="modal" data-target="#myModal2">
							<span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
							编辑文章
						</button>
						<button type="button" class="btn btn-default only-more" id="delete-article" disabled="disabled">
							<span class="glyphicon glyphicon-minus-sign" aria-hidden="true"></span>
							删除文章
						</button>
					</c:if>
					
					<%-- <button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal2">
					筛选过滤
					</button> --%>
				
				</div>
				
				
				<h3 class="sub-header">文章管理</h3>
				<table id="main-table" data-toggle="table" data-url="adminarticle.do"
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
				        <th data-field="name">用户名</th>
				        <th data-field="title">标题</th>
				        <th data-field="type">类型</th>
				        <th data-field="publishdate">时间</th>
				    </tr>
				    </thead>
				</table>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade bs-example-modal-lg" id="myModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<form class="modal-content" id = "addArticle" action="management-addArticle.do" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">发表文章</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="type">类型</label>
						<select id="type" class="form-control" name="type">
							<option value="公告">公告</option>
							<option value="新闻">新闻</option>
							<option value="资料">资料</option>
						</select>
					</div>
					<div class="form-group">
						<label for="title">标题</label>
						<input type="text" class="form-control" name="title" id="title">
					</div>

					<div class="form-group">
						<label for="editor_id">内容</label>
						<textarea id="editor_id" class="editor_id" name="content" style="width:860px;height:350px;"></textarea>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="提交" class="btn btn-primary" id="myModal1-submit"/>
				</div>
			</form>
		</div>
	</div>
	<div class="modal fade bs-example-modal-lg" id="myModal2" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<form class="modal-content" id = "addArticle" action="management-updArticle.do" method="post">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">更改文章</h4>
				</div>
				<div class="modal-body">
					<input  id="hideInput" type="hidden" name="editid"/>
					<div class="form-group">
						<label for="edittype">类型</label>
						<select id="edittype" class="form-control" name="edittype">
							<option value="公告">公告</option>
							<option value="新闻">新闻</option>
							<option value="资料">资料</option>
						</select>
					</div>
					<div class="form-group">
						<label for="edittitle">标题</label>
						<input type="text" class="form-control" name="edittitle" id="edittitle">
					</div>
					<div class="form-group">
						<label for="editor_edit">内容</label>
						<textarea id="editor_edit" class="editor_id"  name="editcontent" style="width:860px;height:350px;"></textarea>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<input type="submit" value="提交" class="btn btn-primary" id="myModal1-submit"/>
				</div>
			</form>
		</div>
	</div>
	
	

</body>
<script>
var editor;
KindEditor.ready(function(K) {
	editor = K.create($(".editor_id"), {
		cssPath : '../plugin/editor/plugins/code/prettify.css',
		uploadJson : '../plugin//editor/jsp/upload_json.jsp',
		fileManagerJson : '../plugin//editor/jsp/file_manager_json.jsp',
		allowFileManager : true,
		afterCreate : function() {
			var self = this;
			K.ctrl(document, 13, function() {
				self.sync();
				document.forms['example'].submit();
			});
			K.ctrl(self.edit.doc, 13, function() {
				self.sync();
				document.forms['example'].submit();
			});
		}
	});
	try{
		prettyPrint();
	} catch(e){
		
	}
});

$(document).ready(function() {

	$("#delete-article").click(function() {
		
		var rows = $("#main-table").bootstrapTable("getSelections");

		var IDArray = [];
		for (var i in rows) {
			IDArray.push(rows[i].id);
		}
		
		var sure = confirm("确定删除这 " + IDArray.length + " 项吗？");
		if(!sure) {
			return;
		}
		
		
		var URL = "deleteArticle.do";
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
	
	
	$("#edit-article").click(function() {
		
		var rows = $("#main-table").bootstrapTable("getSelections");
	
		$("#myModal2 [name='edittitle']").val(equals("title"));
		$("#myModal2 [name='edittype']").val(equals("type"));
		$("#hideInput").val(rows[0].id);
		$.ajax({
			url:'article_content.do',
			data:{id:rows[0].id},
			success:function(data){
				KindEditor.html("#editor_edit", data);
			}
		})

		
		
		
		
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
		$.ajax({
			type:"get",
			url:"/jingxin/admin/pass.do?id="+$("#id").text()+"&mail="+$("#mail").text(),
			success:function(data){
				alert(data);
				$('#myModal').modal('hide');
			}
		});
	});

});

</script>
</html>
