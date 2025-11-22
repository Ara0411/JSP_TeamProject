<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=777">
</head>
<body>
<div class="layout">
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <jsp:include page="/include/menu.jsp" />
        <main class="main">
            <section class="card" style="max-width:500px; margin:0 auto;">
                <h2 style="text-align:center;">📝 회원가입</h2>
                <form action="join_action.jsp" method="post">
                    <div style="margin-bottom:10px;">
                        <label>아이디</label>
                        <input type="text" name="id" required style="width:100%; padding:10px; border:1px solid #ddd;">
                    </div>
                    <div style="margin-bottom:10px;">
                        <label>비밀번호</label>
                        <input type="password" name="pass" required style="width:100%; padding:10px; border:1px solid #ddd;">
                    </div>
                    <div style="margin-bottom:20px;">
                        <label>이름</label>
                        <input type="text" name="name" required style="width:100%; padding:10px; border:1px solid #ddd;">
                    </div>
                    <button type="submit" class="btn-primary" style="width:100%;">가입하기</button>
                </form>
            </section>
        </main>
    </div>
    <jsp:include page="/include/footer.jsp" />
</div>
</body>
</html>