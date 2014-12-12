<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Profile</title>
<meta charset="utf-8">
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
    <link href="css/bootstrap.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700,300' rel='stylesheet' type='text/css'>
    <script src="js/jquery-1.7.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
</head>
<body>

<h3>Profile page</h3>



<%
//allow access only if session exists
String user = null;
if(request.getParameter("navigateuser") == null) {
	if(session.getAttribute("user") == null){
	    response.sendRedirect("login.jsp");
	}else user = (String) session.getAttribute("user");
} else {
	user = request.getParameter("navigateuser");
}

%>

<br>
<%=user %> Profile :
<br>

<!-- <div>
<p>First name:<span id="firstName"></span></p>
<p>Last name:<span id="lastName"></span></p>

</div> -->

<div ng-controller="profileController" style="float:left; display:inline-block;"> 
    <%-- <input type="hidden" id="sessionUser" name="user" value=<%=(String) session.getAttribute("user") %> />   --%>  
    <input type="hidden" id="sessionUser" name="user" value=<%=user %> />  
<h3> Recent views</h3>
<table>
  <tbody>
    <tr ng-repeat="view in views" >
    <td><a href=<%= "\"details.jsp?styleId="%>{{view.styleId}} <%= "\"" %>> {{view.styleId}}</a></td>
    </tr>  
  </tbody>
</table>
<br/>
<br/>
<br/>
<br/>
<h3> Recent Likes</h3>
<table>
  <tbody>
    <tr ng-repeat="mapper in mappers" >
    <td><a href=<%= "\"details.jsp?styleId="%>{{mapper.mapCar.styleId}} <%= "\"" %>> {{mapper.mapCar.styleId}}</a></td>
    </tr>  
  </tbody>
</table>

<br/>
<br/>
<h3> Recent Reviews</h3>
<table>
  <tbody>
    <tr ng-repeat="rate in rates" >
    <td><a href=<%= "\"details.jsp?styleId="%>{{rate.styleId}} <%= "\"" %>> {{rate.styleId}}</a></td>
    </tr>  
  </tbody>
</table>

 </div>

<script>
<%-- $(function(){
	alert("in here");
	var usr =  "<%=user %>";
	alert(usr);
	var fullUrl = "http://localhost:8082/Project/rest/person/get/" + usr;
	//var fullRecentSearchUrl = "http://localhost:8082/Project/rest/person//" + usr;
	$.ajax({
		url : fullUrl ,
		type:"get",
		dataType: "json",
		contentType: "application/json",
		success:function(response) {
			console.log(response);
			document.getElementById("firstName").innerHTML = response.firstName;
			document.getElementById("lastName").innerHTML = response.lastName;
		}
	});
	
/* 	$.ajax({
		url : fullUrl ,
		type:"get",
		dataType: "json",
		contentType: "application/json",
		success:function(response) {
			console.log(response);
			document.getElementById("firstName").innerHTML = response.firstName;
			document.getElementById("lastName").innerHTML = response.lastName;
		}
	}); */
}); --%>


/* function profileController($scope,$http) {
	 
	$scope.recentView = function(){
	if (user != null) {
		console.log("userController");
	// 	console.log(user.username); 
		var objUser = $('#tempUser').val();
	
		var url = "http://localhost:8082/Project/rest/view/viewsforperson/" + objUser;
		$http.get(url)
  	  .success(function(response) 
  	           {console.log(response)
  		  		$scope.views=response;
  	           });
  	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
	}
	  
	}    
	} */
	
	function profileController($scope,$http) {
		 
	//	$scope.recentView = function(){
	//	if (user != null) {
			console.log("userController");
		/* 	console.log(user.username); */
			var objUser = $('#sessionUser').val();
		console.log(objUser);
		/* 	var rating = new Object();
			rating.comment=$scope.comments;
			rating.styleId=101353967;
			rating.rate=3;
			rating.name="sara"; */
			var viewsurl = "http://localhost:8082/Project/rest/view/viewsforperson/" + "sara";
			$http.get(viewsurl)
	  	  .success(function(response) 
	  			  console.log("views");
	  	           {console.log(response)
	  		  		$scope.views=response;
	  	           });
			var likesurl = "http://localhost:8082/Project/rest/mapper/getlikes/" + objUser;
			$http.get(likesurl)
		  	  .success(function(response) 
		  	           {console.log(response)
		  		  		$scope.mappers=response;
		  	           });
			var reviewsurl = "http://localhost:8082/Project/rest/rate/ratesforperson/" + objUser;
			$http.get(reviewsurl)
		  	  .success(function(response) 
		  	           {console.log(response)
		  		  		$scope.rates=response;
		  	           });
	  	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
	//	}
		  
		//}    
		}

</script>
<br>
<br>


</body>
</html>