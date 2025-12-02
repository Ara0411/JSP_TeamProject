<%@ page import="com.example.jsp_pr.dao.BoardFileDAO" %>
<%@ page import="com.example.jsp_pr.dto.BoardFileDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>자료 상세보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="layout">

<%@ include file="/include/header.jsp" %>

<div class="content-wrap">

    <%@ include file="/include/menu.jsp" %>

    <div class="main">

        <%
            int id = Integer.parseInt(request.getParameter("id"));
            BoardFileDAO dao = new BoardFileDAO();
            BoardFileDTO dto = dao.getById(id);
        %>

        <div class="free-view-card">

            <div class="free-view-title"><%= dto.getTitle() %></div>

            <div class="free-view-meta">
                작성자: <span><%= dto.getWriter() %></span> &nbsp;&nbsp;
                등록일: <span><%= dto.getRegdate() %></span> &nbsp;&nbsp;
                다운로드: <span><%= dto.getDownloadcnt() %></span>
            </div>

            <div class="free-view-content">
                <%= dto.getContent() %>
            </div>

            <p style="margin-top:10px;">
                <a class="btn-primary" href="fileDownload.jsp?id=<%=dto.getId()%>">
                    파일 다운로드
                </a>
            </p>

            <%
                // 이미지면 썸네일 표시
                String fname = dto.getFilename().toLowerCase();
                boolean isImg = fname.endsWith(".jpg") || fname.endsWith(".jpeg")
                        || fname.endsWith(".png") || fname.endsWith(".gif");
            %>

            <% if (isImg) { %>
            <p style="margin-top:18px;">
                <img src="<%=dto.getFilepath()%>" style="max-width:100%; border-radius:8px;">
            </p>
            <% } %>

            <p style="margin-top:20px;">
                <button class="btn-outline" onclick="location.href='fileList.jsp'">목록으로</button>
            </p>

        </div>

    </div>

</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
