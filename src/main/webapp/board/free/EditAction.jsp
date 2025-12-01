<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>

<%
    String userId = (String) session.getAttribute("userId");
    if(userId == null){
        response.sendRedirect("../member/login.jsp");
        return;
    }
%>


<%

    try {
        String sid = request.getParameter("id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String writer = request.getParameter("writer");

        // 필수 파라미터 체크
        if(sid == null || sid.trim().isEmpty() ||
                title == null || title.trim().isEmpty() ||
                content == null || content.trim().isEmpty() ||
                writer == null || writer.trim().isEmpty()) {
%>
<div style="color:red; text-align:center;">필수 항목이 누락되었습니다.</div>
<%
} else {
    int id = Integer.parseInt(sid);

    Connection conn = DBUtill.getConnection();
    PreparedStatement ps = conn.prepareStatement(
            "UPDATE board_free SET title=?, content=?, writer=? WHERE id=?"
    );
    ps.setString(1, title);
    ps.setString(2, content);
    ps.setString(3, writer);
    ps.setInt(4, id);

    int result = ps.executeUpdate();
    ps.close(); conn.close();

    if(result > 0){
        response.sendRedirect("View.jsp?id=" + id);
        return;
    } else {
%>
<div style="color:red; text-align:center; margin-top:20px;">수정 실패</div>
<%
        }
    }
} catch(Exception e){
%>
<div style="color:red; text-align:center; margin-top:20px;">오류: <%= e.getMessage()%></div>
<%
    }
%>
