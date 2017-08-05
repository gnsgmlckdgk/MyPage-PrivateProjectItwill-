<%@page import="notice.NoticeBean"%>
<%@page import="java.util.List"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Notice</title>
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
<!-- 공지게시판 -->
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
// 세션값 가져오기
String id = (String)session.getAttribute("id");
if(id==null) {
	id = "null";
}

// 파라미터 값 가져오기
String search = request.getParameter("search");
if(search == null) {
	search = "";
}

// DB작업 객체 생성
NoticeDAO ndao = new NoticeDAO();

// 전체 글의 갯수 구하기
int count;
if(search.equals("")) {	// 검색값이 없으면
	count = ndao.getCount();
}else {	// 검색값이 있으면
	count = ndao.getCount(search);
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
List<NoticeBean> listNotice = null;
if(count != 0) {
	if(search.equals("")) {	// 검색값이 없으면
		listNotice = ndao.getNoticeList(startRow, pageSize);
	}else {		// 검색값이 있으면
		listNotice = ndao.getNoticeList(startRow, pageSize, search);
	}
}

NoticeBean nb = null;
%>
<!-- 게시판 -->
<article>
<h1>Notice</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
<%
if(count != 0) {
	for(int i=0; i<listNotice.size(); i++) {
		nb = listNotice.get(i);
		%>
		<tr><td><%=nb.getNum() %></td><td class="left" onclick="location.href='content_notice.jsp?pageNum=<%=pageNum %>&num=<%=nb.getNum() %>&search=<%=search %>'" ><%=nb.getSubject() %></td>
	    <td><%=nb.getName() %></td><td><%=nb.getDate() %></td><td><%=nb.getReadcount() %></td></tr>
		<%
	}
}

%>
</table>
<div id="table_search">
<!-- 검색 버튼 -->
<form action="notice.jsp" method="get" name="fr">
<input type="text" name="search" class="input_box" value="<%=search %>">
<input type="submit" value="search" class="btn">
<%
if(id.equals("admin")) {
	%>
	<input type="button" name="noticeBtn" class="btn" value="공지작성" onclick="location.href='writeNotice.jsp'">
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
	<a href="notice.jsp?pageNum=<%=startPage-pageBlock %>&search=<%=search %>">[이전]</a>
	<%
}
for(int i=startPage; i<=endPage; i++) {
	%>
	<a href="notice.jsp?pageNum=<%=i %>&search=<%=search %>"><span id="pageNumber" <%if(currentPage==i){ %>class="selectedPageNum"<%} %> ><%=i %></span></a>
	<%
}
if(endPage < pageCount) {
	%>
	<a href="notice.jsp?pageNum=<%=startPage+pageBlock %>&search=<%=search %>">[다음]</a>
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