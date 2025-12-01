<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>

<%
    String errMsg = "";
    try {
        String userName = (String)session.getAttribute("userName");
        if(userName == null){
            response.sendRedirect("../member/login.jsp");
            return;
        }
        int board_id = Integer.parseInt(request.getParameter("board_id"));
        String content = request.getParameter("content");

        Connection conn = DBUtill.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO board_comment (board_id, writer, content) VALUES (?, ?, ?)");
        ps.setInt(1, board_id);
        ps.setString(2, userName);
        ps.setString(3, content);
        ps.executeUpdate();
        ps.close(); conn.close();
        response.sendRedirect("View.jsp?id=" + board_id);
    } catch(Exception e){
        e.printStackTrace();
        errMsg = "<h3>댓글 저장 중 오류가 발생했습니다: " + e.getMessage() + "</h3>";
    }
%>

<% if(errMsg.length() > 0) { %>
<%= errMsg %>
<% } %>
