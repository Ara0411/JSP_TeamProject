<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>JSP 팀 프로젝트</title>

    <%-- webapp/css/style.css --%>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

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
                    <a href="board/noticeList.jsp" class="quick-card">
                        <h3>📢 공지사항</h3>
                        <p>팀 공지와 안내를 확인하세요.</p>
                    </a>
                    <a href="board/freeList.jsp" class="quick-card">
                        <h3>💬 자유게시판</h3>
                        <p>자유롭게 글을 남겨보세요.</p>
                    </a>
                    <a href="board/fileList.jsp" class="quick-card">
                        <h3>📂 자료실</h3>
                        <p>공유 자료를 업로드하고 다운로드하세요.</p>
                    </a>
                </div>
            </section>

            <section class="board-overview">
                <div class="board-card">
                    <div class="board-card-header">
                        <h3>최근 공지사항</h3>
                        <a href="board/noticeList.jsp" class="more-link">전체 보기 &gt;</a>
                    </div>
                    <ul class="board-list">
                        <li>
                            <a href="#">[필독] 프로젝트 진행 일정 안내</a>
                            <span class="date">2025-11-18</span>
                        </li>
                        <li>
                            <a href="#">주차별 할 일 및 역할 분담</a>
                            <span class="date">2025-11-17</span>
                        </li>
                        <li>
                            <a href="#">깃허브 사용 규칙 안내</a>
                            <span class="date">2025-11-15</span>
                        </li>
                    </ul>
                </div>

                <div class="board-card">
                    <div class="board-card-header">
                        <h3>최근 자유게시판</h3>
                        <a href="board/freeList.jsp" class="more-link">전체 보기 &gt;</a>
                    </div>
                    <ul class="board-list">
                        <li>
                            <a href="#">JSP 설정하다 막힌 사람 있나요?</a>
                            <span class="date">2025-11-19</span>
                        </li>
                        <li>
                            <a href="#">오늘 회의 내용 정리했습니다</a>
                            <span class="date">2025-11-18</span>
                        </li>
                        <li>
                            <a href="#">다음주 모임 시간 조율해요</a>
                            <span class="date">2025-11-18</span>
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
