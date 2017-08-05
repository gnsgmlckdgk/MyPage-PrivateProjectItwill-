<%@page import="comment.CommentBean"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FunWeb - Board</title>

<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=14" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<link href="../css/content_board_notice.css?ver=13" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function deleteBoard(pageNum, num) {
		if(confirm("게시글을 삭제하시겠습니까?")) {
			location.href="deleteBoard.jsp?pageNum="+pageNum+"&num="+num;			
		}
	}
	
	// 댓글 쓰기
	function writeComment(pageNum, content_num) {
		var content = document.getElementById("comment").value;
		content = content.replace(/\n/g, "<br>");	// 자바스크립트의 replace는 정규표현식으로 모두 바꾸는걸 지정안해주면 최초의 하나만 바뀐다.
		if(content.length!=0) {
			location.href= "writeComment.jsp?pageNum="+pageNum+"&content_num="+content_num+"&content="+content;
		}
	}
	
</script>

</head>
<body>
	<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		id = "";
	}
	
	// 파라미터 값 가져오기
	String pageNum = request.getParameter("pageNum");			// 페이지 번호
	int num = Integer.parseInt(request.getParameter("num"));	// 글번호
	String search = request.getParameter("search");
	if(search==null) {
		search="";
	}
	
	// BoardDAO 객체 생성
	BoardDAO bdao = new BoardDAO();
	// 조회수 증가
	bdao.updateReadCount(num);
	// DB에서 글 가져오기
	BoardBean bb = bdao.getBoard(num);
	// \r\n을 <br>로 바꾸기
	String content = "";	
	if(bb.getContent()!=null)	{
			content = bb.getContent().replace("\r\n", "<br>");
		}
	
	/* 수정, 삭제버튼 보이게 할지 말지 */
	// 로그인한 ID와 글의 ID를 비교한다
	// 로그인한ID
		// 세션ID값
	// 글의 ID
	String content_id = bb.getId();
	
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
		<h1>Board</h1>
		<div>
			<table>
				<tr>
					<th>제목</th><td><%=bb.getSubject() %></td><td><%=bb.getReadcount() %></td>
				</tr>
				<tr>
					<th>작성자</th><td><%=bb.getId() %></td><td><%=bb.getDate() %></td>
				</tr>
				<tr>
					<th>파일첨부</th>
					<td colspan="2"><%if(bb.getFile()!=null) { %>
					<a href="file_down.jsp?file_name=<%="../upload/board/"+bb.getFile()%>" ><%=bb.getFile() %></a><% } else { %> 첨부파일 없음 <% } %></td>
				</tr>
				<tr><td colspan="3" id="content"><%=content %></td></tr>
			</table>	
		</div>
		
		<!-- 댓글 -->
		<%
		// 현제 댓글 페이지
		String commentPageNum = request.getParameter("commentPageNum");
		if(commentPageNum == null) {
			commentPageNum = "1";
		}
		int commentCurrentPage = Integer.parseInt(commentPageNum);
		
		// DB작업 객체 생성
		CommentDAO cdao = new CommentDAO();
		
		// 전체 댓글의 갯수 구하기
		int commentCount = cdao.getCount(num);
		
		// 한페이지에 표시할 댓글의 갯수 지정
		int commentPageSize = 10;
		
		// 시작행 구하기
		int commentStartRow = (commentCurrentPage - 1) * commentPageSize + 1;
		
		// 리스트에 댓글 담기
		List<CommentBean> listComment = null;
		if(commentCount!=0) {
			listComment = cdao.getCommentList(num, commentStartRow, commentPageSize);
		}
		CommentBean cb = null;
		%>
		<br>
		<div class="conment_div">
		<table>
			<tr>
				<td colspan="4"><textarea cols="75" rows="3" id="comment" style="border: 2px solid #f0aaf0; float: left;"></textarea> 
				<input type="button" value="작성" style="width: 70px; height: 50px; float: right;" 
				onclick="writeComment(<%=pageNum %>, <%=num %>)"></td>
			<tr>
			<%
			if(commentCount > 0) {
				for(int i=0; i<listComment.size(); i++) {
					cb = listComment.get(i);
					%>
					<tr>
					<td style="width: 120px;"><%=cb.getId() %></td><td style="width: 470px;"><%=cb.getContent() %></td><td style="width: 120px"><%=cb.getDate() %></td>
					<td style="width: 50px;">
					<%
					if(id.equals(cb.getId()) || id.equals("admin")) {	// 자신이 적은 댓글이거나 관리자인 경우 삭제링크 활성화
						%>
						<a href="deleteComment.jsp?pageNum=<%=pageNum %>&num=<%=num %>&commentPageNum=<%=commentPageNum %>&cNum=<%=cb.getNum() %>" style="text-decoration: none;">
						<span style="color: #707070">삭제</span>
						</a>
						<%
					}
					%>
					</td>
					</tr>	
					<%
				}
			}else {
				%>
				<tr>
				<td style="width: 120px;"></td><td style="width: 450px;">댓글을 입력해주세요...</td><td style="width: 120px"></td>
				<td style="width: 50px;"><a href="" style="text-decoration: none;"></a></td>
				</tr>	
				<%
			}
			%>
		</table>
		</div>
		<!-- 댓글 -->
		<!-- 댓글 페이징 -->
		<%
		// 젠체 페이지 갯수 구하기
		int commentPageCount = commentCount / commentPageSize + (commentCount%commentPageSize==0?0:1);
		// 한페이지 출력할 페이지 갯수 지정
		int commentPageBlock = 5;
		// 시작 페이지
		int commentStartPage = ((commentCurrentPage-1)/commentPageBlock)*commentPageBlock + 1;
		// 끝 페이지
		int commentEndPage = commentStartPage + commentPageBlock - 1;
		if(commentEndPage > commentPageCount) {
			commentEndPage = commentPageCount;
		}
				
		%>
		<div id="page_control">
		<%
		if(commentStartPage > commentPageBlock) {
		%>
		<a href="content_board.jsp?commentPageNum=<%=commentStartPage-commentPageBlock %>&pageNum=<%=pageNum %>&num=<%=num %>">[이전]</a>
		<%
		}
		for(int i=commentStartPage; i<=commentEndPage; i++) {
		%>
		<a href="content_board.jsp?commentPageNum=<%=i %>&pageNum=<%=pageNum %>&num=<%=num %>"><span id="pageNumber" <%if(commentCurrentPage==i){ %>class="selectedPageNum"<%} %> ><%=i %></span></a>
		<%
		}
		if(commentEndPage < commentPageCount) {
		%>
		<a href="content_board.jsp?commentPageNum=<%=commentStartPage+commentPageBlock %>&pageNum=<%=pageNum %>&num=<%=num %>">[다음]</a>
		<%
		}
		%>
		</div>
		<!-- 댓글 페이징 -->
		<div class="btn_div">
		<%
		if(!id.equals("")) {	// 로그인이 되어 있을때
			%>
			<input type="button" value="답글작성" class="btn blueBtn" onclick ="location.href='rewriteBoard.jsp?pageNum=<%=pageNum %>&num=<%=num %>&search=<%=search %>'" >
			<%
			if(id.equals(content_id)) {	// 로그인한 아이디와 글을 작성한 ID가 같을때
			%>
				<input type="button" value="수정" class="btn greenBtn" onclick ="location.href='updateBoard.jsp?pageNum=<%=pageNum %>&num=<%=num %>&search=<%=search %>'">
				<input type="button" value="삭제" class="btn redBtn" onclick="deleteBoard(<%=pageNum %>, <%=num %>)">
			<%
			}else if(id.equals("admin")) {	// 로그인한 아이디가 관리자 ID일때
				%>
				<input type="button" value="삭제" class="btn redBtn" onclick="deleteBoard(<%=pageNum %>, <%=num %>)">
				<%
			}
		}
		%>
			<input type="button" value="목록" class="btn blueBtn" onclick ="location.href='board.jsp?pageNum=<%=pageNum %>&search=<%=search %>'">
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