<%@page import="comment.CommentDAO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- content_board에서 스크립트 함수로 이동이 계속 안먹혀서 jsp파일 두개더만듬 -->
	<!-- deleteBoard.jsp -->

	<%
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	// 파라미터 값 가져오기
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
				
	// DB작업
	CommentDAO cdao = new CommentDAO();	// 게시글에 있는 댓글 삭제
	cdao.deleteAllComment(num);
	
	BoardDAO bdao = new BoardDAO();	// 게시글 삭제
	bdao.deleteBoard(num);
	
	%>
	<script type="text/javascript">
		alert("게시글이 삭제되었습니다.");
		location.href="board.jsp?pageNum=<%=pageNum %>";
	</script>

</body>
</html>