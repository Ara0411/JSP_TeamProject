<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>
<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String writer = request.getParameter("writer");

    String errMsg = "";
    try {
        Connection conn = DBUtill.getConnection();
        PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO board_free (title, content, writer, regdate, viewcnt) VALUES (?, ?, ?, NOW(), 0)"
        );
        ps.setString(1, title);
        ps.setString(2, content);
        ps.setString(3, writer);

        int result = ps.executeUpdate();
        ps.close(); conn.close();

        if(result > 0){
            response.sendRedirect("List.jsp");
        } else {
            errMsg = "글 등록에 실패했습니다.";
        }
    } catch(Exception e){
        errMsg = "오류: " + e.getMessage();
    }
%>
<% if(!errMsg.isEmpty()) { %>
<div style="color:red; text-align:center; margin-top:20px;"><%=errMsg%></div>
<% } %>
