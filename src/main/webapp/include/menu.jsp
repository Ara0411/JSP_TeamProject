<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav style="background:#eee; padding:10px; text-align:center;">
    <a href="<%= request.getContextPath() %>/index.jsp">홈</a> |
    <a href="<%= request.getContextPath() %>/board/notice/list.jsp">공지사항</a> |
    <a href="<%= request.getContextPath() %>/board/free/list.jsp">자유게시판</a> |
    <a href="<%= request.getContextPath() %>/board/file/list.jsp">자료실</a>
</nav>
