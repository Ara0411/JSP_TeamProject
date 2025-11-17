<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
String isAdmin = (String)session.getAttribute("isAdmin");
if(!"Y".equals(isAdmin)){
    out.println("관리자만 작성 가능합니다.");
    return;
}
%>
<form method="POST" action="boardNoticeWriteProc.jsp">
    제목: <input type="text" name="title"><br>
    내용: <textarea name="content"></textarea><br>
    중요공지: <input type="checkbox" name="important" value="Y"> 중요공지<br>
    <input type="submit" value="작성">
</form>
</body>
</html>