<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // DB 연결
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM board_free ORDER BY id DESC");
%>
<html>
<head><title>자유게시판</title></head>
<body>
    <h2>자유게시판</h2>
    <a href="boardWrite.jsp">글쓰기</a>
    <table border="1">
        <tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th></tr>
        <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><a href="boardView.jsp?id=<%=rs.getInt("id")%>"><%= rs.getString("title") %></a></td>
            <td><%= rs.getString("writer") %></td>
            <td><%= rs.getInt("viewcnt") %></td>
            <td><%= rs.getTimestamp("date") %></td>
        </tr>
        <% } %>
    </table>
</body>
</html>
<%
    rs.close(); stmt.close(); conn.close();
%>