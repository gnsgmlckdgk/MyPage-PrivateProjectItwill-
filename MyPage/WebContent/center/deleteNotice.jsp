<%@page import="notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- deleteNotice.jsp -->
	
	<%
	String id = (String)session.getAttribute("id");
	if(id==null) {
		id="null";
	}
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));

	NoticeDAO ndao = new NoticeDAO();
	ndao.deleteNotice(num);
	
	%>
	<script type="text/javascript">
		alert("게시글이 삭제되었습니다.");
		location.href="notice.jsp?pageNum=<%=pageNum %>";
	</script>
	
</body>
</html>