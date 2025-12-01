<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<nav class="sidebar">
    <h3 class="sidebar-title">메뉴</h3>
    <ul class="menu-list">
        <li><a href="<%= request.getContextPath() %>/index.jsp">🏠 메인</a></li>
        <li><a href="<%= request.getContextPath() %>/board/notice/list.jsp">📢 공지사항</a></li>
        <li><a href="<%= request.getContextPath() %>/board/free/List.jsp">💬 자유게시판</a></li>
        <li><a href="<%= request.getContextPath() %>/board/file/list.jsp">📂 자료실</a></li>
        <li><a href="<%= request.getContextPath() %>/board/qna/list.jsp">❓ Q&amp;A</a></li>
    </ul>

    <div class="sidebar-section">
        <h4>빠른 링크</h4>
        <ul class="quick-links">
            <li><a href="<%= request.getContextPath() %>/board/notice/write.jsp">공지 작성</a></li>
            <li><a href="<%= request.getContextPath() %>/board/free/Write.jsp">자유글 작성</a></li>
        </ul>
    </div>
</nav>
