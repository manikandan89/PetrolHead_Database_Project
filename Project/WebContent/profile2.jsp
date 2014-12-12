<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="">
<head>
    <title>Profile Page</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/slider.css">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700,300' rel='stylesheet' type='text/css'>
   
    <script src="js/jquery-1.7.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/tms-0.4.1.js"></script>
     <script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
    <style type="text/css">
    
.myButton {
	-moz-box-shadow:inset 0px 1px 0px 0px #cf866c;
	-webkit-box-shadow:inset 0px 1px 0px 0px #cf866c;
	box-shadow:inset 0px 1px 0px 0px #cf866c;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #d0451b), color-stop(1, #bc3315));
	background:-moz-linear-gradient(top, #d0451b 5%, #bc3315 100%);
	background:-webkit-linear-gradient(top, #d0451b 5%, #bc3315 100%);
	background:-o-linear-gradient(top, #d0451b 5%, #bc3315 100%);
	background:-ms-linear-gradient(top, #d0451b 5%, #bc3315 100%);
	background:linear-gradient(to bottom, #d0451b 5%, #bc3315 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#d0451b', endColorstr='#bc3315',GradientType=0);
	background-color:#d0451b;
	-moz-border-radius:3px;
	-webkit-border-radius:3px;
	border-radius:3px;
	border:1px solid #942911;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:arial;
	font-size:13px;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #854629;
}
.myButton:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #bc3315), color-stop(1, #d0451b));
	background:-moz-linear-gradient(top, #bc3315 5%, #d0451b 100%);
	background:-webkit-linear-gradient(top, #bc3315 5%, #d0451b 100%);
	background:-o-linear-gradient(top, #bc3315 5%, #d0451b 100%);
	background:-ms-linear-gradient(top, #bc3315 5%, #d0451b 100%);
	background:linear-gradient(to bottom, #bc3315 5%, #d0451b 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#bc3315', endColorstr='#d0451b',GradientType=0);
	background-color:#bc3315;
}
.myButton:active {
	position:relative;
	top:1px;
}

    </style>
    <script>
		$(document).ready(function(){
			$('.slider')._TMS({
				show:0,
				pauseOnHover:true,
				prevBu:'.prev',
				nextBu:'.next',
				playBu:false,
				duration:500,
				preset:'fade',
				pagination:true,//'.pagination',true,'<ul></ul>'
				pagNums:false,
				slideshow:8000,
				numStatus:false,
				banners:'fromBottom',// fromLeft, fromRight, fromTop, fromBottom
				waitBannerAnimation:false,
				progressBar:false
			})
			
	 	}) 
		$(function(){
		  if($(window).width() <= 1066)
			{
			  $("#slider .prev").css("left", "55px")
			  $("#slider .next").css("right", "55px")
			}
		})
	</script>
	

</head>
<body>
<%
//allow access only if session exists
String user = null;
if(session.getAttribute("user") == null){
    response.sendRedirect("login.jsp");
}else user = (String) session.getAttribute("user");
String userName = null;
String sessionID = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
    if(cookie.getName().equals("user")) userName = cookie.getValue();
    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
}
%>

<div class="bg">
   <header>
       <div class="main wrap">
       		<h1><a href="/Project/index.jsp"><img src="images/logo.jpg" alt="" style="margin-top:-20px;"></a></h1> 
            <span><h2 style="float:left">  <%=user %> Profile</h2></span>
       </div>
       <nav>  
          <ul class="menu">
              <li class="current"><a href="/Project/index.jsp" class="home"><img src="images/home.jpg" alt=""></a></li>
              <li><a href="/Project/profile.jsp">Profile</a></li>
              <li><a href="/Project/makes.jsp">Search</a></li>
              <li><a href="/Project/about.jsp">About Us</a></li>
              <li><a href="/Project/logout.jsp">Logout</a></li>
          </ul>
          <div class="clear"></div>
        </nav>
   </header>
  
   <!--==============================content================================-->
   <section id="content"><div class="ic">Trending Cars. November12, 2012!</div>
       <div class="block-1 box-1">
       	<div ng-controller="profileController" style="float:left; display:inline-block;"> 
    <%-- <input type="hidden" id="sessionUser" name="user" value=<%=(String) session.getAttribute("user") %> />   --%>  
    <input type="hidden" id="sessionUser" name="user" value=<%=user %> />  
<h3> Recent car views</h3>
<table>
  <tbody>
     <tr ng-repeat="detail in views" >
    <td><a href=<%= "\"details.jsp?make="%>{{detail.make}}<%="&model="%>{{detail.model}}<%="&year="%>{{detail.year}}<%= "\"" %>> {{detail.styleId}}</a></td>
   
    <%-- <td><a href=<%= "\"details.jsp?make="%>{{view.styleId}}<%="&model="%> <%= "\"" %>> {{view.styleId}}</a></td>
      <td><a href=<%= "\"details.jsp?make="%><%= request.getParameter("make") %><%="&model="%><%= request.getParameter("model") %><%="&year="%>{{years[$index].year}} <%= "\"" %>> {{years[$index].year}}</a></td>
        <td><a href=<%= "\"details.jsp?make="%><%= request.getParameter("make") %><%="&model="%><%= request.getParameter("model") %><%="&year="%>{{years[$index + 1].year}} <%= "\"" %>> {{years[$index + 1].year}}</a></td>
        <td><a href=<%= "\"details.jsp?make="%><%= request.getParameter("make") %><%="&model="%><%= request.getParameter("model") %><%="&year="%>{{years[$index + 2].year}} <%= "\"" %>> {{years[$index + 2].year}}</a></td> 
 	 --%>	
    </tr>  
  </tbody>
</table>
<br/>
<br/>
<br/>
<br/>
<h3> Recent Car Likes</h3>
<table>
  <tbody>
    <tr ng-repeat="detail in likes" >
    <td><a href=<%= "\"details.jsp?make="%>{{detail.make}}<%="&model="%>{{detail.model}}<%="&year="%>{{detail.year}}<%= "\"" %>> {{detail.styleId}}</a></td>
   </tr>  
  </tbody>
</table>

<br/>
<br/>
<h3> Recent Car Ratings</h3>
<table>
  <tbody>
    <tr ng-repeat="detail in reviews" >
     <td><a href=<%= "\"details.jsp?make="%>{{detail.make}}<%="&model="%>{{detail.model}}<%="&year="%>{{detail.year}}<%= "\"" %>> {{detail.styleId}}</a></td>
    <%-- <td><a href=<%= "\"details.jsp?styleId="%>{{rate.styleId}} <%= "\"" %>> {{rate.styleId}}</a></td> --%>
    </tr>  
  </tbody>
</table>

 </div>
        
      </div>
      </div>  
   </section> 
  <!--==============================footer=================================-->
    <footer>
        Website Template designed by <a href="http://www.templatemonster.com/" class="link" rel="nofollow" target="_blank">TemplateMonster.com</a> <br/> <p style="color: red;"> This website uses Cookies </p>
    </footer>	
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
			var viewsurl = "http://localhost:8082/Project/rest/view/viewsforperson/" + objUser;
			$http.get(viewsurl)
	  	  .success(function(response) 
	  	           {console.log("views");
	  		  console.log(response);
	  		  		$scope.views=response;
	  	           });
			var likesurl = "http://localhost:8082/Project/rest/mapper/getlikes/" + objUser;
			$http.get(likesurl)
		  	  .success(function(response) 
		  			
		  	           {console.log("likes");
		  		  console.log(response);
		  		
		  		  		$scope.likes=response;
		  	           });
			var reviewsurl = "http://localhost:8082/Project/rest/rate/ratesforperson/" + objUser;
			$http.get(reviewsurl)
		  	  .success(function(response) 
		  	           {console.log("reviews");
		  		  console.log(response);
		  		  		$scope.reviews=response;
		  	           });
	  	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
	//	}
		  
		//}    
		}

</script>

</body>
</html>