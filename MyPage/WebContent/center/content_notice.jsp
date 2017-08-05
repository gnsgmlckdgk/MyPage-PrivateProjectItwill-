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
<link href="../css/content_board_notice.css?ver=13" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function deleteNotice(pageNum, num) {
		if(confirm("공지를 삭제하시겠습니까?")){
			location.href="deleteNotice.jsp?pageNum="+pageNum+"&num="+num;	
		}
	}

</script>

</head>
<body>
	<%
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		id="null";	// eqlus메소드를 사용할때 오류가 생겨서 id가 없는경우 "null"로 설정
	}
	// 파라미터 값 가져오기
	String pageNum = request.getParameter("pageNum");			// 페이지 번호
	int num = Integer.parseInt(request.getParameter("num"));	// 글번호
	String search = request.getParameter("search");		// 검색
	if(search==null) {
		search = "";
	}
	
	// NoticeDAO 객체 생성
	NoticeDAO ndao = new NoticeDAO();
	// 조회수 증가
	ndao.updateReadCount(num);
	// DB에서 글 가져오기
	NoticeBean nb = ndao.getNotice(num);
	// \r\n을 <br>로 바꾸기
	String content = "";
	if(nb.getContent()!=null)	{
		content = nb.getContent().replace("\r\n", "<br>");
	}
	
	%>
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
		<h1>Notice</h1>
		<div>
			<table>
				<tr>
					<th>제목</th><td><%=nb.getSubject() %></td><td><%=nb.getReadcount() %></td>
				</tr>
				<tr>
					<th>작성자</th><td><%=nb.getName() %></td><td><%=nb.getDate() %></td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td colspan="2"><%if(nb.getFile()!=null) { %>
					<a href="file_down.jsp?file_name=<%="../upload/notice/"+nb.getFile() %>" ><%=nb.getFile() %></a><% } else { %> 첨부파일 없음 <% } %></td>
				</tr>
				<tr><td colspan="3" id="content" ><%=content %></td></tr>
			</table>
		</div>
		<div class="btn_div">
		<% 
		if(id.equals("admin")) {
			%>
			<input type="button" value="수정" class="btn greenBtn" onclick ="location.href='updateNotice.jsp?pageNum=<%=pageNum %>&num=<%=num %>&search=<%=search %>'">
			<input type="button" value="삭제" class="btn redBtn" onclick ="deleteNotice(<%=pageNum %>, <%=num %>)">
			<%
		}
		%>
			<input type="button" value="목록" class="btn blueBtn" onclick ="location.href='notice.jsp?pageNum=<%=pageNum %>&search=<%=search %>'">
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