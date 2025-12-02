<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.jsp_pr.dao.NoticeDAO" %>
<%@ page import="com.example.jsp_pr.dto.NoticeDTO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>JSP 팀 프로젝트</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=final">
</head>
<body>
<div class="layout">
    <jsp:include page="include/header.jsp" />

    <div class="content-wrap">
        <jsp:include page="include/menu.jsp" />

        <main class="main">
            <section class="welcome-section">
                <h2>환영합니다 👋</h2>
                <p class="welcome-text">
                    이곳은 JSP 팀 프로젝트 게시판 사이트의 메인 페이지입니다.<br>
                    상단 메뉴와 사이드 메뉴를 이용해 각 게시판으로 이동할 수 있어요.
                </p>

                <div class="quick-actions">
                    <a href="board/notice/list.jsp" class="quick-card">
                        <h3>📢 공지사항</h3>
                        <p>팀 공지와 안내를 확인하세요.</p>
                    </a>
                    <a href="board/free/List.jsp" class="quick-card">
                        <h3>💬 자유게시판</h3>
                        <p>자유롭게 글을 남겨보세요.</p>
                    </a>
                    <a href="board/file/fileList.jsp" class="quick-card">
                        <h3>📂 자료실</h3>
                        <p>공유 자료를 업로드하고 다운로드하세요.</p>
                    </a>
                </div>
            </section>

            <section class="board-overview">
                <div class="board-card">
                    <div class="board-card-header">
                        <h3>최근 공지사항</h3>
                        <a href="board/notice/list.jsp" class="more-link">전체 보기 &gt;</a>
                    </div>
                    <ul class="board-list">
                        <%
                            // NoticeDAO를 사용해 DB에서 최신 공지 5개를 가져옴
                            NoticeDAO noticeDao = new NoticeDAO();
                            List<NoticeDTO> noticeList = noticeDao.getNoticeList();

                            if (noticeList == null || noticeList.isEmpty()) {
                        %>
                        <li style="text-align:center; color:#999; padding:10px;">등록된 공지사항이 없습니다.</li>
                        <%
                        } else {
                            int limit = Math.min(noticeList.size(), 5);
                            for (int i = 0; i < limit; i++) {
                                NoticeDTO n = noticeList.get(i);
                        %>
                        <li>
                            <a href="board/notice/view.jsp?id=<%= n.getId() %>">
                                <%= "Y".equals(n.getIs_fixed()) ? "🔥" : "" %>
                                <%= n.getTitle() %>
                            </a>
                            <span class="date"><%= n.getRegdate().toString().substring(0, 10) %></span>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>

                <div class="board-card">
                    <div class="board-card-header">
                        <h3>최근 자유게시판</h3>
                        <a href="board/free/List.jsp" class="more-link">전체 보기 &gt;</a>
                    </div>
                    <ul class="board-list">
                        <li>
                            <a href="#">자유게시판 글은 목록에서 확인하세요.</a>
                            <span class="date">2025-11-22</span>
                        </li>
                    </ul>
                </div>
            </section>
        </main>
    </div>

    <jsp:include page="include/footer.jsp" />
</div>
</body>
</html>