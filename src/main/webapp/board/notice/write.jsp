<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 로그인 안 했거나 관리자(ADMIN)가 아니면 튕겨내기
    String role = (String) session.getAttribute("role");
    if(role == null || !"ADMIN".equals(role)) {
        out.println("<script>alert('관리자만 작성 가능합니다.'); history.back();</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>공지사항 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=777">
</head>
<body>
<div class="layout">
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <jsp:include page="/include/menu.jsp" />
        <main class="main">
            <section class="card">
                <h2>✏️ 공지사항 작성</h2>
                <form action="write_proc.jsp" method="post">
                    <div style="margin-bottom:15px; padding:10px; background:#fff0f0; border-radius:5px;">
                        <label style="cursor:pointer; color:#d9534f; font-weight:bold;">
                            <input type="checkbox" name="is_fixed" value="Y"> 🔥 상단 고정 (중요 공지)
                        </label>
                    </div>
                    <input type="text" name="title" placeholder="제목을 입력하세요" required style="width:100%; padding:10px; margin-bottom:10px; border:1px solid #ddd;">
                    <textarea name="content" placeholder="내용을 입력하세요" required style="width:100%; height:300px; padding:10px; border:1px solid #ddd;"></textarea>

                    <div style="text-align:right; margin-top:10px;">
                        <a href="list.jsp" class="btn-outline">취소</a>
                        <button type="submit" class="btn-primary">등록</button>
                    </div>
                </form>
            </section>
        </main>
    </div>
    <jsp:include page="/include/footer.jsp" />
</div>
</body>
</html>