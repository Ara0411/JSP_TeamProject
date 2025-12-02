<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
    [주석 작성자] 최아라
    [파일 역할] 자료실 글쓰기 + 파일 업로드 화면
    [주요 기능]
      - 제목/내용/첨부파일을 입력받는 폼 구성
      - enctype="multipart/form-data"로 파일 업로드 가능하도록 설정
      - action을 파일 업로드 전용 서블릿(/board/file/upload)으로 보내서 서버에서 실제 저장 처리
 --%>
<!DOCTYPE html>
<html>
<head>
    <title>자료 업로드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="layout">

<%@ include file="/include/header.jsp" %>

<div class="content-wrap">
    <%@ include file="/include/menu.jsp" %>

    <div class="main">

        <div class="free-write-card">

            <h2 style="margin-bottom:18px; color:#3556e4;">📤 자료 등록</h2>

            <%--
                파일 업로드 폼
                 - action: 서블릿 매핑 경로 (/board/file/upload)
                 - method: POST
                 - enctype: multipart/form-data (파일 업로드 시 필수)
            --%>

            <form class="free-write-form"
                  action="${pageContext.request.contextPath}/board/file/upload"
                  method="post"
                  enctype="multipart/form-data">

                <label>제목</label>
                <input type="text" name="title" required>

                <label>내용</label>
                <textarea name="content"></textarea>

                <label>파일 첨부</label>
                <input type="file" name="uploadFile" required>

                <button class="btn-primary" type="submit">등록하기</button>
            </form>

        </div>

    </div>
</div>

<%@ include file="/include/footer.jsp" %>
</body>
</html>
