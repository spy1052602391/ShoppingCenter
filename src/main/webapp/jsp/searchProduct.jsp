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
        <c:choose>
            <c:when test="${list != null && list.size()!=0}">
                <c:forEach items="${list}" var="p">
                    <div class="col-md-2">
                        <a href="${pageContext.request.contextPath}/productInfo.action?pid=${p.pid}">
                            <img src="${pageContext.request.contextPath}/${p.pimage}" width="170" height="170" style="display: inline-block;">
                        </a>
                        <p><a href="${pageContext.request.contextPath}/productInfo.action?pid=${p.pid}" style='color:green'>${fn:substring(p.pname,0,12)}...</a></p>
                        <p><font color="#FF0000">商城价：&yen;${p.shop_price}</font></p>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <h1>搜索结果为空，去看看别的商品！</h1>
            </c:otherwise>
        </c:choose>


    </div>


    <jsp:include page="${pageContext.request.contextPath}/jsp/tail.jsp"></jsp:include>

</body>

</html>