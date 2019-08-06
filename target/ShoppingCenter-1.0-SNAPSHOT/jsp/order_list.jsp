<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>我的订单</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- 引入自定义css文件 style.css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />

		<style>
			body {
				margin-top: 20px;
				margin: 0 auto;
			}
			
			.carousel-inner .item img {
				width: 100%;
				height: 300px;
			}
		</style>
	</head>

	<body>

		<jsp:include page="${pageContext.request.contextPath}/jsp/head.jsp"></jsp:include>

		</nav>

		<div class="container">
			<div class="row">

				<div style="margin:0 auto; margin-top:10px;width:950px;">
					<strong>我的订单</strong><span style="color: red">(只显示订单中的一个商品，如需要，请点击"查看订单详情")</span>
					<table class="table table-bordered">
						<c:forEach items="${OrderList}" var="list">
							<tbody>
							<tr class="success">
								<th colspan="6">订单编号:${list.oid} </th>
								<th colspan="1"><a href="${pageContext.request.contextPath}/deleteOrder.action?uid=${user.uid}&oid=${list.oid}">删除</a></th>
							</tr>
							<tr class="warning">
								<th>图片</th>
								<th>商品</th>
								<th>价格</th>
								<th>电话</th>
								<th>姓名</th>
								<th>状态</th>
								<th>详情</th>
							</tr>
							<tr class="active">
								<td width="60" width="40%">
									<input type="hidden" name="id" value="22">
									<img src="${pageContext.request.contextPath}/${list.product.pimage}" width="70" height="60">
								</td>
								<td width="30%">
									${list.product.pname}
								</td>
								<td width="20%">
									￥${list.total}元
								</td>
								<td width="10%">
									${list.telephone}
								</td>
								<td width="15%">
									<span class="subtotal">${list.name}</span>
								</td>
								<td width="10%">
									<c:choose>
										<c:when test="${list.state == 0}">
											<span style="color: red">未支付</span>
										</c:when>
										<c:otherwise>
											<span style="color: green">已付款,正在配送中..</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td width="15%">
									<a href="${pageContext.request.contextPath}/lookOrders.action?oid=${list.oid}">查看订单详情</a>
								</td>
							</tr>
							</tbody>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>

		<jsp:include page="${pageContext.request.contextPath}/jsp/tail.jsp"></jsp:include>
	</body>

</html>