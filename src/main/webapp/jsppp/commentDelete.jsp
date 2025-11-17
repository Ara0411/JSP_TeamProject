<%@ page import="java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String userId = (String)session.getAttribute("userId");
int comment_id = Integer.parseInt(request.getParameter("comment_id"));
int board_id = Integer.parseInt(request.getParameter("id"));

// 본인 댓글만 삭제
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");
PreparedStatement ps = conn.prepareStatement("DELETE FROM comment WHERE comment_id=? AND writer=?");
ps.setInt(1, comment_id); ps.setString(2, userId);
ps.executeUpdate();
ps.close(); conn.close();

response.sendRedirect("boardView.jsp?id=" + board_id);
%>