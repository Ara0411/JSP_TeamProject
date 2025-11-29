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
    <%-- 공통 헤더 포함 --%>
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <%-- 공통 메뉴 포함 --%>
        <jsp:include page="/include/menu.jsp" />

        <main class="main">
            <section class="card">
                <div class="board-header" style="display:flex; justify-content:space-between; margin-bottom:15px;">
                    <h2>📢 공지사항</h2>
                    <%-- 관리자만 글쓰기 버튼이 보이게 할 수도 있지만, 일단은 다 보이게 두고 내부에서 체크 --%>
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
                        // DAO 객체 생성 후 목록 가져오기 요청
                        NoticeDAO dao = new NoticeDAO();
                        List<NoticeDTO> list = dao.getNoticeList();
                        // 가져온 리스트 하나씩 꺼내서 화면에 뿌리기 for문
                        for(NoticeDTO n : list) {
                    %>
                    <tr style="border-bottom:1px solid #eee; height: 40px;">
                        <td><%= n.getId() %></td>
                        <td style="text-align:left; padding-left:10px;">
                            <%-- 제목 클릭 시 상세보기(view.jsp)로 이동 --%>
                            <a href="view.jsp?id=<%= n.getId() %>">
                                <%-- 상단 고정 글('Y')이면 불꽃 아이콘 추가 --%>
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