<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String userId = (String)session.getAttribute("userId");
if(userId == null) {
    response.sendRedirect("login.jsp");
    return;
}
if(request.getMethod().equalsIgnoreCase("POST")) {
    String content = request.getParameter("content");
    int board_id = Integer.parseInt(request.getParameter("board_id"));
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");
    String sql = "INSERT INTO comment(board_id, writer, content) VALUES (?, ?, ?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, board_id); ps.setString(2, userId); ps.setString(3, content);
    ps.executeUpdate();
    ps.close(); conn.close();
    response.sendRedirect("boardView.jsp?id=" + board_id);
}
%>