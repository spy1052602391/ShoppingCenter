<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>注册成功</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>

		<script type="text/javascript">
            onload = function(){
                setInterval(go,1000);
            }
            var x = 3;
            function go() {
                x--;
                if(x>0){
                    document.getElementById("sp").innerText = x;
                }else{
                    window.location.href = "${pageContext.request.contextPath}/index.action?username=${user.username}";
                }
            }
		</script>

	</head>

	<body>
		<div class="container-fluid">

			<jsp:include page="${pageContext.request.contextPath}/jsp/head.jsp"></jsp:include>

			<div class="container-fluid">
				<%--获取提示信息--%>
				<h1>${msg}</h1>
					<h1 id = "sp">3</h1>
					<h1>秒后重新返回首页。</h1>
			</div>
		</div>
		<jsp:include page="${pageContext.request.contextPath}/jsp/tail.jsp"></jsp:include>
		</div>

	</body>

</html>