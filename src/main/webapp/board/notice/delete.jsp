<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%
    // 1. 보안 체크: 관리자가 아니면 쫓아내기
    String role = (String) session.getAttribute("role");
    if (role == null || !"ADMIN".equals(role)) {
        out.println("<script>alert('관리자만 삭제할 수 있습니다.'); history.back();</script>");
        return;
    }

    // 2. 삭제 로직 수행
    String idStr = request.getParameter("id");
    if(idStr != null) {
        int id = Integer.parseInt(idStr);
        NoticeDAO dao = new NoticeDAO();
        dao.deleteNotice(id); // 아까 만든 메소드 호출
    }

    // 3. 목록으로 이동
    response.sendRedirect("list.jsp");
%>