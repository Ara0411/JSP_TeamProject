<%@ page import="java.sql.*, java.util.*" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int id = Integer.parseInt(request.getParameter("id"));
String userId = (String)session.getAttribute("userId");

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/DB명", "아이디", "비밀번호");

// 조회수 증가
PreparedStatement psHit = conn.prepareStatement("UPDATE board_free SET viewcnt = viewcnt+1 WHERE id=?");
psHit.setInt(1, id);
psHit.executeUpdate();

// 게시글 정보
PreparedStatement ps = conn.prepareStatement("SELECT * FROM board_free WHERE id=?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
if(rs.next()) {
%>
<html>
<body>
    <h2><%= rs.getString("title") %></h2>
    <div><%= rs.getString("content") %></div>
    <div>작성자: <%= rs.getString("writer") %></div>
    <div>조회수: <%= rs.getInt("viewcnt")+1 %></div>
    <div>작성일: <%= rs.getTimestamp("date") %></div>
    <% if(userId!=null && userId.equals(rs.getString("writer"))) { %>
        <a href="boardEdit.jsp?id=<%=id%>">수정</a>
        <a href="boardDelete.jsp?id=<%=id%>">삭제</a>
    <% } %>
    <hr>
    <!-- 댓글 목록 -->
    <h3>댓글</h3>
    <%
    PreparedStatement pc = conn.prepareStatement("SELECT * FROM comment WHERE board_id=? ORDER BY date ASC");
    pc.setInt(1, id);
    ResultSet rc = pc.executeQuery();
    while(rc.next()) {
        String cWriter = rc.getString("writer");
    %>
        <div>
            [<%= cWriter %>] <%= rc.getString("content") %>
            <% if(userId!=null && userId.equals(cWriter)) { %>
                <a href="commentDelete.jsp?comment_id=<%=rc.getInt("comment_id")%>&id=<%=id%>">삭제</a>
            <% } %>
            <br>
        </div>
    <% } rc.close(); pc.close(); %>
    <!-- 댓글 입력폼 -->
    <form method="POST" action="commentWrite.jsp">
        <input type="hidden" name="board_id" value="<%=id%>">
        <textarea name="content"></textarea>
        <input type="submit" value="댓글작성">
    </form>
</body>
</html>
<%
}
rs.close(); ps.close(); psHit.close(); conn.close();
%>