<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%@ page import="com.example.jsp_pr.dto.NoticeDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=777">
</head>
<body>
<div class="layout">
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <jsp:include page="/include/menu.jsp" />

        <main class="main">
            <section class="card">
                <div class="board-header" style="display:flex; justify-content:space-between; margin-bottom:15px;">
                    <h2>📢 공지사항</h2>
                    <a href="write.jsp" class="btn-primary">글쓰기</a>
                </div>

                <table style="width:100%; border-collapse:collapse; text-align:center;">
                    <tr style="background:#f9fafb; border-bottom:2px solid #eee; height: 40px;">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>날짜</th>
                    </tr>
                    <%
                        NoticeDAO dao = new NoticeDAO();
                        List<NoticeDTO> list = dao.getNoticeList();
                        for(NoticeDTO n : list) {
                    %>
                    <tr style="border-bottom:1px solid #eee; height: 40px;">
                        <td><%= n.getId() %></td>
                        <td style="text-align:left; padding-left:10px;">
                            <a href="view.jsp?id=<%= n.getId() %>">
                                <%= "Y".equals(n.getIs_fixed()) ? "🔥" : "" %> <%= n.getTitle() %>
                            </a>
                        </td>
                        <td><%= n.getWriter() %></td>
                        <td><%= n.getRegdate() %></td>
                    </tr>
                    <% } %>
                </table>
            </section>
        </main>
    </div>
    <jsp:include page="/include/footer.jsp" />
</div>
</body>
</html>