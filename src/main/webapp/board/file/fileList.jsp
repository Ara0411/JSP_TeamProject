<%@ page import="java.util.List" %>
<%@ page import="com.example.jsp_pr.dao.BoardFileDAO" %>
<%@ page import="com.example.jsp_pr.dto.BoardFileDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    [주석 작성자] 최아라
    [파일 역할] 자료실(파일 게시판) 목록 페이지
    [주요 기능]
      - BoardFileDAO를 통해 board_file 테이블에서 자료 목록 조회
      - 제목 리스트와 함께 각 자료의 다운로드 횟수를 표시
      - 글쓰기 버튼을 통해 fileWrite.jsp로 이동 (새 자료 등록)
 --%>

<!DOCTYPE html>
<html>
<head>
    <title>자료실 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="layout">

<%@ include file="/include/header.jsp" %>

<div class="content-wrap">

    <%@ include file="/include/menu.jsp" %>

    <div class="main">
        <%-- 상단 카드: 자료실 제목 + 글쓰기 버튼 --%>
        <div class="card" style="padding:22px;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h2 style="font-size:18px; font-weight:700;">📁 자료실 / 갤러리</h2>
                <%-- 새 자료 등록을 위한 글쓰기 버튼 --%>
                <button class="btn-primary" onclick="location.href='fileWrite.jsp'">글쓰기</button>
            </div>
        </div>

        <%
            // DAO를 이용하여 전체 자료 목록을 가져온다.
            BoardFileDAO dao = new BoardFileDAO();
            List<BoardFileDTO> list = dao.getList();
        %>

        <%-- 실제 자료 목록을 표시하는 카드 --%>
        <div class="card" style="margin-top:16px;">
            <ul class="board-list">
                <% if (list != null) {
                    for (BoardFileDTO dto : list) { %>

                <li>
                    <%-- 제목 클릭 시 상세보기(fileView.jsp)로 이동, id를 쿼리스트링으로 전달 --%>
                    <a href="fileView.jsp?id=<%= dto.getId()%>">
                        <%= dto.getTitle() %>
                    </a>
                    <%-- 다운로드 횟수를 오른쪽에 표시 --%>
                    <span class="date">
                        다운로드: <%= dto.getDownloadcnt() %>
                    </span>
                </li>

                <% }} %>
            </ul>
        </div>

    </div>

</div>

<%@ include file="/include/footer.jsp" %>

</body>
</html>
