<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="">
<head>
    <title>Search Cars</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700,300' rel='stylesheet' type='text/css'>
    <script src="js/jquery-1.7.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>
	
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
            <span><h2 style="float:left;"> Welcome <%=user %></h2></span>
       </div>
       <nav>  
         <ul class="menu">
              <li class="current"><a href="/Project/index.jsp" class="home"><img src="images/home.jpg" alt=""></a></li>
              <li><a href="/Project/profile2.jsp">Profile</a></li>
              <li><a href="/Project/makes.jsp">Search</a></li>
              <li><a href="/Project/about.jsp">About Us</a></li>
              <li><a href="/Project/logout.jsp">Logout</a></li>
          </ul>
          <div class="clear"></div>
        </nav>
   </header>
   <!--==============================content================================-->
   <section id="content"><div class="ic">December12, 2014!</div>
      <div class="sub-page">
      	<div class="sub-page-left box-9">
        	<h2 class="p4">Car Makes</h2>
          <div ng-app="" ng-controller="customersController" style="float:left; display:inline-block;"> 
        

<table>
  <tbody>
    <tr ng-repeat="make in makes track by $index" ng-if="$index%3==0" data-ng-click="test()" >
      <td><a href=<%= "\"models.jsp?make="%>{{makes[$index].name}}<%= "\"" %>> {{makes[$index].name}}</a></td>
      <td><a href=<%= "\"models.jsp?make="%>{{makes[$index+1].name}}<%= "\"" %>> {{makes[$index + 1].name}}</a></td>
      <td><a href=<%= "\"models.jsp?make="%>{{makes[$index+2].name}}<%= "\"" %>> {{makes[$index + 2].name}}</a></td>
    </tr>  
  </tbody>
</table>
        </div>
      </div>  
   </section> 
  <!--==============================footer=================================-->
        <footer>
        Website Template designed by <a href="http://www.templatemonster.com/" class="link" rel="nofollow" target="_blank">TemplateMonster.com</a> <br/> <p style="color: red;"> This website uses Cookies </p>
    </footer>	
</div> 
<script> 
   
    
function customersController($scope,$http) {
  $http.get("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep")
  .success(function(response) 
           {$scope.makes = response.makes;});
    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
    
}
    
    
</script> 
 
</body>
</html>