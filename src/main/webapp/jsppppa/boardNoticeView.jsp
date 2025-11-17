<%@ page import = "java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int id = Integer.parseInt(request.getParameter("id"));
// 조회수 증가
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");
PreparedStatement psHit = conn.prepareStatement("UPDATE board_notice SET viewcnt = viewcnt+1 WHERE id=?");
psHit.setInt(1, id); psHit.executeUpdate();

PreparedStatement ps = conn.prepareStatement("SELECT * FROM board_notice WHERE id=?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
String isAdmin = (String)session.getAttribute("isAdmin");
if(rs.next()){
%>
<h2><%= rs.getString("title") %></h2>
<div><%= rs.getString("content") %></div>
<div>작성자: <%= rs.getString("writer") %></div>
<div>조회수: <%= rs.getInt("viewcnt")+1 %></div>
<div>작성일: <%= rs.getTimestamp("date") %></div>
<div>중요공지: <%= rs.getString("is_important").equals("Y") ? "★" : "" %></div>
<% if("Y".equals(isAdmin)) { %>
    <a href="boardNoticeEdit.jsp?id=<%=id%>">수정</a>
    <a href="boardNoticeDelete.jsp?id=<%=id%>">삭제</a>
<% } %>
<% } rs.close(); ps.close(); psHit.close(); conn.close(); %>