<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>Basic Details</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
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
	
		   <form>
            <input type="hidden" id="tempMake" name="makeUrl" value=<%=request.getParameter("make") %> />
            <input type="hidden" id="tempModel" name="modelUrl" value=<%=request.getParameter("model") %> />
            <input type="hidden" id="tempYear" name="yearUrl" value=<%=request.getParameter("year") %> />
            </form>
       <script type="text/javascript">
        $(document).ready(function(){

            function getData(lstOfStyleIds)
            {
                //lstOfStyleIds =  ['101353967', '3338'];
                //console.log(lstOfStyleIds);
                alert(lstOfStyleIds);
                
                for (var i=0; i<lstOfStyleIds.length; i++)
                {
                    var breakTag = document.createElement("br");
                    var newElement =  document.createElement("div"); 
                    newElement.id = lstOfStyleIds[i];
                 
                    document.getElementById("main").appendChild(newElement);
                    var imgElement = document.createElement("img");
                    var imgId = "img" + lstOfStyleIds[i].toString();
                    imgElement.id = imgId;
                    var pElement = document.createElement("p");
                    var parId = "p" + lstOfStyleIds[i].toString();
                    pElement.id = parId;
                    var mainDiv = document.getElementById(lstOfStyleIds[i]);
                    
                    mainDiv.appendChild(imgElement);
                    mainDiv.appendChild(pElement);
                    
             mainDiv.appendChild(breakTag);
                   var currStyleId = lstOfStyleIds[i];
                   getName(currStyleId, parId);
                    getImage(currStyleId, imgId);
                    
                        
         /*
                
          */
       }
        
   }
            
            function getName(styleId,parId)
            {
                
                           
                      $.getJSON("https://api.edmunds.com/api/vehicle/v2/styles/" + styleId + "?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep",function(result){
                         var strName = "";
      strName = result.year.year + " " + result.make.name + " " + result.model.name + " ";
         var secondStr = result.name.toString();
         strName.concat(secondStr);
         $("#" + parId).append(strName);

    });   
                
            }
            
         
            
            function getStyleIds()
            {
            	var url = "http://api.edmunds.com/api/vehicle/v2/make/model/year?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep";
            	var objMake = $('#tempMake').val();
            	var objModel = $('#tempModel').val();
            	var objYear = $('#tempYear').val();
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
            		return arr[0];	
            			}
            		else
            			{
            			return -1;
            			}
            		
            		//getData(arr);
            	});
            
            	
            }
            
            function getImage(styleId, imgId)
            {
            	console.log("Inside get image");
            	console.log(styleId);
            	alert("https://api.edmunds.com/v1/api/vehiclephoto/service/findphotosbystyleid?styleId=" +styleId + "&fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep");
                  $.getJSON("https://api.edmunds.com/v1/api/vehiclephoto/service/findphotosbystyleid?styleId=" +styleId + "&fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep", function(res){
                $.each(res, function(idx, response)
                       {
                        if (response.subType=="exterior" && response.shotTypeAbbreviation=="FQ")
                        {
                              var imgUrl = response.photoSrcs.toString().split(",");
                              var patt = new RegExp("oem_1_185.jpg");
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
 			/* var ids = [];
            ids = somevalue();
            console.log("idss")
            console.log(ids); */
            
            getStyleIds();
           /*
           
                loadRecent('101353967','make_model_year', 'firstImg');
              loadRecent('101353967','second_make_model_year', 'secondImg');
              loadRecent('101353967','third_make_model_year', 'thirdImg');
              */
            
             });

    </script>
</head>
<body>
<div class="bg">
   <header>
       <div class="main wrap">
       		<h1><a href="index.html"><img src="images/logo.png" alt=""></a></h1> 
            <p>8901 Marmora, Glasgow <span>8 (800) 552 5975</span></p>
       </div>
       <nav>  
          <ul class="menu">
              <li><a href="index.html" class="home"><img src="images/home.jpg" alt=""></a></li>
              <li><a href="about.html">About</a></li>
              <li><a href="maintenance.html">Maintenance</a></li>
              <li><a href="repair.html">Repair</a></li>
              <li class="current"><a href="price-list.html">Car Makes</a></li>
              <li><a href="locations.html">Locations</a></li>
          </ul>
          <div class="clear"></div>
        </nav>
   </header>
   <!--==============================content================================-->
   <section id="content">
      
 <div class="sub-page" id="main">
      <br/>
       </div>
   </section> 
  <!--==============================footer=================================-->
    <footer>
        
    </footer>	
</div> 
 
</body>
</html>