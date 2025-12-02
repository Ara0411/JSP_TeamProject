<%@ page import="com.example.jsp_pr.dao.BoardFileDAO" %>
<%@ page import="com.example.jsp_pr.dto.BoardFileDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%--
    [주석 작성자] 최아라
    [파일 역할] 자료실 상세보기 페이지
    [주요 기능]
      - URL의 id 파라미터를 이용해 특정 자료(board_file) 상세 정보 조회
      - 제목, 작성자, 등록일, 다운로드 수, 내용 등을 표시
      - 파일 다운로드 버튼 제공 (fileDownload.jsp로 이동)
      - 이미지 파일(jpg, png, gif 등)인 경우 본문에 썸네일 미리보기
 --%>

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
            // 쿼리스트링으로 넘어온 id 파라미터를 정수형으로 변환
            int id = Integer.parseInt(request.getParameter("id"));

            // DAO를 통해 해당 id의 자료 상세 정보 조회
            BoardFileDAO dao = new BoardFileDAO();
            BoardFileDTO dto = dao.getById(id);
        %>

        <div class="free-view-card">
            <%-- 자료 제목 --%>
            <div class="free-view-title"><%= dto.getTitle() %></div>

            <%-- 작성자, 등록일, 다운로드 수 메타 정보 표시 --%>
            <div class="free-view-meta">
                작성자: <span><%= dto.getWriter() %></span> &nbsp;&nbsp;
                등록일: <span><%= dto.getRegdate() %></span> &nbsp;&nbsp;
                다운로드: <span><%= dto.getDownloadcnt() %></span>
            </div>

             <%-- 본문 내용 --%>
            <div class="free-view-content">
                <%= dto.getContent() %>
            </div>

            <%-- 파일 다운로드 버튼: fileDownload.jsp에 id를 넘겨 실제 파일을 내려받도록 함 --%>
            <p style="margin-top:10px;">
                <a class="btn-primary" href="fileDownload.jsp?id=<%=dto.getId()%>">
                    파일 다운로드
                </a>
            </p>

            <%
                // 파일명이 이미지 확장자인지 확인하여 썸네일 표시 여부 결정
                String fname = dto.getFilename().toLowerCase();
                boolean isImg = fname.endsWith(".jpg") || fname.endsWith(".jpeg")
                        || fname.endsWith(".png") || fname.endsWith(".gif");
            %>

            <% if (isImg) { %>
            <%-- 이미지 파일인 경우, 업로드 시 저장해 둔 웹경로(filepath)를 이용해 썸네일 표시 --%>
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
