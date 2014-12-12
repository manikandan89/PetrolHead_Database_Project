<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
<link href="css/bootstrap.css" rel="stylesheet"/>
</head>
<body>

<div class="container">

	<h1>Register</h1>
	<form action="/Project/register" method="post">
		
		First Name:
		<input name="firstname" class="form-control"/>
		
		Last Name:
		<input name="lastname" class="form-control"/>
		
		Email id:
		<input name="emailid" class="form-control"/>
		
		Username:
		<input name="username" class="form-control"/>
		
		Password:
		<input name="password" type="password"  class="form-control"/>
		
		Retype Password:
		<input name="retypepassword" type="password"  class="form-control"/>
		
		<button class="btn btn-primary btn-block">Register</button>
	</form>	
</div>

</body>
</html>