<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<li <c:if test="${param.content=='extractRecord'}">class="active"</c:if> >
	<a href="management-extractRecord.do">专家抽取</a>
</li>

<li <c:if test="${param.content=='userManage'}">class="active"</c:if> >
	<a href="management-userManage.do">用户管理</a>
</li>
<li <c:if test="${param.content=='expertManage'}">class="active"</c:if> >
	<a href="management-expertManage.do">审核专家</a>
</li>

<li <c:if test="${param.content=='fieldManage'}">class="active"</c:if> >
	<a href="management-fieldManage.do">领域管理</a>
</li>



<li <c:if test="${param.content=='article'}">class="active"</c:if> >
	<a href="management-article.do">文章管理</a>
</li>
<li <c:if test="${param.content=='indexmanage'}">class="active"</c:if> >
	<a href="management-index.do">首页管理</a>
</li>
<%-- <c:if test="${user.managergroup.managerGroupPower <= 1 }">
	<li <c:if test="${param.content=='userManage'}">class="active"</c:if> >
		<a href="management-userManage.do">系统用户管理</a>
	</li>
	<li <c:if test="${param.content=='userGroupManage'}">class="active"</c:if> >
		<a href="management-userGroupManage.do">分组权限管理</a>
	</li>
</c:if> --%>
