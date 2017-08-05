<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- updateBoardPro.jsp -->
	
	<%
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	}
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 멀티파트리퀘스트 객체 생성
	String realPath = request.getRealPath("/upload/board");
	int maxSize = 5 * 1024 * 1024;	// 5MB
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	// 파라미터 값 가져오기
	String pageNum = multi.getParameter("pageNum");
	String search = multi.getParameter("search");
	if(search == null) {
		search = "";
	}
	
	int num = Integer.parseInt(multi.getParameter("num"));
	String subject = multi.getParameter("subject");
	String name = multi.getParameter("name");
	String file;
	if(multi.getFilesystemName("file")!=null) {	// 새로운 첨부파일이 있다면
		file = multi.getFilesystemName("file");
	}else {	// 새로운 첨부파일이 없다면
		file = multi.getParameter("file2");
	}
	String content = multi.getParameter("content");
	String ip = request.getRemoteAddr();	// ip를 다시하는 이유가 다른 곳에서 글을 수정할 수 있기 때문에
	
	// 빈에 담기
	BoardBean bb = new BoardBean();
	bb.setSubject(subject);
	bb.setName(name);
	bb.setFile(file);
	bb.setContent(content);
	bb.setIp(ip);
	
	// DB수정 작업
	BoardDAO bdao = new BoardDAO();
	bdao.updateBoard(bb, num);		// 조건에 맞지 않으면 버튼이 안보여서 따로 반환값 없음
	
	// 게시글로 이동
	/* response.sendRedirect("content_board.jsp?pageNum="+pageNum+"&num="+num); */
	%>
	<script type="text/javascript">
	location.href="content_board.jsp?pageNum=<%=pageNum %>&num=<%=num %>&search=<%=search %>";
	</script>
</body>
</html>