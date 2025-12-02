<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

            <!-- ★★ 여기서 action이 서블릿으로 가는 게 핵심 ★★ -->
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
