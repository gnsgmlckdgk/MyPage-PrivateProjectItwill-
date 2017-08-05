<%@page import="image.ImageDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="image.ImageBean"%>
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
	// 한글처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// MultipartRequest 객체 생성
	String realPath = request.getRealPath("/upload/image");
	int maxSize = 5 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	String pageNum = multi.getParameter("pageNum");
	int num = Integer.parseInt(multi.getParameter("num"));
	String search = multi.getParameter("search");
	if(search == null) {
		search = "";
	}
	
	// 파라미터 값 빈에 담기
	ImageBean ib = new ImageBean();
	ib.setNum(Integer.parseInt(multi.getParameter("num")));
	ib.setSubject(multi.getParameter("subject"));
	ib.setName(multi.getParameter("name"));
	if(multi.getFilesystemName("file")!=null) {
		ib.setFile(multi.getFilesystemName("file"));
	}else {
		ib.setFile(multi.getParameter("file2"));
	}
	ib.setContent(multi.getParameter("content"));
	ib.setIp(request.getRemoteAddr());
	
	// DB작업
	ImageDAO idao = new ImageDAO();
	idao.updateBoard(ib);
	
	// 이동
	/* response.sendRedirect("content_image.jsp?pageNum="+pageNum+"&num="+num+"&search="+search); */
	// response로 보내면 search가 자꾸 ??로 나옴(깨짐)
	%>
	<script type="text/javascript">
	location.href="content_image.jsp?pageNum=<%=pageNum %>&num=<%=num %>&search=<%=search %>";
	</script>
</body>
</html>