<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%@ page import="com.example.jsp_pr.dto.NoticeDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인한 사람 아이디 가져오기
    String writer = (String) session.getAttribute("userId");
    if(writer == null) writer = "unknown"; // 비상용

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String isFixed = request.getParameter("is_fixed"); // 체크하면 "Y", 안하면 null

    NoticeDTO dto = new NoticeDTO();
    dto.setTitle(title);
    dto.setContent(content);
    dto.setWriter(writer);
    dto.setIs_fixed(isFixed);

    NoticeDAO dao = new NoticeDAO();
    dao.insertNotice(dto);

    response.sendRedirect("list.jsp");
%>