<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>

<%
    String userId = (String) session.getAttribute("userId");
    if(userId == null){
        response.sendRedirect("../member/login.jsp");
        return;
    }
%>


<%
    String sid = request.getParameter("id");
    if(sid == null || sid.trim().isEmpty()){
%>
<div style="color:red;">ERROR: id 값이 없습니다.</div>
<%
        return;
    }
    try {
        int id = Integer.parseInt(sid);
        Connection conn = DBUtill.getConnection();
        PreparedStatement ps = conn.prepareStatement("DELETE FROM board_free WHERE id=?");
        ps.setInt(1, id);
        int result = ps.executeUpdate();
        ps.close(); conn.close();

        if(result > 0){
            response.sendRedirect("List.jsp");
            return;
        } else {
%>
<div style="color:red; text-align:center;">삭제 실패</div>
<%
    }
} catch(Exception e){
%>
<div style="color:red; text-align:center;">오류: <%= e.getMessage()%></div>
<%
    }
%>
