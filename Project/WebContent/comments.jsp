<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Comments</title>
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


<div ng-app="" ng-controller="commentController" class="container"> 
        
<table class="table">
  <tbody>
    <tr ng-repeat="rate in rates" >
      <td>{{rate.comment}}</td>
      <td><button ng-click="deleteComment(rate)" id="delete" class="btn btn-md btn-danger">Delete</button></td>
    </tr>  
  </tbody>
</table>
  </div>
  
  <form>
<input type="hidden" id="temp" name="userfromadminjsp" value=<%=request.getParameter("user") %> />
</form>

<script>
  
  function commentController($scope,$http) {
	  var obj = $('#temp').val();
		console.log(obj);
		var commentsurl = "http://localhost:8082/Project/rest/person/getallcommentsforuser/" + obj;
	  $http.get(commentsurl)
	  .success(function(response) 
	           {console.log(response)
		  		$scope.rates=response;
	           });
  	$scope.deleteComment = function(rate){
  	if (rate != null) {
  		console.log("commentController");
  		console.log(rate.comment);
  	/* 	var rating = new Object();
  		rating.comment=$scope.comments;
  		rating.styleId=101353967;
  		rating.rate=3;
  		rating.name="sara"; */
  		var url = "http://localhost:8082/Project/rest/person/deletecomment/" + obj + "/" + rate.comment;
  		$http.delete(url)
    	  .success(function(response) 
    	           {console.log(response)
    		  		$scope.rates=response;
    	           });
    	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
  	}
  	  
  	}    
  	}  
  </script>
</body>
</html>