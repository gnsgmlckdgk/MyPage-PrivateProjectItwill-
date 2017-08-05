<%@page import="comment.CommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// 파라미터 값 가져오기
	String pageNum = request.getParameter("pageNum");			// 게시글리스트의 페이지 번호
	int num = Integer.parseInt(request.getParameter("num"));	// 게시글 번호
	int commentPageNum = Integer.parseInt(request.getParameter("commentPageNum"));	// 댓글 페이지 번호
	int cNum = Integer.parseInt(request.getParameter("cNum"));	// 댓글 번호
	
	// DB에서 삭제
	CommentDAO cdao = new CommentDAO();
	cdao.deleteComment(cNum);
	
	// 이동
	%>
	<script type="text/javascript">
	alert("댓글이 삭제되었습니다.");
	location.href="content_board.jsp?pageNum=<%=pageNum %>&num=<%=num %>&commentPageNum=<%=commentPageNum %>";
	</script>
</body>
</html>