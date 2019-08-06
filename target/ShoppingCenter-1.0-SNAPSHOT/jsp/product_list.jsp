<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>购物商城</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- 引入自定义css文件 style.css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css" />

        <script type="text/javascript">

        </script>
        
		<style>
			body {
				margin-top: 20px;
				margin: 0 auto;
				width: 100%;
			}
			.carousel-inner .item img {
				width: 100%;
				height: 300px;
			}

			li{
				list-style-type:none;
			}
		</style>
	</head>

	<body>
			<!--
            	描述：菜单栏
            -->
			<div class="container-fluid">
				<jsp:include page="${pageContext.request.contextPath}/jsp/head.jsp"></jsp:include>

		<div class="row" style="width:1210px;margin:0 auto;">
			<c:forEach items="${pb.list}" var="p">
				<div class="col-md-2">
					<a href="${pageContext.request.contextPath}/productInfo.action?pid=${p.pid}">
						<img src="${pageContext.request.contextPath}/${p.pimage}" width="170" height="170" style="display: inline-block;">
					</a>
					<p><a href="${pageContext.request.contextPath}/productInfo.action?pid=${p.pid}" style='color:green'>${fn:substring(p.pname,0,12)}...</a></p>
					<p><font color="#FF0000">商城价：&yen;${p.shop_price}</font></p>
				</div>
			</c:forEach>

		</div>

		<!--分页 -->
		<div style="width:500px;margin:0 auto;margin-top:50px;">
			<c:if test="${pb!=null}">
				<ul class="pagination" style="text-align:center; margin-top:10px;">
						<%--
                            判断首页
                        --%>
					<c:if test="${pb.currentPage==1}">
						<%--disabled;禁用--%>
						<li class="disabled"><a href="javascript:void(0)" aria-label="Previous"><span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
						<%--如果不是首页--%>
					<c:if test="${pb.currentPage!=1}">
						<li><a href="${pageContext.request.contextPath}/productShow.action?cid=${param.cid}&currentPage=${pb.currentPage-1}" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
					</c:if>

						<%--模板百度的规律:前5后4--%>
					<c:forEach begin="${1}" end="${pb.totalPage}" var="n">

						<%--判断是否是当前页
                            是当前页,让超链接失效
                        --%>
						<c:if test="${pb.currentPage==n}">
							<%--
                              class="active"  ：boostrap的全局CSS样式 active：选中
                            --%>
							<li class="active"><a href="javascript:void(0)">${n}</a></li>
						</c:if>

						<%--是可以点击的,--%>
						<c:if test="${pb.currentPage!=n}">
							<li><a href="${pageContext.request.contextPath}/productShow.action?cid=${param.cid}&currentPage=${n}">${n}</a></li>
						</c:if>
					</c:forEach>
						<%--判断当前页码是否是最后一页--%>
					<c:if test="${pb.currentPage==pb.totalPage}">
						<li class="disabled">
							<a href="javascript:void(0)" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
					<c:if test="${pb.currentPage != pb.totalPage}">
						<li>
							<a href="${pageContext.request.contextPath}/productShow.action?cid=${param.cid}&currentPage=${pb.currentPage+1}" aria-label="Next">
								<span aria-hidden="true">&raquo;</span>
							</a>
						</li>
					</c:if>
				</ul>
			</c:if>

		</div>
		<!-- 分页结束=======================        -->

		<!--
       		商品浏览记录:
        -->
		<div style="width:1210px;margin:0 auto; padding: 0 9px;border: 1px solid #ddd;border-top: 2px solid #999;height: 246px;">

			<h4 style="width: 50%;float: left;font: 20px/30px  微软雅黑 ">浏览记录</h4>
			<div style="clear: both;"></div>

			<div style="overflow: hidden;">
				<ul>
					<c:forEach items="${historyList}" var="p">
						<li style="width: 150px;height: 216px;float: left;margin: 0 8px 0 0;padding: 0 18px 15px;text-align: center;">
							<a href="${pageContext.request.contextPath}/productInfo.action?pid=${p.pid}"><img src="${pageContext.request.contextPath}/${p.pimage}" width="130px" height="130px" /></a>
							<p><a href="${pageContext.request.contextPath}/productInfo.action?pid=${p.pid}" style='color:green'>${fn:substring(p.pname,0,8)}...</a></p>
							<p><font color="#FF0000">商城价：&yen;${p.shop_price}</font></p>
						</li>
					</c:forEach>
				</ul>


			</div>
		</div>
                    <jsp:include page="${pageContext.request.contextPath}/jsp/tail.jsp"></jsp:include>

	</body>

</html>