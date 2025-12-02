<%@ page import="java.util.List" %>
<%@ page import="com.example.jsp_pr.dao.BoardFileDAO" %>
<%@ page import="com.example.jsp_pr.dto.BoardFileDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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

        <div class="card" style="padding:22px;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h2 style="font-size:18px; font-weight:700;">📁 자료실 / 갤러리</h2>
                <button class="btn-primary" onclick="location.href='fileWrite.jsp'">글쓰기</button>
            </div>
        </div>

        <%
            BoardFileDAO dao = new BoardFileDAO();
            List<BoardFileDTO> list = dao.getList();
        %>

        <div class="card" style="margin-top:16px;">
            <ul class="board-list">
                <% if (list != null) {
                    for (BoardFileDTO dto : list) { %>

                <li>
                    <a href="fileView.jsp?id=<%= dto.getId()%>">
                        <%= dto.getTitle() %>
                    </a>
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
