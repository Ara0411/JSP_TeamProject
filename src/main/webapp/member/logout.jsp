<%
    session.invalidate(); // 세션에 저장된 모든 정보 삭제 (로그아웃 처리)
    response.sendRedirect("../index.jsp"); // 메인 페이지로 튕기기
%>