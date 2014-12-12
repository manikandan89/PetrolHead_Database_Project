<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rating for cars</title>
<script type="text/javascript" src="js/jquery.js"></script>
</head>
<body>
<h3>Rating page</h3>

<%
//allow access only if session exists
String user = null;
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
}else user = (String) session.getAttribute("user");
%>

<br>
User=<%=user %>
<br>

<div>
<ul id="groups"></ul>

</div>
<script>
$(function(){
	alert("in here");
	var usr =  "<%=user %>";
	alert(usr);
	var fullUrl = "http://localhost:8082/Project/rest/view/viewsforperson/" + usr;
	$.ajax({
		url : fullUrl ,
		type:"get",
		dataType: "json",
		contentType: "application/json",
		success:function(response) {
			var json = $.parseJSON(response);
			console.log(json);
			
			$(document).ready(function() {
			var $grouplist = $('#groups');
			$.each(json, function() {
		        $('<li>' + this.reviews + '</li>').appendTo($grouplist);
			});
			});
			//document.getElementById("firstName").innerHTML = response.firstName;
			//document.getElementById("lastName").innerHTML = response.lastName;
		}
	});
});
</script>
<br>
	
</body>
</html>