<%@ page import = "java.sql.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");

// 공지글 중 중요공지 먼저, 그 다음 일반공지
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("SELECT * FROM board_notice ORDER BY is_important DESC, id DESC");
String isAdmin = (String)session.getAttribute("isAdmin");
%>
<html>
<body>
<h2>공지사항</h2>
<% if("Y".equals(isAdmin)) { %>
    <a href="boardNoticeWrite.jsp">글쓰기</a>
<% } %>
<table border="1">
    <tr><th>번호</th><th>제목</th><th>작성자</th><th>조회수</th><th>작성일</th><th>중요공지</th></tr>
    <% while(rs.next()) { %>
    <tr style="<%= "Y".equals(rs.getString("is_important")) ? "background-color:yellow;" : "" %>">
        <td><%= rs.getInt("id") %></td>
        <td>
            <a href="boardNoticeView.jsp?id=<%=rs.getInt("id")%>">
                <%= rs.getString("title") %>
            </a>
        </td>
        <td><%= rs.getString("writer") %></td>
        <td><%= rs.getInt("viewcnt") %></td>
        <td><%= rs.getTimestamp("date") %></td>
        <td><%= rs.getString("is_important").equals("Y") ? "★" : "" %></td>
    </tr>
    <% } %>
</table>
</body>
</html>
<% rs.close(); stmt.close(); conn.close(); %>