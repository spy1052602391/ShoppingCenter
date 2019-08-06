<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%--
    加载首页的时候,动态包含了head.jsp,异步请求服务器,发送ajax
--%>
    <script>
        //页面载入事件
        $(function () {
            //直接要发送ajax请求
            $.get("${pageContext.request.contextPath}/category.action",function (data) {
                //data:[{cid:1,cname:"电脑办公"},{},{},{}],
                //通过Jquery方式获取Ul标签对象
                var $ul =  $("#menuId");
                //遍历服务器响应过来的集合数据
                $(data).each(function () {
                    //在ul的添加子标签li
                    $ul.append($("<li><a href='${pageContext.request.contextPath}/productShow.action?method=findByPage&cid="+this.cid+"&currentPage=1'>"+this.cname+"</a></li>")) ;
                }) ;

            },"json") ;
            //在后台定义响应格式：response.setContentType("application/json;charset=utf-8")
        }) ;

    </script>

</head>
<body>
<div class="container-fluid">
    <div class="col-md-4">
        <img src="${pageContext.request.contextPath}/img/logo21.png" />
    </div>
    <div class="col-md-5">
        <img src="${pageContext.request.contextPath}/img/header.png" />
    </div>
    <div class="col-md-3" style="padding-top:20px">
        <ol class="list-inline">
            <%--jstl:核心标签库
            empty 可以判断对象/集合是否为空d
            --%>
            <c:if test="${empty user}">
                <li><a href="${pageContext.request.contextPath}/loginOnclick.action">登录</a></li>
                <li><a href="${pageContext.request.contextPath}/registerOnclick.action">注册</a></li>
            </c:if>
            <c:if test="${not empty user}">
                欢迎回来,${user.username}
                <li><a href="javascript:if(confirm('您确定要退出账号吗?'))location='${pageContext.request.contextPath}/quitUser.action'">退出</a></li>
                <li><a href="${pageContext.request.contextPath}/OrderList.action">我的订单</a></li>
            </c:if>
            <li><a href="${pageContext.request.contextPath}/cartOnclick.action">购物车</a></li>
        </ol>
    </div>
</div>
<!--
描述：导航条
-->
<div class="container-fluid">
    <nav class="navbar navbar-inverse">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/index.action">首页</a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul  id="menuId" class="nav navbar-nav">

                </ul>
                <form class="navbar-form navbar-right" role="search" action="${pageContext.request.contextPath}/searchProduct.action">
                    <div class="form-group">
                        <input name="search" type="text" class="form-control" placeholder="Search">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>

            </div>
        </div>
    </nav>
</div>
</body>
</html>


