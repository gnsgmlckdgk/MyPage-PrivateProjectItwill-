<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Join</title>
<link href="../css/default.css?ver=17" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=14" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<link href="../css/member.css?ver=15" rel="stylesheet" type="text/css">

<style type="text/css">

#terms_div {
	padding: 30px 60px 30px 60px;
	width: 500px;
	border: 1px solid #d0d0d0;
}

iframe {
	border: 1px solid #bbbbbb;
	background-color: #f0f0f0;
	width: 500px;
	height: 100px;
}

.lb_div {
	margin-bottom: 20px;
}

.lb {
	font-size: 1.5em;
	font-weight: bold;
}
.lb2 {
	color: #00aa00;
	font-size: 1.2em;
}

input[type=checkbox] {
	float: right;
	width: 20px;
	height: 20px;
}

/* 버튼 */
.next, .back {
	height: 30px; width: 150px; border: 1px solid #666;
	border-radius:10px; box-shadow:3px 3px 2px #CCC;
	font-size: 14px;
}

#buttons .next {
	background-image: url("../images/member/submit_back.jpg");
	background-repeat: repeat-x;
	background-position: center center;
	color: #fff;
}

#buttons .back {
	margin: 0 0 0 20px;
	background-image: url("../images/member/cancel_back.jpg");
	background-repeat: repeat-x;
	background-position: center center;
	color: #fff;
}

</style>

<script type="text/javascript">

	function check() {
		
		var terms = document.getElementsByName("terms1");
		
		if(terms[0].checked && terms[1].checked) {
			location.href="join.jsp";
		}else {
			alert("이용약관과 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.");
		}
		
	}

</script>

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
<h1>약관동의</h1>
<div id="terms_div">
	<!-- 약관 -->
	<div class="lb_div">
	<span class="lb">FunWeb 이용약관 동의</span><span class="lb2">(필수)</span>
	<input type="checkbox" name="terms1">
	<iframe src="이용약관 모음/term1.html"></iframe>
	</div>
	
	<div class="lb_div">
	<span class="lb">개인정보 수집 및 이용에 대한 안내</span><span class="lb2">(필수)</span>
	<input type="checkbox" name="terms1">
	<iframe src="이용약관 모음/term2.html"></iframe>
	</div>
	
	<div class="lb_div">
	<span class="lb">위치정보 이용약관 동의</span><span class="lb2">(선택)</span>
	<input type="checkbox" name="terms2"> 
	<iframe src="이용약관 모음/term3.html"></iframe>
	</div>
	
	<div class="lb_div">
	<span class="lb">이벤트 및 프로모션 알림 메일 수신</span><span class="lb2">(선택)</span>
	<input type="checkbox" name="terms2"> 
	<iframe src="이용약관 모음/term4.html"></iframe>
	</div>
	
	<div id="buttons">
	<input type="button" value="다음단계" class="next" onclick="check()">
	<input type="button" value="취소" class="back" onclick="location.href='../main/main.jsp'">
	</div>
	
	</div>
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