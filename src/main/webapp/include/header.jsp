<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="header">
    <div class="header-left">
        <a href="<%= request.getContextPath() %>/index.jsp" class="logo">
            JSP 팀 프로젝트
        </a>
        <span class="logo-sub">Board System</span>
    </div>

    <div class="header-right">
        <%
            String userName = (String) session.getAttribute("userName");
            if (userName != null) {
        %>
        <span class="user-info"><%= userName %> 님 환영합니다</span>
        <a href="<%= request.getContextPath() %>/member/logout.jsp" class="btn-outline">로그아웃</a>
        <%  } else { %>
        <a href="<%= request.getContextPath() %>/member/login.jsp" class="btn-outline">로그인</a>
        <a href="<%= request.getContextPath() %>/member/join.jsp" class="btn-primary">회원가입</a>
        <%  } %>
    </div>
</header>
