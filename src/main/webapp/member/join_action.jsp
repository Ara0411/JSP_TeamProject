<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.MemberDAO" %>
<%@ page import="com.example.jsp_pr.dto.MemberDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    // 파라미터 수신
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");
    String name = request.getParameter("name");

    // DTO에 데이터 담기
    MemberDTO dto = new MemberDTO();
    dto.setId(id);
    dto.setPass(pass);
    dto.setName(name);
    // role은 DAO에서 자동으로 'USER'(일반회원)로 넣도록 되어 있음

    // DB 저장 시도
    MemberDAO dao = new MemberDAO();
    int result = dao.join(dto);

    if (result > 0) {
        out.println("<script>alert('가입 성공! 로그인해주세요.'); location.href='login.jsp';</script>");
    } else {
        out.println("<script>alert('가입 실패! (아이디 중복 등)'); history.back();</script>");
    }
%>