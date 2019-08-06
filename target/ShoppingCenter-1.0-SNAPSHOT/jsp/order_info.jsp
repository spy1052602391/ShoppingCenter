<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>确认订单</title>
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


		<div class="container">
			<div class="row">

				<div style="margin:0 auto;margin-top:10px;width:950px;">
					<strong>订单详情</strong>
					<table class="table table-bordered">
						<tbody>
						<c:set var="oid1" value="${CartList[0].oid}"/>
							<tr class="warning">
								<th colspan="5">订单编号:${oid1} </th>
							</tr>
							<tr class="warning">
								<th>图片</th>
								<th>商品</th>
								<th>价格</th>
								<th>数量</th>
								<th>小计</th>
							</tr>
							<c:set var="sum" value="0"/>
							<c:forEach items="${CartList}" var="list">
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
										￥${list.product.shop_price}元
									</td>
									<td width="10%">
										${list.count}
									</td>
									<td width="15%">
										<span class="subtotal">￥${list.subtotal}元</span>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<div style="text-align:right;margin-right:120px;">
					订单总金额: <strong style="color:#ff6600;">￥${sum}元</strong>
				</div>

			</div>

			<div>
				<hr/>
				<form id="orderForm" action="${pageContext.request.contextPath}/buyProduct.action" class="form-horizontal" method="get" style="margin-top:5px;margin-left:150px;">
					<div class="form-group">
						<label for="address" class="col-sm-1 control-label">地址</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="address" name="address" placeholder="请输入收货地址">
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-sm-1 control-label">收货人</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="name" name="name" placeholder="请输收货人">
						</div>
					</div>
					<div class="form-group">
						<label for="telephone" class="col-sm-1 control-label">电话</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="telephone" name="telephone" placeholder="请输入联系方式">
						</div>
					</div>
					<input type="hidden" name="uid" value="${user.uid}"/>
					<input type="hidden" name="oid" value="${oid1}"/>
				</form>

				<hr/>

				<div style="margin-top:5px;margin-left:150px;">

					<c:choose>
						<c:when test="${order.address!=null}">
							<span style="color: green"><h2>交易完成！商品正在配送中...</h2></span>
						</c:when>
						<c:otherwise>
							<strong>选择银行：</strong>
							<p>
								<br/>
								<input type="radio" name="pd_FrpId" value="ICBC-NET-B2C" checked="checked" />工商银行
								<img src="${pageContext.request.contextPath}/bank_img/icbc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="pd_FrpId" value="BOC-NET-B2C" />中国银行
								<img src="${pageContext.request.contextPath}/bank_img/bc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="pd_FrpId" value="ABC-NET-B2C" />农业银行
								<img src="${pageContext.request.contextPath}/bank_img/abc.bmp" align="middle" />
								<br/>
								<br/>
								<input type="radio" name="pd_FrpId" value="BOCO-NET-B2C" />交通银行
								<img src="${pageContext.request.contextPath}/bank_img/bcc.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="pd_FrpId" value="PINGANBANK-NET" />平安银行
								<img src="${pageContext.request.contextPath}/bank_img/pingan.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="pd_FrpId" value="CCB-NET-B2C" />建设银行
								<img src="${pageContext.request.contextPath}/bank_img/ccb.bmp" align="middle" />
								<br/>
								<br/>
								<input type="radio" name="pd_FrpId" value="CEB-NET-B2C" />光大银行
								<img src="${pageContext.request.contextPath}/bank_img/guangda.bmp" align="middle" />&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" name="pd_FrpId" value="CMBCHINA-NET-B2C" />招商银行
								<img src="${pageContext.request.contextPath}/bank_img/cmb.bmp" align="middle" />

							</p>
							<hr/>
							<p style="text-align:right;margin-right:100px;">
								<a onclick="go()">
									<img src="${pageContext.request.contextPath}/images/finalbutton.gif" width="204" height="51" border="0" />
								</a>
							</p>
							<hr/>
						</c:otherwise>
					</c:choose>

					<script  type="text/javascript">

						function go(){
						    if($("#address").val()!="" && $("#telephone").val()!="" && $("#name").val()!=""){
                                document.getElementById('orderForm').submit();
							}else{
						        alert("请将信息填写完整之后提交！")
							}

						}

                        $(function () {
							if(${order.address!=null}){
							    $("#address").val("${order.address}");
                                $("#name").val("${order.name}");
                                $("#telephone").val("${order.telephone}");
                                $("#address").attr("disabled","disabled");
                                $("#name").attr("disabled","disabled");
                                $("#telephone").attr("disabled","disabled");
                            }
                        })
					</script>
				</div>

			</div>

		</div>

	<jsp:include page="${pageContext.request.contextPath}/jsp/tail.jsp"></jsp:include>

	</body>

</html>