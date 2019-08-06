<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
	<head></head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>会员注册</title>
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
    color: #3164af;
    font-size: 18px;
    font-weight: normal;
    padding: 0 10px;
}
 </style>
	<%--
		注册的表单校验
	--%>
	<script type="text/javascript">
		<%--
			定义规则：
			用户名：8-20位的单词字符
			密码：8-20位的单词字符
			邮箱：符合邮件格式(qq.com)
			姓名：非空
			性别：非空
			出生日期：非空
			验证码：注册的时候后台的校验
		--%>
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
                var u = $("#username").val();
                var url = "${pageContext.request.contextPath}/registerCheck.action";
                var data = "username=" + u;
                $.ajax({
                    async:false,
                    url : url,
                    data : data,
                    type : "post",
                    dataType : "json",
                    success : function (json) {
                        if(json.state == 0){
                            //校验成功
                            $("#username").css("border","2px solid green");
                            document.getElementById("h1").innerHTML = "";
                        }else{
                            document.getElementById("h1").innerHTML = "用户名已经存在！";
                            $("#username").css("border","2px solid red");
                            flag = false;
                        }
                    }
                });
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

        //确认密码的方法
        function checkPassword2() {
            //测试
			var password  = $("#password").val();
            var password2 = $("#password2").val();

            //判断标记
            if(password == password2){
                //校验成功
                $("#password2").css("border","2px solid green");
                document.getElementById("h3").innerHTML = "";
            }else{
                document.getElementById("h3").innerHTML = "两次输入密码不一致";
                //校验失败
                $("#password2").css("border","2px solid red");
            }
            return password==password2;
        }

        //邮箱的校验
        function checkEmail() {
            var email = $("#inputEmail3").val();
            var reg_email = /^\w+@\w+\.\w+$/;

            var flag = reg_email.test(email);

            if(flag){
                $("#inputEmail3").css("border","2px solid green");
                document.getElementById("h4").innerHTML = "";
			}else{
                $("#inputEmail3").css("border","2px solid red");
                document.getElementById("h4").innerHTML = "邮箱格式不正确";
			}
			return flag;
        }

        //jquery的页面载入方法
        $(function () {

            //注册的时候，要将当前的所有的校验方法都执行。
			$("#registForm").submit(function () {
				//如果当前表单中所有的表单项都校验成功，才能注册
				return checkUsername() && checkPassword()  && checkPassword2() && checkEmail() && codeCheck() ;
            });

            //某个表单项失去焦点，校验一下


			$("#username").blur(checkUsername);  //参数是方法对象

			$("#password").blur(checkPassword);

			$("#password2").blur(checkPassword2);

			$("#inputEmail3").blur(checkEmail);

            $("#check").blur(codeCheck);
        });

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

</head>
<body>
			<!--
            	描述：菜单栏
            -->
			<div class="container-fluid">
				<jsp:include page="${pageContext.request.contextPath}/jsp/head.jsp"></jsp:include>

<div class="container" style="width:100%;background:url('${pageContext.request.contextPath}/image/regist_bg.jpg');">
<div class="row"> 

	<div class="col-md-2"></div>

	<div class="col-md-8" style="background:#fff;padding:40px 80px;margin:30px;border:7px solid #ccc;">
		<font>会员注册</font>USER REGISTER<br>

		<form class="form-horizontal" id="registForm" style="margin-top:5px;" action="${pageContext.request.contextPath}/register.action" method="post">

			<div class="form-group">
			    <label for="username" class="col-sm-2 control-label">用户名</label>
			    <div class="col-sm-6">
			        <input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名">
					<h id="h1"></h>
				</div>
			  </div>

			<div class="form-group">
			    <label for="inputPassword3"  class="col-sm-2 control-label">密码</label>
			    <div class="col-sm-6">
			        <input type="password" id="password" class="form-control" id="inputPassword3" name="password" placeholder="请输入密码">
					<h id="h2"></h>
				</div>
			  </div>

			<div class="form-group">
			    <label for="confirmpwd" class="col-sm-2 control-label">确认密码</label>
			    <div class="col-sm-6">
					<input type="password" id="password2" class="form-control" id="confirmpwd" placeholder="请输入确认密码">
					<h id="h3"></h>
				</div>
			  </div>

			<div class="form-group">
			    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
			    <div class="col-sm-6">
			      <input type="email" class="form-control" name="email" id="inputEmail3" placeholder="Email">
					<h id="h4"></h>
			    </div>
			  </div>
			 <div class="form-group">
			    <label for="usercaption" class="col-sm-2 control-label">姓名</label>
			    <div class="col-sm-6">
			      <input type="text" class="form-control" name="name" id="usercaption" placeholder="请输入姓名">
			    </div>
			  </div>
			  <div class="form-group opt">  
			  <label for="inlineRadio1" class="col-sm-2 control-label">性别</label>  
			  <div class="col-sm-6">
			    <label class="radio-inline">
			  <input type="radio" name="sex" id="inlineRadio1" value="男" checked> 男
			</label>
			<label class="radio-inline">
			  <input type="radio" name="sex" id="inlineRadio2" value="女"> 女
			</label>
			</div>
			  </div>		
			  <div class="form-group">
			    <label for="birthday"  class="col-sm-2 control-label">出生日期</label>
			    <div class="col-sm-6">
			      <input id="birthday" type="date" class="form-control" name="birthday" >
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label for="check" class="col-sm-2 control-label">验证码</label>
			    <div class="col-sm-3">
			      <input type="text" id="check" class="form-control"   name="check1" >
					<h id="h5"></h>
			    </div>
			    <div class="col-sm-2">
			    <img src="/checkCode" onclick="changeCodeImg(this)"/>
					<%--设置验证码的图片点击事件--%>
					<script type="text/javascript">
						function changeCodeImg(img) {
							//更改Img对象的src属性
							img.src = "${pageContext.request.contextPath}/checkCode?"+new Date().getTime();   //可以直接就给后台发消息，局部变化了
                        }
					</script>
			    </div>
			  </div>
			 
			  <div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <input type="submit"  width="100" value="注册" name="submit" border="0"
				    style="background: url('${pageContext.request.contextPath}/images/register.gif') no-repeat scroll 0 0 rgba(0, 0, 0, 0);
				    height:35px;width:100px;color:white;">
			    </div>
			  </div>
			</form>
	</div>
	
	<div class="col-md-2"></div>
  
</div>
</div>
					<jsp:include page="${pageContext.request.contextPath}/jsp/tail.jsp"></jsp:include>

</body></html>




