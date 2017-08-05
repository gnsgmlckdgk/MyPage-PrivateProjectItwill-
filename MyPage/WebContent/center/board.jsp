<%@page import="java.util.List"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Board</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=13" rel="stylesheet" type="text/css">

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
 
<style type="text/css">

/* 공지게시판의 th */
#notice th {
	text-align: center;
}

/* 공지게시판의 date리스트 */
#notice .tdate {
	width: 70px;
}

</style>
</head>
<body>
<!-- 자유게시판 -->
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

<!-- DB작업(게시판) start -->
<%
// 한글처리
request.setCharacterEncoding("UTF-8");

// 세션값 가져오기
String id = (String)session.getAttribute("id");
if(id==null) {
	id = "null";
}

// DB작업 객체 생성
BoardDAO bdao = new BoardDAO();

// 검색값 가져오기
String search = request.getParameter("search");
if(search==null) {
	search="";
}

// 전체 글의 갯수 구하기
int count;
if(search.equals("")) {	// 검색값이 없다면
	count = bdao.getCount();
}else {					// 검색값이 있다면
	count = bdao.getCount(search);
}

// 현제 페이지 번호 구하기
String pageNum = request.getParameter("pageNum");
if(pageNum==null) {	// 처음 시작시 무조건 1페이지
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);

// 한 페이지에 출력할 개시글의 갯수 설정
int pageSize = 15;

// 시작행 구하기
int startRow = (currentPage - 1) * pageSize + 1;

// 공지 리스트 가져오기
List<BoardBean> listBoard = null;
if(count != 0) {
	if(search.equals("")) {	// 검색값이 없다면
		listBoard = bdao.getBoardList(startRow, pageSize);
	}else {					// 검색값이 있다면
		listBoard = bdao.getBoardList(startRow, pageSize, search);
	}
	
}

BoardBean bb = null;
%>
<!-- 게시판 -->
<article>
<h1>Board</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
if(count != 0) {
	for(int i=0; i<listBoard.size(); i++) {
		bb = listBoard.get(i);
		int wid = 10 * bb.getRe_lev();	// 들여쓰기 정도(답글)
		%>
		<tr><td><%=bb.getNum() %></td>
		
		<td class="left" onclick="location.href='content_board.jsp?pageNum=<%=pageNum %>&num=<%=bb.getNum() %>&search=<%=search %>'">
		<%
		if(bb.getRe_lev()!=0) {	// 답글이면
			%>
			<img src="../images/center/board/level.gif" width="<%=wid %>"><img src="../images/center/board/re.gif" >
			<%
		}
		%>
		<%=bb.getSubject() %>
		</td>
	    
	    <td><%=bb.getId() %></td><td><%=bb.getDate() %></td><td><%=bb.getReadcount() %></td></tr>  
		<%
	}
}

%>
</table>
<div id="table_search">

<!-- 검색 버튼 -->
<form action="board.jsp" method="get" name="fr">
<input type="text" name="search" class="input_box" value="<%=search %>">
<input type="submit" value="search" class="btn">
<%
if(!id.equals("null")) {	// 로그인 했을때만 보임
	%>
	<input type="button" name="boardBtn" class="btn" value="글쓰기" onclick="location.href='writeBoard.jsp'">
	<%
}
%>
</form>
</div>
<div class="clear"></div>
<%
// 전체 페이지 갯수 구하기
int pageCount = count/pageSize + (count%pageSize==0 ? 0:1);
// 한 페이지에 표시할 페이지 수 지정
int pageBlock = 10;
// 시작 페이지 번호
int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
// 끝 페이지 번호
int endPage = startPage + pageBlock - 1;
if(endPage > pageCount) {
	endPage = pageCount;
}

%>
<div id="page_control">
<%
if(startPage > pageBlock) {
	%>
	<a href="board.jsp?pageNum=<%=startPage-pageBlock %>&search=<%=search %>">[이전]</a>
	<%
}
for(int i=startPage; i<=endPage; i++) {
	%>
	<a href="board.jsp?pageNum=<%=i %>&search=<%=search %>"><span id="pageNumber" <%if(currentPage==i){ %>class="selectedPageNum"<%} %> ><%=i %></span></a>
	<%
}
if(endPage < pageCount) {
	%>
	<a href="board.jsp?pageNum=<%=startPage+pageBlock %>&search=<%=search %>">[다음]</a>
	<%
}
%>

</div>
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