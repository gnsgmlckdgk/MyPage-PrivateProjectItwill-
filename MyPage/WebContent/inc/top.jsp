<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 세션 값 가져오기
String id = (String) session.getAttribute("id");
String name = (String) session.getAttribute("name");
%>

<!-- 헤더들어가는 곳 -->
<header>
<%
if(id != null) {	// 로그인 한 상태
	%>
	<div id="login"><a href="../member/info.jsp"><%=name %> 님</a> | <a href="../member/logout.jsp">LOGOUT</a></div>	<!-- 링크 회원정보, 로그아웃 jsp 이동 -->
	<%
}else {	// 로그인 안한 상태
	%>
	<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/terms.jsp">join</a></div>
	<%
}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp" ><img src="../images/logo.gif" width="265" height="62" alt="Fun Web"></a></div>
<!-- 로고들어가는 곳 -->

<!-- 메뉴 들어가는 곳 -->
<nav id="top_menu">
	<ul>
		<li><a href="../main/main.jsp">HOME</a></li>
		<li><a href="#">COMPANY</a>
			<ul>
				<li><a href="../company/welcome.jsp">FunWeb 소개</a></li>
				<li><a href="../company/map.jsp">FunWeb 위치</a></li>
				<li><a href="#">FunWeb 소식</a></li>
			</ul>
		</li>
		<li><a href="#">SOLUTIONS</a></li>
		<li><a href="#">CUSTOMER CENTER</a>
			<ul>
				<li><a href="../center/notice.jsp">공지게시판</a></li>
				<li><a href="../center/board.jsp">자유게시판</a></li>
				<li><a href="../center/imageBoard.jsp">이미지게시판</a></li>
			</ul>
		</li>
		
		<li><a href="#">CONTACT US</a></li>
	</ul>
</nav>
<!-- 메뉴 들어가는 곳 -->

</header>
<!-- 헤더들어가는 곳 -->