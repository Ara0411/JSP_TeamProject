<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%@ page import="com.example.jsp_pr.dto.NoticeDTO" %>
<%
    // 한글 깨짐 방지
    request.setCharacterEncoding("UTF-8");

    // 세션에서 로그인한 사람 아이디 가져오기
    String writer = (String) session.getAttribute("userId");
    if(writer == null) writer = "unknown"; // 비상용

    // 폼에서 넘어온 데이터 받기
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String isFixed = request.getParameter("is_fixed"); // 체크박스 체크하면 "Y", 안하면 null

    // DTO에 데이터 포장
    NoticeDTO dto = new NoticeDTO();
    dto.setTitle(title);
    dto.setContent(content);
    dto.setWriter(writer);
    dto.setIs_fixed(isFixed);

    // DAO를 통해 DB에 저장
    NoticeDAO dao = new NoticeDAO();
    dao.insertNotice(dto);

    // 저장 완료 후 목록으로 이동
    response.sendRedirect("list.jsp");
%>