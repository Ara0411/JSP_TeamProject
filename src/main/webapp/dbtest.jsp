<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>
<%
    Connection conn = null;
    try {
        conn = DBUtill.getConnection();
        if (conn != null) {
            out.println("<h3>DB 연결 성공 ✅</h3>");
        } else {
            out.println("<h3>DB 연결 실패 ❌</h3>");
        }
    } catch (Exception e) {
        out.println(e.getMessage());
    } finally {
        if (conn != null) conn.close();
    }
%>
