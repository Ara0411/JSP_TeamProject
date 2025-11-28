<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // [보안] 로그인 안 했거나, 일반 회원이면 접근 차단
    //세션(Session)에서 'role'이라는 이름표를 가진 데이터를 꺼냄
    String role = (String) session.getAttribute("role");
    // 만약 role이 없거나 ADMIN이 아니라면
    if(role == null || !"ADMIN".equals(role)) {
        // 경고창을 띄우고 이전 페이지로 돌려보냄
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
    <!-- 상단 공통 header -->
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <!-- 좌측 메뉴 include -->
        <jsp:include page="/include/menu.jsp" />
        <main class="main">
            <section class="card">
                <!-- 페이지 제목 -->
                <h2>✏️ 공지사항 작성</h2>
                <!-- 공지 등록 폼: write_proc.jsp 로 POST 요청 -->
                <form action="write_proc.jsp" method="post">
                    <div style="margin-bottom:15px; padding:10px; background:#fff0f0; border-radius:5px;">
                        <label style="cursor:pointer; color:#d9534f; font-weight:bold;">
                            <!-- 체크 시 is_fixed = 'Y' / 미체크 시 null -->
                            <input type="checkbox" name="is_fixed" value="Y"> 🔥 상단 고정 (중요 공지)
                        </label>
                    </div>
                    <!-- 제목 입력 -->
                    <input type="text" name="title" placeholder="제목을 입력하세요" required style="width:100%; padding:10px; margin-bottom:10px; border:1px solid #ddd;">
                    <!-- 내용 입력 -->
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