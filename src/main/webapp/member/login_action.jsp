<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.MemberDAO" %>
<%@ page import="com.example.jsp_pr.dto.MemberDTO" %>
<%
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");

    MemberDAO dao = new MemberDAO();
    MemberDTO member = dao.login(id, pass);

    if (member != null) {
        // 로그인 성공! 세션에 정보 저장
        session.setAttribute("userId", member.getId());
        session.setAttribute("userName", member.getName());
        session.setAttribute("role", member.getRole()); // 권한 저장 (중요!)
        response.sendRedirect("../index.jsp");
    } else {
        out.println("<script>alert('아이디 또는 비밀번호가 틀렸습니다.'); history.back();</script>");
    }
%>