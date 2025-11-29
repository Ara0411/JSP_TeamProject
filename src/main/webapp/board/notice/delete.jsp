<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%
    // 1. 보안 체크: 관리자가 아니면 쫓아내기
    // 세션에서 권한(role)을 꺼내서 관리자가 아니면 쫓아냄
    String role = (String) session.getAttribute("role");
    if (role == null || !"ADMIN".equals(role)) {
        out.println("<script>alert('관리자만 삭제할 수 있습니다.'); history.back();</script>");
        return;
    }

    // 2. 삭제할 글 번호 받기
    String idStr = request.getParameter("id");
    if(idStr != null) {
        int id = Integer.parseInt(idStr);
        // 3. DAO를 통해 DB에서 해당 글 삭제
        NoticeDAO dao = new NoticeDAO();
        dao.deleteNotice(id);
    }

    // 4. 삭제 후 목록 페이지로 이동
    response.sendRedirect("list.jsp");
%>