<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="myapp">
<head>
    <title>Details</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
    <link href="css/bootstrap.css" rel="stylesheet"/>
    <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700,300' rel='stylesheet' type='text/css'>
    <script src="js/jquery-1.7.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
       <script src= "http://ajax.googleapis.com/ajax/libs/angularjs/1.2.26/angular.min.js"></script>

 
	<!--[if lt IE 8]>
       <div style=' clear: both; text-align:center; position: relative;'>
         <a href="http://windows.microsoft.com/en-US/internet-explorer/products/ie/home?ocid=ie6_countdown_bannercode">
           <img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." />
        </a>
      </div>
    <![endif]-->
    <!--[if lt IE 9]>
    	<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300' rel='stylesheet' type='text/css'>
    	<link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700' rel='stylesheet' type='text/css'>
   		<script type="text/javascript" src="js/html5.js"></script>
    	<link rel="stylesheet" type="text/css" media="screen" href="css/ie.css">
	<![endif]-->

       
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
/* Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
    if(cookie.getName().equals("user")) userName = cookie.getValue();
    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
}
} */
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
          	
 <form>
<input type="hidden" id="tempMake" name="makeUrl" value=<%=request.getParameter("make") %> />
<input type="hidden" id="tempModel" name="modelUrl" value=<%=request.getParameter("model") %> />
<input type="hidden" id="tempYear" name="yearUrl" value=<%=request.getParameter("year") %> />
 <!-- <input type="hidden" id="styleidval" name="styleidval" value="" runat="server"/>  -->
</form>
        </nav>
   </header>
   <!--==============================content================================-->
   <section id="content">
      <br/>
      <br/>
     
 <div class="sub-page" id="main">
      
       </div>
       <table class="table">
       <tbody>
       <tr>
       <td>
        
       <div ng-controller="likeController">
       <%-- <form>
		<input type="hidden" id="temp" name="modelUrl" value=<%=request.getParameter("make") %> />
		</form> --%>
      <!--  <button id="likeButton" ng-click="confirmLike()" class="btn btn-success">Like</button> -->
      <!--  <button type="submit" data-ng-show={{likestatus}} data-ng-click="confirmLike()" class="btn btn-default">Like</button>
       <button type="submit" data-ng-show=!{{likestatus}} data-ng-click="confirmLike()" class="btn btn-default">Unlike</button> -->
        <!-- <button type="submit" data-ng-show="!{{likestatus}}" data-ng-click="confirmLike()" class="btn btn-default">Like</button>-->
      <!--  <button type="submit" data-ng-show=!{{likestatus}}  data-ng-click="confirmLike()" class="btn btn-default">Unlike</button> --> 
       
       <button ng-click="goEvent();" ng-show="going">Like</button>
		<button ng-click="goEvent();" ng-hide="going">Unlike</button>
       
       </div>
       
       </td>
       <td>
        <div ng-controller="followController">
       <%-- <form>
		<input type="hidden" id="temp" name="modelUrl" value=<%=request.getParameter("make") %> />
		</form> --%>
		
      <!--  <button id="likeButton" ng-click="confirmFollow()" class="btn btn-success">Follow</button> -->
      
           <button ng-click="goFollow();" ng-show="following">Follow</button>
		<button ng-click="goFollow();" ng-hide="following">UnFollow</button>
       
       </div>
       </td>
       </tr>
       </tbody>
       </table>
       
       <!--  <div ng-controller="detailsController">
       <input type="hidden" id="styleidval" name="styleidval" value="{{style}}" />
       
       
       </div>  -->
       
       <div ng-controller="feedbackController"> 
       <br/>
      <br/>
      
      
        <input id="postid" class="form-control" type="text" value="" ng-model="comments" />
	 <button ng-click="confirmComment(comments)" class="btn btn-success">Post</button>
	   <table class="table">
  <tbody>
    <tr ng-repeat="rate in rates">
      <!-- <td>{{rate.comment}}</td> -->
        <td>
            <span data-ng-hide="editMode">{{rate.comment}}</span>
            <input type="text" data-ng-show="editMode" data-ng-model="rate.comment" data-ng-required />
        </td>
       <!--  <td>{{rate.name}}</td>  --> 
        <td><a href=<%= "\"profile.jsp?navigateuser="%>{{rate.name}}<%= "\"" %>> {{rate.name}}</a></td> 
      
      <td>{{rate.dateString}}</td>
      <td>
            <button type="submit" data-ng-hide="editMode" data-ng-click="editMode = true; editAppKey(rate)" class="btn btn-default">Edit</button>
            <button type="submit" ng-click="editComment(rate)" id="edit" data-ng-show="editMode" data-ng-click="editMode = false" class="btn btn-default">Save</button>
            <button type="submit" data-ng-show="editMode" data-ng-click="editMode = false; cancel()" class="btn btn-default">Cancel</button>
        </td>
    <!--  <td><button id="edit" class="btn btn-md btn-">Edit</button></td> -->
	  <td><button ng-click="deleteComment(rate)" id="delete"  class="btn btn-md btn-danger">Delete</button></td>
	   <!-- <button id="delete" class="btn btn-block btn-info">Delete</button>
	   <button id="delete" class="btn btn-block btn-warning">Delete</button>
	   <button id="delete" class="btn btn-block btn-link">Delete</button> -->
    </tr>  
  </tbody>
</table> 
        </div>
        <br />
        
   </section> 
  <!--==============================footer=================================-->
       <footer>
        Website Template designed by <a href="http://www.templatemonster.com/" class="link" rel="nofollow" target="_blank">TemplateMonster.com</a> <br/> <p style="color: red;"> This website uses Cookies </p>
    </footer>	
</div>

<script type="text/javascript">
/*    var someId = "OldVal";
   changeId();
   function changeId()
   {
	   
	   someId = "I have changed.";
   } */
 
  // $(document).ready(function ready(){
        	
   var app = angular.module('myapp',[]);
            	app.run(function($rootScope) {
            		alert("i'm called first");
            		getStyleIds();
            	}) 		
	  
	  
	  		
    		
         	function getStyleIds()
        	{
         		var styleId=0;
        		var url = "http://api.edmunds.com/api/vehicle/v2/make/model/year?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep";
        		var objMake = $('#tempMake').val();
        		var objModel = $('#tempModel').val();
        		var objYear = $('#tempYear').val();
        		//alert(url);
        		
        		console.log(objMake);
        		console.log(objModel);
        		console.log(objYear);
        		var updatedMake = url.replace("make",objMake);
        		var updatedModel = updatedMake.replace("model",objModel);
        		var updatedYear = updatedModel.replace("year",objYear);
        		var arr;
        		// alert(updatedYear);
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
        				console.log("Printing arr[0] which is the styleId got from get json call")
        				console.log(arr[0]);
        				styleId = arr[0]; 
        				//document.cookie = "styleId=" + styleId;
        				//document.getElementById("styleidval").value=styleId;  stylessssssss
        				//styleId = 101353967  
        				setCookie("styleId",styleId);
        				getData(styleId);	
        				}
        			else
        				{
        				return "#";
        				}
        			
        		});
        	
     
        	}
         	
     
            function getData(styleId)
            {
                lstOfStyleIds =  ['101353967', '3338'];
                console.log(lstOfStyleIds);
                
                 //styleId = 101353967;
               // styleId = $('#tempStyleId').val();
              // alert(styleId);
                    var breakTag = document.createElement("br");
                    var newElement =  document.createElement("div"); 
                    newElement.id = styleId;
                 
                    document.getElementById("main").appendChild(newElement);
                    var imgElement = document.createElement("img");
                    var imgId = "img" + styleId.toString();
                    imgElement.id = imgId;
                    document.getElementById("main").appendChild(imgElement);
                   
                    var pElement = document.createElement("p");
                    var parId = "p" + styleId.toString();
                    pElement.id = parId;
                    document.getElementById("main").appendChild(pElement);
                
                
                   
                    document.getElementById("main").appendChild( document.createElement("br"));
                    var divInfo = document.createElement("div");
                    var divInfoId = "divInfoId";
                divInfo.id = divInfoId;
                     document.getElementById("main").appendChild(divInfo);
                    // Engine
                    var engine = document.createElement("h3");
                    engine.innerHTML = "Engine";
                    var engineId = "engine" + styleId.toString();
                    engine.id = engineId;
                    document.getElementById("divInfoId").appendChild(engine);
                
                    
                    var cylinder = document.createElement("p");
                    cylinder.innerHTML = "<b>Cylinder:</b>";   
                    var cylinderId = "cylinder" + styleId.toString();
                    cylinder.id = cylinderId;
                    document.getElementById("divInfoId").appendChild(cylinder);
                     
                    
                    var displacement = document.createElement("p");
                    displacement.innerHTML = "<b>Displacement:</b>";   
                    var displacementId = "disp" + styleId.toString();
                    displacement.id = displacementId;
                    document.getElementById("divInfoId").appendChild(displacement);
                    
                
                    var fuelType = document.createElement("p");
                    fuelType.innerHTML = "<b>Fuel Type:</b>";
                    var fuelTypeId = "fuelType" + styleId.toString();
                    fuelType.id = fuelTypeId;
                    document.getElementById("divInfoId").appendChild(fuelType);
                
                    var horsePower = document.createElement("p");
                    horsePower.innerHTML = "<b>Horse Power:</b>";
                    var horsePowerId = "horsePower" + styleId.toString();
                    horsePower.id = horsePowerId;
                    document.getElementById("divInfoId").appendChild(horsePower);
                
                    var torque = document.createElement("p");
                    torque.innerHTML = "<b>Torque:</b>";
                    var torqueId = "torque" + styleId.toString();
                    torque.id = torqueId;
                    document.getElementById("divInfoId").appendChild(torque);
                
                
                    var transmission = document.createElement("h3");
                    transmission.innerHTML = "Transmission";
                    var transmissionId = "transmission" + styleId.toString();
                    transmission.id = transmissionId;
                    document.getElementById("divInfoId").appendChild(transmission);
                    
                    var transmissionType = document.createElement("p");
                    transmissionType.innerHTML = "<b>Transmission Type:</b>";
                    var transmissionTypeId = "transmissionType" + styleId.toString();
                    transmissionType.id = transmissionTypeId;
                    document.getElementById("divInfoId").appendChild(transmissionType);
                
                    var numberOfSpeeds = document.createElement("p");
                    numberOfSpeeds.innerHTML = "<b>Number of Speeds:</b>";
                    var numberOfSpeedsId = "numOfSpeeds" + styleId.toString();
                    numberOfSpeeds.id = numberOfSpeedsId;
                    document.getElementById("divInfoId").appendChild(numberOfSpeeds);
                
                    var drivenWheels = document.createElement("p");
                    drivenWheels.innerHTML = "<b>Driven Wheels:</b>";
                    var drivenWheelsId = "drivenWheels" + styleId.toString();
                    drivenWheels.id = drivenWheelsId;
                    document.getElementById("divInfoId").appendChild(drivenWheels);
                    
                    var numOfDoors = document.createElement("p");
                    numOfDoors.innerHTML = "<b>Number of doors:</b>";
                    var numOfDoorsId = "numOfDoors" + styleId.toString();
                    numOfDoors.id = numOfDoorsId;
                    document.getElementById("divInfoId").appendChild(numOfDoors);

                    var mainDiv = document.getElementById(styleId);
                    
                    mainDiv.appendChild(imgElement);
                    mainDiv.appendChild(pElement);
                    
                    mainDiv.appendChild(breakTag);
                  
                   getDetails(styleId, parId, cylinderId, displacementId,fuelTypeId,horsePowerId,torqueId,transmissionTypeId,numberOfSpeedsId,drivenWheelsId,numOfDoorsId);
                   getImage(styleId, imgId);
                   setStyle(imgId, parId);
        
   }
            
            function setStyle(imgId, parId)
            {
             
                   $('#' + imgId).css('float','left','padding','30px');
                
                $("#" + parId).css({
                    float:"left",
                    margin:"10px",
                    fontSize:"x-large",
                    fontWeight:"bold"
                    
                });   
                
                $("#divInfoId").css({
                    
                   fontSize:"large",
                   marginLeft:"55%"
                });
                
            }
            
            function getDetails(styleId,parId,cylinderId,displacementId,fuelTypeId,horsePowerId,torqueId,transmissionTypeId, numberOfSpeedsId,drivenWheelsId,numOfDoorsId)
            {
                         var getDetailsUrl = "https://api.edmunds.com/api/vehicle/v2/styles/styleid?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep&view=full";  
                         var detailsObj = getDetailsUrl.replace("styleid",styleId);
                         console.log(detailsObj);
                      $.getJSON(detailsObj,function(result){
                        
                         var strName = "";
      strName = result.year.year + " " + result.make.name + " " + result.model.name + " ";
         var secondStr = result.name.toString();
         strName.concat(secondStr);
         $("#" + parId).append(strName);
        $("#" + cylinderId).append(result.engine.cylinder);
                          $("#" + displacementId).append(result.engine.displacement);
                          $("#" + fuelTypeId).append(result.engine.fuelType);
                           $("#" + horsePowerId).append(result.engine.horsepower);
                           $("#" + torqueId).append(result.engine.torque);
                 $("#" + transmissionTypeId).append(result.transmission.transmissionType);
            $("#" + numberOfSpeedsId).append(result.transmission.numberOfSpeeds);
                $("#" + drivenWheelsId).append(result.drivenWheels);
                           $("#" + numOfDoorsId).append(result.numOfDoors);
                           
                           var fullUrl = "http://localhost:8082/Project/rest/master";
                           // var urlObj = {"url":"https://api.edmunds.com/api/vehicle/v2/styles/101353967?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep&view=full","username":"sara"}; 
                           var urlObj = {"url":"https://api.edmunds.com/api/vehicle/v2/styles/" + styleId + "?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep&view=full","username":"<%=user%>"};
                           $.ajax({
                       		url : fullUrl ,
                       		type:"post",
                       		data: JSON.stringify(urlObj),
                       		dataType: "json",
                       		contentType: "application/json",
                       		success:function(response) {
                       			//console.log(response);
            
                       		}
                       	});
    });   
                
            }
            
            function getImage(styleId, imgId)
            {
                  $.getJSON("https://api.edmunds.com/v1/api/vehiclephoto/service/findphotosbystyleid?styleId=" +styleId + "&fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep", function(res){
                $.each(res, function(idx, response)
                       {
                        if (response.subType=="exterior" && response.shotTypeAbbreviation=="FQ")
                        {
                              var imgUrl = response.photoSrcs.toString().split(",");
                              var patt = new RegExp("_500.jpg");
                         $.each(imgUrl, function(idx, url){
                            if (patt.test(url))
                            {

                                var fullUrl = "http://media.ed.edmunds-media.com" + url;
                                $("#" + imgId).attr("src",fullUrl); 
                               return false;

                            }
                            else
                            {
                            	
                                $("#" + imgId).attr("alt","image unavailable"); 
                                
                            }
                            
                     });
                        }
                    
                });

             });   
                
                
            }
 
            
     // }); 
  
           /*
           
                loadRecent('101353967','make_model_year', 'firstImg');
              loadRecent('101353967','second_make_model_year', 'secondImg');
              loadRecent('101353967','third_make_model_year', 'thirdImg');
              */
              
       /*   function  detailsController($scope,$http) {
            	  
            	  var url = "http://api.edmunds.com/api/vehicle/v2/make/model/year?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep";
          		var objMake = $('#tempMake').val();
          		var objModel = $('#tempModel').val();
          		var objYear = $('#tempYear').val();
          		//alert(url);
          		
          		console.log(objMake);
          		console.log(objModel);
          		console.log(objYear);
          		var updatedMake = url.replace("make",objMake);
          		var updatedModel = updatedMake.replace("model",objModel);
          		var updatedYear = updatedModel.replace("year",objYear);
          		var detailsId;
          		detailsId =  $http.get(updatedYear)
           	  .success(function(response) 
           	           {
           		  console.log(response);
           		  console.log("Styles");
           		  console.log(response.styles);
           		  console.log(response.styles[0]);
           		  console.log(response.styles[0].id);
           		  //console.log()
           		  		$scope.style=response.styles[0].id;
           		  detailsId = response.styles[0].id;
           		console.log("printing styleId in details controller");
           		document.cookie = "styleId=" + detailsId;
           		alert(document.cookie);
          	  console.log(detailsId);
          	  return detailsId;
           	           }); 
          		console.log("printing styleId in details controller eftr get");
            	  console.log(document.cookie);
              } */
             
             
             /*  var styleId=0;
     		getStyleIds();
     		
          	function getStyleIds()
         	{
         		var url = "http://api.edmunds.com/api/vehicle/v2/make/model/year?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep";
         		var objMake = $('#tempMake').val();
         		var objModel = $('#tempModel').val();
         		var objYear = $('#tempYear').val();
         		//alert(url);
         		
         		console.log(objMake);
         		console.log(objModel);
         		console.log(objYear);
         		var updatedMake = url.replace("make",objMake);
         		var updatedModel = updatedMake.replace("model",objModel);
         		var updatedYear = updatedModel.replace("year",objYear);
         		var arr;
         		// alert(updatedYear);
         	//	styleId = 101353967;
         	//var styleIdValue = 0;
         		/* $.getJSON(updatedYear,function somevalue(result) {
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
         				console.log(arr[0]);
         				styleId = arr[0]; 
         				//document.getElementById("styleidval").value=styleId;  stylessssssss
         				//styleId = 101353967 
         				 //styleId = styleIdValue; 
         				getData();	
         				}
         			else
         				{
         				return "#";
         				} 
         			
         			
         			
         		}); */
         	
         		/*$.ajax({
     				url : updatedYear ,
     				type:"get",
     				dataType: "json",
     				contentType: "application/json",
     				success:function(response) {
     					console.log(response);
     					//var id = result.id;
             			console.log("Alert");
             			//console.log(id);
             			console.log(response.styles.length);
             			arr = new Array(response.styles.length);
             			for(var i = 0; i < response.styles.length; i++) {
             				arr[i]= response.styles[i].id;
             				
             			}
             			console.log("arrrr")
             			console.log(arr);
             			if(arr!=null && arr.length > 0)
             				{
             				console.log(arr[0]);
             				styleId = arr[0]; 
             			
             				  //stylessssssss
             				//styleId = 101353967; 
             				 //styleId = styleIdValue; 
             				getData();	
             				}
             			else
             				{
             				return "#";
             				}
     				}
     			});
         /*	}
          	
      
             function getData()
             {
                 lstOfStyleIds =  ['101353967', '3338'];
                 console.log(lstOfStyleIds);
               		// styleId = "101353967";
               		document.getElementById("styleidval").value=styleId;
                     var breakTag = document.createElement("br");
                     var newElement =  document.createElement("div"); 
                     newElement.id = styleId;
                  
                     document.getElementById("main").appendChild(newElement);
                     var imgElement = document.createElement("img");
                     var imgId = "img" + styleId.toString();
                     imgElement.id = imgId;
                     document.getElementById("main").appendChild(imgElement);
               
                    
                     var pElement = document.createElement("p");
                     var parId = "p" + styleId.toString();
                     pElement.id = parId;
                     document.getElementById("main").appendChild(pElement);
                 
                 
                    
                     document.getElementById("main").appendChild( document.createElement("br"));
                     var divInfo = document.createElement("div");
                     var divInfoId = "divInfoId";
                 divInfo.id = divInfoId;
                      document.getElementById("main").appendChild(divInfo);
                     // Engine
                     var engine = document.createElement("h3");
                     engine.innerHTML = "Engine";
                     var engineId = "engine" + styleId.toString();
                     engine.id = engineId;
                     document.getElementById("divInfoId").appendChild(engine);
                 
                     
                     var cylinder = document.createElement("p");
                     cylinder.innerHTML = "<b>Cylinder:</b>";   
                     var cylinderId = "cylinder" + styleId.toString();
                     cylinder.id = cylinderId;
                     document.getElementById("divInfoId").appendChild(cylinder);
                      
                     
                     var displacement = document.createElement("p");
                     displacement.innerHTML = "<b>Displacement:</b>";   
                     var displacementId = "disp" + styleId.toString();
                     displacement.id = displacementId;
                     document.getElementById("divInfoId").appendChild(displacement);
                     
                 
                     var fuelType = document.createElement("p");
                     fuelType.innerHTML = "<b>Fuel Type:</b>";
                     var fuelTypeId = "fuelType" + styleId.toString();
                     fuelType.id = fuelTypeId;
                     document.getElementById("divInfoId").appendChild(fuelType);
                 
                     var horsePower = document.createElement("p");
                     horsePower.innerHTML = "<b>Horse Power:</b>";
                     var horsePowerId = "horsePower" + styleId.toString();
                     horsePower.id = horsePowerId;
                     document.getElementById("divInfoId").appendChild(horsePower);
                 
                     var torque = document.createElement("p");
                     torque.innerHTML = "<b>Torque:</b>";
                     var torqueId = "torque" + styleId.toString();
                     torque.id = torqueId;
                     document.getElementById("divInfoId").appendChild(torque);
                 
                 
                     var transmission = document.createElement("h3");
                     transmission.innerHTML = "Transmission";
                     var transmissionId = "transmission" + styleId.toString();
                     transmission.id = transmissionId;
                     document.getElementById("divInfoId").appendChild(transmission);
                     
                     var transmissionType = document.createElement("p");
                     transmissionType.innerHTML = "<b>Transmission Type:</b>";
                     var transmissionTypeId = "transmissionType" + styleId.toString();
                     transmissionType.id = transmissionTypeId;
                     document.getElementById("divInfoId").appendChild(transmissionType);
                 
                     var numberOfSpeeds = document.createElement("p");
                     numberOfSpeeds.innerHTML = "<b>Number of Speeds:</b>";
                     var numberOfSpeedsId = "numOfSpeeds" + styleId.toString();
                     numberOfSpeeds.id = numberOfSpeedsId;
                     document.getElementById("divInfoId").appendChild(numberOfSpeeds);
                 
                     var drivenWheels = document.createElement("p");
                     drivenWheels.innerHTML = "<b>Driven Wheels:</b>";
                     var drivenWheelsId = "drivenWheels" + styleId.toString();
                     drivenWheels.id = drivenWheelsId;
                     document.getElementById("divInfoId").appendChild(drivenWheels);
                     
                     var numOfDoors = document.createElement("p");
                     numOfDoors.innerHTML = "<b>Number of doors:</b>";
                     var numOfDoorsId = "numOfDoors" + styleId.toString();
                     numOfDoors.id = numOfDoorsId;
                     document.getElementById("divInfoId").appendChild(numOfDoors);

                     var mainDiv = document.getElementById(styleId);
                     
                     mainDiv.appendChild(imgElement);
                     mainDiv.appendChild(pElement);
                     
                     mainDiv.appendChild(breakTag);
                   
                    getDetails(styleId, parId, cylinderId, displacementId,fuelTypeId,horsePowerId,torqueId,transmissionTypeId,numberOfSpeedsId,drivenWheelsId,numOfDoorsId);
                    getImage(styleId, imgId);
                    setStyle(imgId, parId);
         
    }
             
             function setStyle(imgId, parId)
             {
              
                    $('#' + imgId).css('float','left','padding','30px');
                 
                 $("#" + parId).css({
                     float:"left",
                     margin:"10px",
                     fontSize:"x-large",
                     fontWeight:"bold"
                     
                 });   
                 
                 $("#divInfoId").css({
                     
                    fontSize:"large",
                    marginLeft:"55%"
                 });
                 
             }
             
             function getDetails(styleId,parId,cylinderId,displacementId,fuelTypeId,horsePowerId,torqueId,transmissionTypeId, numberOfSpeedsId,drivenWheelsId,numOfDoorsId)
             {
                          var getDetailsUrl = "https://api.edmunds.com/api/vehicle/v2/styles/styleid?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep&view=full";  
                          var detailsObj = getDetailsUrl.replace("styleid",styleId);
                          console.log(detailsObj);
                       $.getJSON(detailsObj,function(result){
                         
                          var strName = "";
       strName = result.year.year + " " + result.make.name + " " + result.model.name + " ";
          var secondStr = result.name.toString();
          strName.concat(secondStr);
          $("#" + parId).append(strName);
         $("#" + cylinderId).append(result.engine.cylinder);
                           $("#" + displacementId).append(result.engine.displacement);
                           $("#" + fuelTypeId).append(result.engine.fuelType);
                            $("#" + horsePowerId).append(result.engine.horsepower);
                            $("#" + torqueId).append(result.engine.torque);
                  $("#" + transmissionTypeId).append(result.transmission.transmissionType);
             $("#" + numberOfSpeedsId).append(result.transmission.numberOfSpeeds);
                 $("#" + drivenWheelsId).append(result.drivenWheels);
                            $("#" + numOfDoorsId).append(result.numOfDoors);
                            
                            var fullUrl = "http://localhost:8082/Project/rest/master";
                            // var urlObj = {"url":"https://api.edmunds.com/api/vehicle/v2/styles/101353967?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep&view=full","username":"sara"}; 
                            var urlObj = {"url":"https://api.edmunds.com/api/vehicle/v2/styles/" + styleId + "?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep&view=full","username":"sara"};
                            $.ajax({
                        		url : fullUrl ,
                        		type:"post",
                        		data: JSON.stringify(urlObj),
                        		dataType: "json",
                        		contentType: "application/json",
                        		success:function(response) {
                        			//console.log(response);
             
                        		}
                        	});
     });   
                 
             }
             
             function getImage(styleId, imgId)
             {
            	 
                   $.getJSON("https://api.edmunds.com/v1/api/vehiclephoto/service/findphotosbystyleid?styleId=" +styleId + "&fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep", function(res){
                 $.each(res, function(idx, response)
                        {
                         if (response.subType=="exterior" && response.shotTypeAbbreviation=="FQ")
                         {
                               var imgUrl = response.photoSrcs.toString().split(",");
                               var patt = new RegExp("_500.jpg");
                          $.each(imgUrl, function(idx, url){
                             if (patt.test(url))
                             {

                                 var fullUrl = "http://media.ed.edmunds-media.com" + url;
                                 $("#" + imgId).attr("src",fullUrl); 
                                return false;

                             }
                             else
                             {
                             	
                                 $("#" + imgId).attr("alt","image unavailable"); 
                                 
                             }
                             
                      });
                         }
                     
                 });

              });   
                 
                 
             } */
  
             function getStyleId()
             {
            	 var styleId = getCookie("styleId");
            	 return styleId;
             }
             
             function getCookie(cname) {
            	    var name = cname + "=";
            	    var ca = document.cookie.split(';');
            	    for(var i=0; i<ca.length; i++) {
            	        var c = ca[i];
            	        while (c.charAt(0)==' ') c = c.substring(1);
            	        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
            	    }
            	    return "";
            	}

            	function setCookie(cname, cvalue) {
            	    
            	    document.cookie = cname + "=" + cvalue;
            	}

            	
      
         function feedbackController($scope,$http) {
         	//alert($window.styleId);
           //var styleId = document.getElementById("styleidval").value;
           alert("printing styleid in angular");
           //alert(styleId);
         	//var styleId = 101353967;
         	//alert(document.cookie);
         	
         	var styleId = getStyleId();
         	
         	
         	alert(styleId);
         	console.log("In feedback controller.. printing styleId");
         	console.log(styleId);
        	 var allCommentsUrl = "http://localhost:8082/Project/rest/rate/ratesforstyle/" + styleId;
        	 console.log(allCommentsUrl);
        	  $http.get(allCommentsUrl)
        	  .success(function(response) 
        	           {
        		  console.log(response)
        		  		$scope.rates=response;
        	           }); 
        	$scope.confirmComment=function(){
        	if ($scope.comments != null) {
        		console.log("inside")
        		//alert(styleId);
        		var rating = new Object();
        		rating.comment=$scope.comments;
        		rating.styleId=getStyleId();
        		rating.rate=3;
        		rating.name="<%=user%>";
        		alert(rating.styleId);
        		var url = "http://localhost:8082/Project/rest/rate/" + "<%=user%>";
        		var x = document.getElementById("postid");
        		x.value = "";
        		$http.post(url,JSON.stringify(rating))
          	  .success(function(response) 
          	           {console.log(response)
          		  		$scope.rates=response;
          	           });
          	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
        	}
        	  
        	}   
        	$scope.deleteComment=function(rate){
            	if (rate != null) {
            		console.log("inside delete comment in details page");
            		var rating = new Object();
            		rating.comment=rate.comment;
            		rating.styleId=getStyleId();
            		rating.name="<%=user%>";
            		var deleteurl = "http://localhost:8082/Project/rest/rate/deletecomment";
            		$http.post(deleteurl,JSON.stringify(rating))
              	  .success(function(response) 
              	           {console.log(response)
              		  		$scope.rates=response;
              	           });
              	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
            	}
            	  
            	} 
        	
        	$scope.editComment=function(rate){
            	if (rate != null) {
            		console.log("inside edit comment in details page");
            		var rating = new Object();
            		rating.comment=rate.comment;
            		rating.styleId=getStyleId();
            		rating.name="<%=user%>";
            		var deleteurl = "http://localhost:8082/Project/rest/rate/editcomment";
            		$http.put(deleteurl,JSON.stringify(rating))
              	  .success(function(response) 
              	           {console.log(response)
              		  		$scope.rates=response;
              	           });
              	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
            	}
            	  
            	} 

        	
            var tmpDate = new Date();
            
            $scope.newField = {};
            $scope.editing = false;
      
      $scope.editAppKey = function(field) {
          $scope.editing = $scope.rates.indexOf(field);
          $scope.newField = angular.copy(field);
      }
      
      $scope.saveField = function(index) {
          if ($scope.editing !== false) {
              $scope.rates[$scope.editing] = $scope.newField;
              $scope.editing = false;
          }       
      };
      
      $scope.cancel = function(index) {
          if ($scope.editing !== false) {
              $scope.rates[$scope.editing] = $scope.newField;
              $scope.editing = false;
          }       
      };
      
  }
        	
        	
         
         function likeController($scope,$http) {
        		alert("i'm called second");
        	 //$scope.likestatus = true;
        	// var styleId = document.getElementById("styleidval").value;
        	console.log("In like controller");
        	var user = "<%=user%>";
        	var styleId = getStyleId();
        	var likeUrl = "http://localhost:8082/Project/rest/mapper/getlikeforcarforthisperson/" + user + "/" + styleId;
        	 $http.get(likeUrl)
          	  .success(function(response) 
          	           {console.log(response)
          		  	if(response == "false") {
          		  	console.log("got false response");
          		  	$scope.going = !Boolean(response);
       	           console.log($scope.going);
          		  	} else {
          		  		console.log("got true response");
          		  	$scope.going = !!(response);
        	           console.log($scope.going);
          		  	}
          		  		
          	           });
         	$scope.goEvent=function(){
         	if (true) {
         		console.log("inside like controller")
         		 if($scope.going){  
         			var styleId = getStyleId();;
             		var likeUrl = "http://localhost:8082/Project/rest/mapper/insertlike/" + "<%=user%>" + "/" + styleId;
             		$http.post(likeUrl)
               	  .success(function(response) 
               	           {console.log(response)
               		$scope.going = !Boolean(response);
               	        console.log($scope.going);  
               	           });
         		   }else{
         			  var styleId = getStyleId();
               		var unlikeUrl = "http://localhost:8082/Project/rest/mapper/insertunlike/" + "<%=user%>" + "/" + styleId;
               		$http.post(unlikeUrl)
                 	  .success(function(response) 
                 	           {console.log(response)
                 		$scope.going = Boolean(response);
                 	        console.log($scope.going);  
                 	           });
         		   } 
         		/* var rating = new Object();
         		rating.comment=$scope.comments;
         		rating.styleId=101353967;
         		rating.rate=3;
         		rating.name="sara"; */
         		
           	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
         	}
         	  
         	}    
         	}  
         
         
   /*       
         function followController($scope,$http) {
          	$scope.confirmFollow=function(){
          	if (true) {
          		console.log("inside follow controller")
          		
          		var teststyleId = 101353967;
          		var followUrl = "http://localhost:8082/Project/rest/mapper/insertfollow/" + "sara/" + teststyleId;
          		$http.post(followUrl)
            	  .success(function(response) 
            	           {console.log(response)
            	           });
            	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
          	}
          	  
          	}    
          	}  */ 
        	

         function followController($scope,$http) {
          		//var styleId = document.getElementById("styleidval").value;
          		var user = "<%=user%>";
            	var styleId = getStyleId();
            	var followUrl = "http://localhost:8082/Project/rest/mapper/getfollowforcarforthisperson/" + user + "/" + styleId;
            	 $http.get(followUrl)
              	  .success(function(response) 
              	           {console.log(response)
              		  	if(response == "false") {
              		  	console.log("got false response");
              		  	$scope.following = !Boolean(response);
           	           console.log($scope.following);
              		  	} else {
              		  		console.log("got true response");
              		  	$scope.following = !!(response);
            	           console.log($scope.following);
              		  	}
              		  		
              	           });
           	$scope.goFollow=function(){
           	if (true) {
           		console.log("inside follow controller")
           		if ($scope.following) {
           			var styleId = getStyleId();
               		var followUrl = "http://localhost:8082/Project/rest/mapper/insertfollow/" + "<%=user%>" + "/" + styleId;
               		$http.post(followUrl)
                 	  .success(function(response) 
                 	           {console.log(response)
                 		 $scope.following = !Boolean(response);
                      	        console.log($scope.following); 
                 	  });
           		} else {
           			
           			var styleId = getStyleId();
               		var unfollowUrl = "http://localhost:8082/Project/rest/mapper/insertunfollow/" + "<%=user%>" + "/" + styleId;
               		$http.post(unfollowUrl)
                 	  .success(function(response) 
                 	           {console.log(response)
                 		 $scope.following = Boolean(response);
                    	        console.log($scope.following);  
                 	           });
           		}
           		
             	    //     https://api.edmunds.com/api/vehicle/v2/{make}/models?fmt=json&api_key={api key}
           	}
           	  
           	}    
           	} 
         
       


    </script>

</body>
</html>