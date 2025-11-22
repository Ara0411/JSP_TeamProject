<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- ▼▼▼ [핵심] CSS 파일이 안 먹혀서, 여기에 스타일을 직접 넣습니다 (무조건 적용됨) ▼▼▼ --%>
<style>
    /* 사이드바 메뉴 (왼쪽) */
    .menu-box {
        width: 220px !important;
        min-width: 220px !important;
        flex-shrink: 0;
        background: #ffffff !important; /* 흰색 배경 강제 */
        border: 1px solid #e5e7eb !important;
        border-radius: 18px !important; /* 둥글게 */
        padding: 24px !important;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.02) !important;
    }

    .menu-box h3 {
        font-size: 15px !important;
        font-weight: 700 !important;
        color: #111827 !important;
        margin-bottom: 12px !important;
        margin-top: 0 !important;
    }

    .menu-box ul {
        list-style: none !important;
        padding: 0 !important;
        margin: 0 0 24px 0 !important;
    }

    .menu-box li {
        margin-bottom: 6px !important;
    }

    .menu-box a {
        display: flex !important;
        align-items: center !important;
        gap: 12px !important;
        padding: 10px 12px !important;
        border-radius: 8px !important;
        font-size: 15px !important;
        color: #4b5563 !important;
        text-decoration: none !important;
        font-weight: 500 !important;
        background-color: transparent;
        transition: all 0.2s;
    }

    .menu-box a:hover {
        background: #f3f4f6 !important;
        color: #2563eb !important;
        transform: translateX(3px);
    }

    .quick-menu-title {
        margin-top: 20px !important;
        border-top: 1px solid #e5e7eb !important;
        padding-top: 20px !important;
    }
</style>

<%-- ▼▼▼ HTML 태그의 클래스 이름을 'menu-box'로 통일했습니다 ▼▼▼ --%>
<aside class="menu-box">
    <h3>메뉴</h3>
    <ul>
        <li><a href="<%= request.getContextPath() %>/index.jsp">🏠 메인</a></li>
        <li><a href="<%= request.getContextPath() %>/board/notice/list.jsp">📢 공지사항</a></li>
        <li><a href="<%= request.getContextPath() %>/board/free/list.jsp">💬 자유게시판</a></li>
        <li><a href="<%= request.getContextPath() %>/board/file/list.jsp">📂 자료실</a></li>
        <li><a href="#">❓ Q&A</a></li>
    </ul>

    <h3 class="quick-menu-title">빠른 링크</h3>
    <ul>
        <li><a href="<%= request.getContextPath() %>/board/notice/write.jsp">공지 작성</a></li>
        <li><a href="<%= request.getContextPath() %>/board/free/write.jsp">자유글 작성</a></li>
    </ul>
</aside>