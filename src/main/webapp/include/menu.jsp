<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    [주석 작성자] 최아라
    [파일 역할] 공통 사이드바 메뉴(include)
    [주요 기능]
      - 메인/공지사항/자유게시판/자료실로 이동하는 좌측 메뉴 제공
      - "빠른 링크" 영역에서 자주 쓰는 쓰기 페이지로 바로 이동할 수 있도록 링크 제공
      - request.getContextPath()를 사용해 배포 경로가 바뀌어도 정상 동작하도록 구현
 --%>

<nav class="sidebar">
    <h3 class="sidebar-title">메뉴</h3>
    <ul class="menu-list">
        <%-- 메인 페이지 이동 --%>
        <li><a href="<%= request.getContextPath() %>/index.jsp">🏠 메인</a></li>
        <%-- 공지사항 목록 페이지 --%>
        <li><a href="<%= request.getContextPath() %>/board/notice/list.jsp">📢 공지사항</a></li>
        <%-- 자유게시판 목록 페이지 --%>
        <li><a href="<%= request.getContextPath() %>/board/free/List.jsp">💬 자유게시판</a></li>
        <%-- 자료실(파일 게시판) 목록 페이지 --%>
        <li><a href="<%= request.getContextPath() %>/board/file/fileList.jsp">📂 자료실</a></li>
    </ul>

    <div class="sidebar-section">
        <h4>빠른 링크</h4>
        <ul class="quick-links">
            <%-- 공지사항 새 글 작성 --%>
            <li><a href="<%= request.getContextPath() %>/board/notice/write.jsp">공지 작성</a></li>
            <%-- 자유게시판 새 글 작성 (Write.jsp) --%>
            <li><a href="<%= request.getContextPath() %>/board/free/Write.jsp">자유글 작성</a></li>
        </ul>
    </div>
</nav>
