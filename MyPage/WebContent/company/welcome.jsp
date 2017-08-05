<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Welcome</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
</head>
<body>
<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="welcome.jsp">FunWeb 소개</a></li>
<li><a href="map.jsp">FunWeb 위치</a></li>
<li><a href="#">FunWeb 소식</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Welcome</h1>
<figure class="ceo"><img src="../images/company/CEO.jpg" width="196" height="226" 
alt="CEO"><figcaption>Fun Web CEO Michael</figcaption>
</figure>
<p>Lorem ipsum ipsum dolor...
tellus Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus
Lorem ipsum ipsum dolor...tellus</p>
</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



