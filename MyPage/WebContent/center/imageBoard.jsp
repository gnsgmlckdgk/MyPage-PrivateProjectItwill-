<%@page import="image.ImageBean"%>
<%@page import="java.util.List"%>
<%@page import="image.ImageDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - ImageBoard</title>
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

	table {
		border-spacing: 10px;
		/* border: 2px solid blue; */
	}
	
	.image_td {
		width: 200px;
		height: 200px;
		padding: 0px;
		
		text-align: center;
		border: 2px solid #f0f0f0;
	}
		.image_td:hover {
			cursor: pointer;
		}
	
	.image_name {
		padding-top: 5px;
		padding-bottom: 5px;
	}	
		.image_name:hover {
			background-color: #f0f0f0;
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
// 세션값 가져오기
String id = (String)session.getAttribute("id");
if(id==null) {
	id = "null";
}

	// 검색단어 있는지 확인
	String search = request.getParameter("search");
	if(search==null) {	// 검색단어 없을때
		search="";
	}

// DB작업 객체 생성
ImageDAO idao = new ImageDAO();

// 전체 글의 갯수 구하기
int count = 0;
if(search.equals("")) {	// 검색단어 없을때
	count = idao.getCount();
}else {					// 검색단어 있을때
	count = idao.getCount(search);
}

// 현제 페이지 번호 구하기
String pageNum = request.getParameter("pageNum");
if(pageNum==null) {	// 처음 시작시 무조건 1페이지
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);

// 한 페이지에 출력할 개시글의 갯수 설정
int pageSize = 9;

// 시작행 구하기
int startRow = (currentPage - 1) * pageSize + 1;

// 이미지 리스트 가져오기
List<ImageBean> imageList = null;
if(count!=0) {
	if(search.equals("")) {	// 검색단어 없을때
		imageList = idao.getImageBoardList(startRow, pageSize);
	}else {					// 검색단어 있을때
		imageList = idao.getImageBoardList(startRow, pageSize, search);
	}
}

%>
<!-- 게시판 -->
<article>
<!-- 이미지게시판 리스트 오는 자리 -->
<h1>ImageBoard</h1>
		<table>
			<%
			ImageBean ib = null;
			int max_index = startRow-1;	// 리스트에서 가져올 인덱스
			
			// <tr> 반복 횟수
			int trSeq; 
			if(count != 0) {
				if(count-startRow < 3) {	// 0, 1, 2
					trSeq = 1;
				}else if(count-startRow < 6) {	// 3, 4, 5
					trSeq = 2;
				}else {	// 6 이상
					trSeq = 3;
				}
			}else {
				trSeq = 0;
			}
			
			/* int index = (currentPage-1) * pageSize;	// 시작 인덱스 */
			int index = 0;
			for(int i=0; i<trSeq; i ++) {
			%>
				<tr class="image_tr">
				<%
				if(count!=0) {
					for(int j=0; j<3; j++) {
						if(max_index < count) {
							ib = imageList.get(index);
							index++;
							max_index++;
						}else {
							break;
						}
						
						if(ib.getFile()!=null) {
							%>
							<td class="image_td" onclick="location.href='content_image.jsp?pageNum=<%=pageNum %>&num=<%=ib.getNum() %>&search=<%=search %>'">
							<img src="../upload/image/<%=ib.getFile() %>" width="200" height="200"><div class="image_name"><%=ib.getSubject() %></div></td>
							<%
						}else {	// 사진 없는 경우(비워둠)
							%>
							<td class="image_td" onclick="location.href='content_image.jsp?pageNum=<%=pageNum %>&num=<%=ib.getNum() %>&search=<%=search %>'"> 
							<div class="image_name"> </div></td>
							<%
						}
					}
				}
				%>
				</tr>
				<%
			}
			%>
		</table>

<!-- 사진게시판 리스트 오는 자리 -->
<div id="table_search">

<!-- 검색 버튼 -->
<form action="imageBoard.jsp" method="get" name="fr">
<input type="text" name="search" class="input_box" value="<%=search %>">
<input type="submit" value="search" class="btn">
<%
if(!id.equals("null")) {	// 로그인 했을때만 보임
	%>
	<input type="button" name="boardBtn" class="btn" value="글쓰기" onclick="location.href='imageWrite.jsp?pageNum=<%=pageNum %>'">
	<%
}
%>
</form>
</div>
<div class="clear"></div>
<%
/* 게시판 페이징 */
// 전체 페이지 갯수 구하기(페이지 몇개가 필요한지)
int pageCount = count / pageSize + (count%pageSize==0 ? 0:1);
// 한 페이지에 표시할 페이지 수 지정
int pageBlock = 10;
// 시작 페이지 번호
int startPage =  ((currentPage - 1)/pageBlock) * pageBlock + 1; 
// 끝 페이지 번호
int endPage = startPage + pageBlock - 1;
if(endPage > pageCount) {
	endPage = pageCount;
}

%>
<div id="page_control">
<%
// 이전, 페이지, 다음
if(startPage > pageBlock) {
	%>
	<a href="imageBoard.jsp?pageNum=<%=startPage-pageBlock %>&search=<%=search %>" >[이전]</a>
	<%
}
for(int i=startPage; i <= endPage; i++ ) {
	%>
	<a href="imageBoard.jsp?pageNum=<%=i %>&search=<%=search %>" ><span id="pageNumber" <%if(currentPage==i){ %>class="selectedPageNum"<%} %> ><%=i %></span></a>
	<%
}
if(endPage < pageCount) {
	%>
	<a href="imageBoard.jsp?pageNum=<%=startPage+pageBlock %>&search=<%=search %>" >[다음]</a>
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
