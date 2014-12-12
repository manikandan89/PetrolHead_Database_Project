<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>Petrolhead Home</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" media="screen" href="css/reset.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/style.css">
    <link rel="stylesheet" type="text/css" media="screen" href="css/slider.css">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:700,300' rel='stylesheet' type='text/css'>
   
    <script src="js/jquery-1.7.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/tms-0.4.1.js"></script>
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
	
	<script type="text/javascript">
        $(document).ready(function(){
    function loadRecent(styleId, strId, imageId)
            {
     $.getJSON("https://api.edmunds.com/api/vehicle/v2/styles/" + styleId + "?fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep",function(result){
     var strName = result.year.year + " " + result.make.name + " " + result.model.name + " ";
         var secondStr = result.name.toString();
         strName.concat(secondStr);
         $("." + strId).append(strName);
         $.getJSON("https://api.edmunds.com/v1/api/vehiclephoto/service/findphotosbystyleid?styleId=3883&fmt=json&api_key=6xgkfrk3wmrgreh7qh88cmep", function(res){
             var imgUrl = res[0].photoSrcs.toString().split(",");
             var patt = new RegExp("185.jpg");
             $.each(imgUrl, function(idx, url){
                 if (patt.test(url))
                 {
                     var fullUrl = "http://media.ed.edmunds-media.com" + url;
                  
                    document.getElementById(imageId).setAttribute("src", fullUrl);  
                 }
             });
                    
           
            // document.getElementById("firstImg").setAttribute("src",res.
         });
    });
 
        }
           
                loadRecent('101353967','make_model_year', 'firstImg');
              loadRecent('101353967','second_make_model_year', 'secondImg');
              loadRecent('101353967','third_make_model_year', 'thirdImg');
            
             });

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
   <div id="slider">
       <div class="slider-block">
          <div class="slider">
              <ul class="items">
                  <li><img src="images/slide-1.jpg" alt="" /><div class="banner"><div><span>Lambhorghini Aventador</span><p>The Lamborghini Aventador is a mid-engined sports car produced by the Italian manufacturer Automobili Lamborghini.
					</p><a href="http://en.wikipedia.org/wiki/Lamborghini_Aventador" target=_blank class="button">Read More</a></div></div></li>
                  <li><img src="images/slide-2.jpg" alt="" /><div class="banner"><div><span>Maserati GT</span><p>The Maserati GranTurismo is a two-door, four-seat coupé produced by the Italian car manufacturer Maserati. It shares the platform of the Maserati Quattroporte V and parts of the Ferrari 599 GTB and Scaglietti.</p><a href="http://en.wikipedia.org/wiki/Maserati_GranTurismo" target=_blank class="button">Read More</a></div></div></li>
                  <li><img src="images/slide-3.jpg" alt="" /><div class="banner"><div><span>Honda HSC</span><p>The Honda HSC (Honda Sports Concept) is a concept sports car that was initially unveiled at the 2003 Tokyo Motor Show.</p><a href="http://en.wikipedia.org/wiki/Honda_HSC" target=_blank class="button">Read More</a></div></div></li>
              </ul>
          </div>
          <a href="#" class="prev"></a>
          <a href="#" class="next"></a>
        </div>
    </div>
   <!--==============================content================================-->
   <section id="content"><div class="ic">Trending Cars. November12, 2012!</div>
       <div class="block-1 box-1">

        <div id="firstRecent">
            <img id="firstImg" src="" alt="">
            <span class="text-1 make_model_year" style="float:left;"></span>
            
             <a href="#" class="button" >Read More</a>
        </div>
       
        <div id="secondRecent">
            <img id="secondImg" src="" alt="">
            <span class="text-1 second_make_model_year" style="float:left;"></span>
            
             <a href="#" class="button" >Read More</a>

        </div>
        
        <div id="thirdRecent">
           <img id="thirdImg" src="" alt="">
            <span class="text-1 third_make_model_year" style="float:left;"></span>
            
             <a href="#" class="button" >Read More</a>

        </div>
      </div>
      </div>  
   </section> 
  <!--==============================footer=================================-->
      <footer>
        Website Template designed by <a href="http://www.templatemonster.com/" class="link" rel="nofollow" target="_blank">TemplateMonster.com</a> <br/> <p style="color: red;"> This website uses Cookies </p>
    </footer>	
</div> 
</body>
</html>