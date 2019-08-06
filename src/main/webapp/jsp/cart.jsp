<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>购物车</title>
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

			font {
				color: #3164af;
				font-size: 18px;
				font-weight: normal;
				padding: 0 10px;
			}
		</style>
	</head>

	<body>


	<jsp:include page="${pageContext.request.contextPath}/jsp/head.jsp"></jsp:include>


		<div class="container">
			<div class="row">

				<div style="margin:0 auto; margin-top:10px;width:950px;">
					<strong style="font-size:16px;margin:5px 0;">订单详情</strong>
					<table class="table table-bordered">
						<tbody>
							<tr class="warning">
								<th>图片</th>
								<th>商品</th>
								<th>价格</th>
								<th>数量</th>
								<th>小计</th>
								<th>操作</th>
							</tr>
                            <c:set var="sum" value="0"/>
							<c:forEach items="${CartList}" var="list" varStatus="status">
                                <c:set var="sum" value="${sum+list.subtotal}"/>
								<tr class="active">
									<td width="60" width="40%">
										<input type="hidden" name="id" value="22">
										<img src="${pageContext.request.contextPath}/${list.product.pimage}" width="70" height="60">
									</td>
									<td width="30%">
										<a target="_blank">${list.product.pname}</a>
									</td>
									<td width="20%">
										￥${list.product.shop_price}
									</td>
									<td width="10%">
											${list.count}
									</td>
									<td width="15%">
										<span class="subtotal">￥${list.subtotal}</span>
									</td>
									<td>
										<a href="${pageContext.request.contextPath}/deleteItem.action?index=${status.index}" class="delete">删除</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<div style="margin-right:130px;">
				<div style="text-align:right;">
					商品总金额: <strong style="color:#ff6600;">￥${sum}元</strong>
				</div>
				<div style="text-align:right;margin-top:10px;margin-bottom:10px;">
					<a href="javascript:if(confirm('您确定要清空购物车吗?'))location='${pageContext.request.contextPath}/clearItem.action'" id="clear" class="clear">清空购物车</a>
					<a onclick="go()">
						<input type="submit" width="100" value="提交订单" name="submit" border="0" style="background: url('${pageContext.request.contextPath}/images/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
						height:35px;width:100px;color:white;">
					</a>
					<script type="text/javascript">
						function go() {
						    if(${sum == 0}){
						        alert("购物车不能为空！")
                            }else if(${user == null}){
						        alert("请先登陆!")
								window.location.href="${pageContext.request.contextPath}/loginOnclick.action";
                            }else{
                                window.location.href="${pageContext.request.contextPath}/submitOrder.action?sum=${sum}";
                            }
                        }
					</script>
				</div>
			</div>

		</div>
	<jsp:include page="/jsp/tail.jsp"></jsp:include>

	</body>

</html>