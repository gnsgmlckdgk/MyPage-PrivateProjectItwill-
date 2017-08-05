<%@page import="notice.NoticeBean"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

</head>
<body>
	<!-- 회원정보 출력 -->
	<div id="wrap">
		<!-- 헤더들어가는 곳 -->
		<jsp:include page="../inc/top.jsp" />
		<!-- 헤더들어가는 곳 -->

		<!-- 본문들어가는 곳 -->
		<!-- 본문메인이미지 -->
		<div id="sub_img_center"></div>
		<!-- 본문메인이미지 -->
		<!-- 왼쪽메뉴 -->
		<nav id="sub_menu">
		<ul>
		<li><a href="notice.jsp">공지</a></li>
		<li><a href="board.jsp">자유게시판</a></li>
		<li><a href="imageBoard.jsp">이미지게시판</a></li>
		</ul>
		</nav>
		<!-- 왼쪽메뉴 -->
		<!-- 본문내용 -->
		<article>
		<%
		// 세션값 가져오기
		String id = (String)session.getAttribute("id");
		if(id==null) {
			response.sendRedirect("../member/login.jsp");
		}
		
		// 파라미터 값 가져오기
		String pageNum = request.getParameter("pageNum");
		int num = Integer.parseInt(request.getParameter("num"));
		String search = request.getParameter("search");
		if(search==null) {
			search = "";
		}
		
		// 글 정보 가져오기
		NoticeDAO ndao = new NoticeDAO();
		NoticeBean nb = ndao.getNotice(num);
		
		// \r\n을 <br>로 바꾸기
		String content = "";
		if(nb.getContent()!=null)	{
			content = nb.getContent().replace("\r\n", "<br>");
		}
		
		%>
		<h1>게시글 수정</h1>

		<form action="updateNoticePro.jsp" method="post" name="fr" enctype="multipart/form-data" >
			<input type="hidden" name="pageNum" value="<%=pageNum %>">
			<input type="hidden" name="num" value="<%=num %>">
			<input type="hidden" name="search" value="<%=search %>" >
	<table>
		<tr>
			<th>제목</th><td><input type="text" name="subject" value="<%=nb.getSubject() %>"></td>
		</tr>
		<tr>
			<th>작성자</th><td><input type="text" name="name" value="<%=nb.getName() %>" readonly="readonly"></td>
		</tr>
		<tr>
			<th>파일첨부</th><td><input type="file" name="file" >
			<%
			if(nb.getFile()!=null) {	// 새로운 파일이 없고 기존파일이 있을때
				%>
				<input type="hidden" name="file2" value="<%=nb.getFile() %>" ><br>기존파일: <%=nb.getFile() %>
				<%
			}else {		// 새로운 파일이 없고 기존파일도 없을때
				%>
				<input type="hidden" name="file2" ><br>첨부파일 없음
				<%
			}
			%>
			</td>
		</tr>
		<tr><td colspan="2"><textarea rows="20" cols="70" name = "content"><%=content %></textarea></td></tr>
	</table>
		<div class="btn_div">
			<input type="submit" value="완료" class="btn blueBtn">
			<input type="reset" value="다시쓰기" class="btn redBtn">
			<input type="button" value="뒤로가기" class="btn greenBtn" onclick="history.back()">
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