<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Notice</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<link href="../css/content_board_notice.css?ver=14" rel="stylesheet" type="text/css">

<style type="text/css">
.btn_div {
	margin-right: 120px;
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
<%
// 세션값 가져오기
String id = (String)session.getAttribute("id");
if(id==null) {
	response.sendRedirect("notice.jsp");
}
String name = (String)session.getAttribute("name");

%>

<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="notice.jsp">공지</a></li>
<li><a href="board.jsp">자유게시판</a></li>
<li><a href="imageBoard.jsp">이미지게시판</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 공지작성 폼 -->
<article>
<h1>공지글 작성</h1>

<form action="writeNoticePro.jsp" method="post" name="fr" enctype = "multipart/form-data" >
	<table>
		<tr>
			<th>제목</th><td><input type="text" name="subject" ></td>
		</tr>
		<tr>
			<th>작성자</th><td><input type="text" name="name" value="<%=name %>" readonly="readonly"></td>
		</tr>
		<tr>
			<th>파일첨부</th><td><input type="file" name="file" ></td>
		</tr>
		<tr><td colspan="2"><textarea rows="20" cols="70" name = "content"></textarea></td></tr>
	</table>
<div class="btn_div">
<input type="submit" value="완료" class="btn blueBtn">
<input type="reset" value="다시쓰기" class="btn redBtn">
<input type="button" value="목록으로" class="btn greenBtn" onclick="history.back()">
</div>
</form>

</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>