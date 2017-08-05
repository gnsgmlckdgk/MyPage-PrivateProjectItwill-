<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Login</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<link href="../css/member.css?ver=13" rel="stylesheet" type="text/css">

<style type="text/css">
/* 입력 폼에 있는 테이블 */
.input_table {
	width: 600px;
	padding-left: 100px;
}

.input_table tr {
	height: 30px;
	
}

.input_table td {
	width: 80px;
	font-weight: bold;
}

.input_table td input {
	width: 250px;
	height: 20px;
	font-size: 14px;
}
</style>

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
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="terms.jsp">회원가입</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Login</h1>
<form action="loginPro.jsp" id="join" method="post" name="fr">
<fieldset>

<legend>Login Info</legend>
<table class="input_table">
<tr>
	<td>아이디: </td> <td><input type="text" name="id" placeholder="ID입력"></td>
</tr>
<tr>
	<td>비밀번호: </td> <td><input type="password" name="pass" placeholder="password입력"></td>
</tr>
</table>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="로그인" class="submit">
</div>

</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>