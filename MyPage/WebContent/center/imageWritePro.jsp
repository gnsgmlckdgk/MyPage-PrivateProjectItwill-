<%@page import="image.ImageDAO"%>
<%@page import="image.ImageBean"%>
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
	<%
	// 세션 값 가져오기
	String id = (String)session.getAttribute("id");
	if(id==null) {
		response.sendRedirect("../member/login.jsp");
	}
	
	// MultipartRequest 객체 생성
	String realPath = request.getRealPath("/upload/image");
	int maxSize = 5 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realPath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
	
	// 파라미터 값 가져오기
	String pageNum = multi.getParameter("pageNum");
	
	String name = multi.getParameter("name");
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	String file = multi.getFilesystemName("file");
	String ip = request.getRemoteAddr();
	
	// ImageBean 객체 생성
	ImageBean ib = new ImageBean();
	ib.setName(name);
	ib.setSubject(subject);
	ib.setContent(content);
	ib.setFile(file);
	ib.setIp(ip);
	ib.setId(id);
	
	// ImageDAO 객체 생성
	ImageDAO idao = new ImageDAO();
	idao.insertImageBoard(ib);
	
	// 이동
	response.sendRedirect("imageBoard.jsp?pageNum="+pageNum);
	
	%>
</body>
</html>