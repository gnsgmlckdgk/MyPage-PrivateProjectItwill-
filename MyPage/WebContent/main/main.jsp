<%@page import="image.ImageBean"%>
<%@page import="image.ImageDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="notice.NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/front.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">

<style type="text/css">

/* 이미지 미리보기 */
#imagePreview_div {
	position: relative;
	width: 900px;
	left: 35px;
}

#imageBoardLink {	/* news image 부제목 링크 */
	text-decoration: none;
	color: #909090;
}

#imageBoardLink:hover {
	color: #ff0000;
}

#newImageSub {	/* news image 부제목 */
	font-style: italic;
	font-weight: bold;
	font-size: 1.2em;	
}

#imagePreview {	/* 테이블 */
	border: 2px solid #b0b0b0;
	position: relative;
	border-spacing: 5px;
}
#imagePreview td{	/* 테이블 td */
	border-collapse: collapse;
	width: 170px;
	height: 170px;
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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main/선라이즈.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<!-- <div id="solution">
<div id="hosting">
<h3>Web Hosting Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="security">
<h3>Web Security Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
<div id="payment">
<h3>Web Payment Solution</h3>
<p>Lorem impsun Lorem impsunLorem impsunLorem
 impsunLorem impsunLorem impsunLorem impsunLorem
  impsunLorem impsunLorem impsun....</p>
</div>
</div> -->

<!-- 이미지 게시판 미리보기 start -->
<%
	// 최근 이미지 5개 가져오기
	ImageDAO idao = new ImageDAO();
	int imageCount = idao.getCount();
	List<ImageBean> imageList = null;
	if(imageCount!=0) {
		imageList = idao.getImageBoardList(1, 5);
	}
	ImageBean ib = null;
%>
<div class="clear"></div>
<div id="imagePreview_div">
	<a href="../center/imageBoard.jsp" id="imageBoardLink"><span id="newImageSub">News &amp; Image</span></a>
	<hr>
	<table id="imagePreview">
		<tr>
		<%
		for(int i=0; i<imageList.size(); i++) {
			ib = imageList.get(i);
			%>
			<td><a href="../center/content_image.jsp?num=<%=ib.getNum() %>"><img src="../upload/image/<%=ib.getFile() %>" width="170px" height="170px"></a></td>
			<%
		}
		%>
		</tr>
	</table>
</div>
<!-- 이미지 게시판 미리보기 end -->
<div class="clear"></div>
<%
/* 공지게시판 게시글 불러오기 */
NoticeDAO ndao = new NoticeDAO();

// 전체 공지 갯수
int count = ndao.getCount();

// 첫번째 행
int startRow = 1;
// 한 페이지에 보여줄 글 갯수
int pageSize = 5;

List<NoticeBean> listNotice = null;
// 리스트에 공지 담기
if(count != 0) {
	listNotice = ndao.getNoticeList(startRow, pageSize);	
}

%>
<div id="sec_news">
<h3><a href="../center/notice.jsp" ><span class="orange">News </span> &amp; Notice</a></h3>
<table>
<%
SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd");
NoticeBean nb = null;
if(count != 0) {
	for(int i=0; i<listNotice.size(); i++) {
		nb = listNotice.get(i);
		%>
		<tr><td class="contxt">
		<a href="../center/content_notice.jsp?num=<%=nb.getNum() %>&pageNum=<%=1 %>"><%=nb.getSubject() %></a></td><td><%=sdf.format(nb.getDate()) %></td></tr>
		<%
	}
}
%>
</table>
</div>

<%
/* 자유게시판 게시글 불러오기 */
BoardDAO bdao = new BoardDAO();
// 전체 게시글 갯수
int count_b = bdao.getCount();
// 한페이지에 보여줄 게시글 갯수
	// 위의 pageSize
// 첫번째 행
	// 위의 startRow

// 게시글 불러올 리스트
List<BoardBean> boardList = null;

if(count_b != 0) {
	boardList = bdao.getBoardList(startRow, pageSize);
}
BoardBean bb = null;
%>
<div id="news_notice">
<h3 class="brown"><a href="../center/board.jsp" >News &amp; Board</a></h3>
<table>
<%
if(count_b != 0) {
	for(int i=startRow-1; i<boardList.size(); i++) {
		bb = boardList.get(i);
		%>
		<tr><td class="contxt"><a href="../center/content_board.jsp?num=<%=bb.getNum() %>&pageNum=<%=1 %>"><%=bb.getSubject() %></a></td>
   	 	<td><%=sdf.format(bb.getDate()) %></td></tr>
		<%
	}
}
%>
</table>
</div>

</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>