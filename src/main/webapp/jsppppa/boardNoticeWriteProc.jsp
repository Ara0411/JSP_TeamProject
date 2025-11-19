<%@ page import = "java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String isAdmin = (String)session.getAttribute("isAdmin");
if(!"Y".equals(isAdmin)){ response.sendRedirect("error.jsp"); return; }

String title = request.getParameter("title");
String content = request.getParameter("content");
String important = request.getParameter("important") != null ? "Y" : "N";
String adminId = (String)session.getAttribute("userId");

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");
String sql = "INSERT INTO board_notice(title, content, writer, is_important) VALUES (?, ?, ?, ?)";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, title); ps.setString(2, content); ps.setString(3, adminId); ps.setString(4, important);
ps.executeUpdate();
ps.close(); conn.close();
response.sendRedirect("boardNoticeList.jsp");
%>