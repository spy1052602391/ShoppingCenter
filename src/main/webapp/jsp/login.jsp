<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>会员登录</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" />
		<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<!-- 引入自定义css文件 style.css -->
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>

<style>
  body{
   margin-top:20px;
   margin:0 auto;
 }
 .carousel-inner .item img{
	 width:100%;
	 height:300px;
 }
 .container .row div{ 
	 /* position:relative;
	 float:left; */
 }
 
font {
    color: #666;
    font-size: 22px;
    font-weight: normal;
    padding-right:17px;
}
 </style>
	<script  type="text/javascript">
        //校验用户名的方法
        function checkUsername() {
            //测试

            var username = $("#username").val();

            //规则
            var reg_username = /^\w{8,20}$/;

            //校验
            var flag = reg_username.test(username);
            //判断标记
            if(flag){
                //校验成功
                $("#username").css("border","2px solid green");
                document.getElementById("h1").innerHTML = "";
            }else{
                document.getElementById("h1").innerHTML = "请输入8-20位的数字或英文字母";
                //校验失败
                $("#username").css("border","2px solid red");
            }
            return flag;
        }

        //校验密码的方法
        function checkPassword() {
            //测试

            var password = $("#password").val();

            //规则
            var reg_password = /^\w{8,20}$/;

            //校验
            var flag = reg_password.test(password);
            //判断标记
            if(flag){
                //校验成功
                $("#password").css("border","2px solid green");
                document.getElementById("h2").innerHTML = "";
            }else{
                document.getElementById("h2").innerHTML = "请输入8-20位的数字或英文字母";
                //校验失败
                $("#password").css("border","2px solid red");
            }
            return flag;
        }

        function userCheck(){
            var result = false;
            var u = $("#username").val();
            var p = $("#password").val();
            var url = "${pageContext.request.contextPath}/userCheck.action";
            var data = "username=" + u + "&password="+ p;
            $.ajax({
                async:false,
                url : url,
                data : data,
                type : "post",
                dataType : "json",
                success : function (json) {
                    if(json.state == 0){
						alert("用户名不存在！")
						result = false;
                    }else if(json.state == -1){
						alert("用户名和密码不匹配！")
						result = false;
                    }else{
                        result = true;
					}
                }
            });
            return result;
		}

		$(function () {
		    $("#loginForm").submit(function () {
				return checkUsername() && checkPassword() && codeCheck() && userCheck();
            })
            $("#check").blur(codeCheck);

            $("#username").blur(checkUsername);  //参数是方法对象

            $("#password").blur(checkPassword);
        })
	</script>
</head>
<body>
			<!--
            	描述：菜单栏
            -->
			<div class="container-fluid">
				<jsp:include page="${pageContext.request.contextPath}/jsp/head.jsp"></jsp:include>

<div class="container"  style="width:100%;height:460px;background:#FF2C4C url('${pageContext.request.contextPath}/images/loginbg.jpg') no-repeat;">
<div class="row"> 
	<div class="col-md-7">
		<%--<img src="${pageContext.request.contextPath}/image/login.jpg" width="500" height="330" alt="会员登录" title="会员登录">--%>
	</div>
	
	<div class="col-md-5">
				<div style="width:440px;border:1px solid #E7E7E7;padding:20px 0 20px 30px;border-radius:5px;margin-top:60px;background:#fff;">
				<font>会员登录</font>USER LOGIN

				<div>&nbsp;</div>
<form class="form-horizontal" action="${pageContext.request.contextPath}/UserLogin.action" method="post" id="loginForm">
  <span style="color: red;">${msg}</span>
 <div class="form-group">
    <label for="username" class="col-sm-2 control-label">用户名</label>
    <div class="col-sm-6">
      <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名">
		<h id="h1"></h>
    </div>
  </div>
   <div class="form-group">
    <label for="password" class="col-sm-2 control-label">密码</label>
    <div class="col-sm-6">
      <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
		<h id="h2"></h>
    </div>
  </div>
   <div class="form-group">
        <label for="check" class="col-sm-2 control-label">验证码</label>
    <div class="col-sm-3">
      <input type="text" class="form-control" id="check" placeholder="请输入验证码" name="check"/>
		<h id="h5"></h>
    </div>
    <div class="col-sm-3">
      <img src="${pageContext.request.contextPath}/checkCode" onclick="changeCodeImg(this)"/>
		<%--设置验证码的图片点击事件--%>
		<script type="text/javascript">
            function changeCodeImg(img) {
                //更改Img对象的src属性
                img.src = "${pageContext.request.contextPath}/checkCode?"+new Date().getTime();   //可以直接就给后台发消息，局部变化了
            }

            function codeCheck() {
                var flag = false;
                var u = $("#check").val();
                var url = "${pageContext.request.contextPath}/codeCheck.action";
                var data = "check1=" + u;
                $.ajax({
                    async:false,
                    url : url,
                    data : data,
                    type : "post",
                    dataType : "json",
                    success : function (json) {
                        if(json.state == 1){
                            $("#check").css("border","2px solid green");
                            document.getElementById("h5").innerHTML = "";
                            flag = true;
                        }else{
                            document.getElementById("h5").innerHTML = "验证码输入不正确";
                            $("#check").css("border","2px solid red");
                            flag = false;
                        }
                    }
                });
                return flag;
            }
		</script>
    </div>
    
  </div>

  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
    <input type="submit"  width="100" value="登录" name="submit" border="0" id="submit"
    style="background: url('${pageContext.request.contextPath}/images/login.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
    height:35px;width:100px;color:white;">
    </div>
  </div>
</form>
</div>			
	</div>
</div>
</div>

					<jsp:include page="${pageContext.request.contextPath}/jsp/tail.jsp"></jsp:include>
</body></html>