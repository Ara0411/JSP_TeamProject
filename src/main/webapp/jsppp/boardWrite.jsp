<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String userId = (String)session.getAttribute("userId"); // 세션에서 회원 체크
if(userId == null) {
    response.sendRedirect("login.jsp");
    return;
}
if(request.getMethod().equalsIgnoreCase("POST")) {
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");
    String sql = "INSERT INTO board_free(title, content, writer) VALUES (?, ?, ?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, title); ps.setString(2, content); ps.setString(3, userId);
    ps.executeUpdate();
    ps.close(); conn.close();
    response.sendRedirect("boardList.jsp");
    return;
}
%>
<html>
<body>
<form method="POST">
	제목: <input type="text" name="title"><br>
    내용: <textarea name="content"></textarea><br>
    <input type="submit" value="작성">
</form>
</body>
</html>