<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Petrolhead Login</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<body>

<div class="container">

	<h1>Login</h1>
	<form action="/Project/login" method="post">
		Username:
		<input name="username" class="form-control" placeholder="Username" style="width:200px;height:50px;"/>
		<br/>
		Password:
		<input name="password" type="password"  class="form-control" style="width:200px;height:50px;"/>
		<br/>
		<button class="btn btn-primary btn-block" style="width:200px;height:50px;">Login</button>
	</form>	
	<br/><br/>
	<a href="/Project/register.jsp">SignUp</a>
</div>

</body>
</html>