<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.MemberDAO" %>
<%@ page import="com.example.jsp_pr.dto.MemberDTO" %>
<%
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");

    MemberDAO dao = new MemberDAO();
    // ID와 비번이 일치하는 회원을 찾음
    MemberDTO member = dao.login(id, pass);

    if (member != null) {
        // (로그인 성공) 세션에 정보 저장
        session.setAttribute("userId", member.getId()); // 아이디
        session.setAttribute("userName", member.getName()); // 이름 (환영 메시지용)
        session.setAttribute("role", member.getRole()); // 권한 (관리자 체크용)
        response.sendRedirect("../index.jsp");// 메인으로 이동
    } else {
        // (로그인 실패)
        out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); history.back();</script>");
    }
%>