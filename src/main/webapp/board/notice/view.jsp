<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%@ page import="com.example.jsp_pr.dto.NoticeDTO" %>
<%
    // 1. 주소창에서 글 번호(id) 가져오기
    String idStr = request.getParameter("id");
    if(idStr == null || idStr.equals("")){
        response.sendRedirect("list.jsp");
        return;
    }
    int id = Integer.parseInt(idStr);

    // 2. DB에서 글 내용 가져오기
    NoticeDAO dao = new NoticeDAO();
    NoticeDTO dto = dao.getNoticeDetail(id);

    if(dto == null) {
        out.println("<script>alert('삭제된 글입니다.'); location.href='list.jsp';</script>");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><%= dto.getTitle() %></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=777">
</head>
<body>
<div class="layout">
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <jsp:include page="/include/menu.jsp" />

        <main class="main">
            <section class="card">
                <div style="border-bottom:1px solid #eee; padding-bottom:15px; margin-bottom:20px;">
                    <h2 style="font-size:24px; margin-bottom:10px;">
                        <%= "Y".equals(dto.getIs_fixed()) ? "<span style='color:red'>[중요]</span>" : "" %>
                        <%= dto.getTitle() %>
                    </h2>
                    <div class="text-muted">
                        <span>작성자: <%= dto.getWriter() %></span>
                        <span style="margin:0 10px;">|</span>
                        <span>날짜: <%= dto.getRegdate() %></span>
                        <span style="margin:0 10px;">|</span>
                        <span>조회수: <%= dto.getViewcnt() %></span>
                    </div>
                </div>

                <div style="min-height:300px; line-height:1.6; margin-bottom:30px;">
                    <%= dto.getContent().replace("\n", "<br>") %>
                </div>

                <div style="text-align:right; border-top:1px solid #eee; padding-top:20px;">
                    <a href="list.jsp" class="btn-outline" style="color:#333;">목록</a>

                    <%
                        // 세션에서 권한(role) 가져오기
                        String role = (String) session.getAttribute("role");

                        // 관리자(ADMIN)일 때만 삭제 버튼 표시
                        if ("ADMIN".equals(role)) {
                    %>
                    <a href="delete.jsp?id=<%= dto.getId() %>" class="btn-primary"
                       style="background:#dc3545; border-color:#dc3545; margin-left:5px;"
                       onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                    <%
                        }
                    %>
                </div>
            </section>
        </main>
    </div>
    <jsp:include page="/include/footer.jsp" />
</div>
</body>
</html>