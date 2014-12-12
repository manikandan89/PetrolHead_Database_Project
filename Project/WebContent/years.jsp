<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="">
<head>
    <title>Model Years</title>
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
            <span><h2 style="float:left"> Welcome <%=user %></h2></span>
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
        	<h2 class="p4">Car Model Years</h2>
          <div ng-controller="yearsController" style="float:left; display:inline-block;"> 
        <form>
<input type="hidden" id="tempMake" name="makeUrl" value=<%=request.getParameter("make") %> />
<input type="hidden" id="tempModel" name="modelUrl" value=<%=request.getParameter("model") %> />
</form>

<table>
  <tbody>
    <tr ng-repeat="year in years track by $index" ng-if="$index%3==0">
         <td><a href=<%= "\"details.jsp?make="%><%= request.getParameter("make") %><%="&model="%><%= request.getParameter("model") %><%="&year="%>{{years[$index].year}} <%= "\"" %>> {{years[$index].year}}</a></td>
        <td><a href=<%= "\"details.jsp?make="%><%= request.getParameter("make") %><%="&model="%><%= request.getParameter("model") %><%="&year="%>{{years[$index + 1].year}} <%= "\"" %>> {{years[$index + 1].year}}</a></td>
        <td><a href=<%= "\"details.jsp?make="%><%= request.getParameter("make") %><%="&model="%><%= request.getParameter("model") %><%="&year="%>{{years[$index + 2].year}} <%= "\"" %>> {{years[$index + 2].year}}</a></td> 
 		<!-- <input type="hidden" id="tempYear" name="yearUrl" value= /> -->
 		<!--  <td><a href="#" onclick="window.location.href=getStyleIds({{years[$index].year}});"> {{years[$index].year}}</a></td>
 		  <td><a href="#" onclick="window.location.href=getStyleIds({{years[$index+1].year}});"> {{years[$index+1].year}}</a></td>
 		  <td><a href="#" onclick="window.location.href=getStyleIds({{years[$index+1].year}});"> {{years[$index+2].year}}</a></td> -->
        <%-- <td><a href='<%="details.jsp?styleId="%>"javascript:getStyleIds({{years[$index + 1].year}})"'> {{years[$index + 1].year}}</a></td>
        <td><a href='<%="details.jsp?styleId="%>"javascript:getStyleIds({{years[$index + 2].year}})"'> {{years[$index + 2].year}}</a></td> --%>
 		
    </tr>  
  </tbody>
</table>
        
   </section> 
  <!--==============================footer=================================-->
     <footer>
        Website Template designed by <a href="http://www.templatemonster.com/" class="link" rel="nofollow" target="_blank">TemplateMonster.com</a> <br/> <p style="color: red;"> This website uses Cookies </p>
    </footer>		
</div> 



<script> 
   
    
function yearsController($scope,$http) {
	var url = "https://api.edmunds.com/api/vehicle/v2/make/models?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep";
	console.log("Inside years controller");
	var objMake = $('#tempMake').val();
	var objModel = $('#tempModel').val();
	console.log(objMake);
	console.log(objModel);
	var updatedMake = url.replace("make",objMake);
	var updatedModel = updatedMake.replace("models",objModel);
	console.log(updatedModel);
  $http.get(updatedModel)
  .success(function(response) 
           {$scope.years = response.years;
           console.log(response.years);
           });
/* $scope.getStyleIds=function(){
   	if (true) {
   		console.log("inside follow controller")
   			
   			var url = "http://api.edmunds.com/api/vehicle/v2/make/model/year?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep";
	var objMake = $('#tempMake').val();
	var objModel = $('#tempModel').val();
	//var objYear = $('#tempYear').val();
	var objYear = year;
	console.log(objMake);
	console.log(objModel);
	console.log(objYear);
	var updatedMake = url.replace("make",objMake);
	var updatedModel = updatedMake.replace("model",objModel);
	var updatedYear = updatedModel.replace("year",objYear);
	var arr;
   			
   			var teststyleId = 101353967;
       		var followUrl = "http://localhost:8082/Project/rest/mapper/insertfollow/" + "sara/" + teststyleId;
       		$http.post(followUrl)
         	  .success(function(response) 
         	           {console.log(response)
         		 $scope.following = !Boolean(response);
              	        console.log($scope.following); 
         	  });
   		
   		
     	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
   	}
   	  
   	}  */   
    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
    //"https://api.edmunds.com/api/vehicle/v2/honda/civic?fmt=json&state=new&api_key=6xgkfrk3wmrgreh7qh88cmep"
    //https://api.edmunds.com/api/vehicle/v2/Chevrolet/HHRs?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep
    //https://api.edmunds.com/api/vehicle/v2/honda/civic?fmt=json&state=new&api_key=6xgkfrk3wmrgreh7qh88cmep
}

<%-- function getStyleIds(year)
{
	var url = "http://api.edmunds.com/api/vehicle/v2/make/model/year?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep";
	var objMake = $('#tempMake').val();
	var objModel = $('#tempModel').val();
	//var objYear = $('#tempYear').val();
	alert("in here");
	var objYear = year;
	console.log(objMake);
	console.log(objModel);
	console.log(objYear);
	var updatedMake = url.replace("make",objMake);
	var updatedModel = updatedMake.replace("model",objModel);
	var updatedYear = updatedModel.replace("year",objYear);
	var arr;
	$.getJSON(updatedYear,function somevalue(result) {
		var id = result.id;
		console.log("Alert");
		console.log(id);
		console.log(result.styles.length);
		arr = new Array(result.styles.length);
		for(var i = 0; i < result.styles.length; i++) {
			arr[i]= result.styles[i].id;
			
		}
		console.log("arrrr")
		console.log(arr);
		if(arr!=null && arr.length > 0)
			{
			
		return <%="details.jsp?styleId="%> + arr[0];	
			}
		else
			{
			return "#";
			}
		
		//getData(arr);
	});

	
} --%>
    
    
</script> 
 
</body>
</html>