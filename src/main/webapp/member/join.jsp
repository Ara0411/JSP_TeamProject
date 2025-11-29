<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 | JSP 팀 프로젝트</title>
    <!-- 프로젝트 내부의 /css/style.css 파일 불러오기 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=final">
</head>
<body>
<div class="layout">
    <!-- 상단 header 공통 include -->
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <jsp:include page="/include/menu.jsp" />
        <main class="main">
            <!-- 회원가입 카드 UI -->
            <section class="card" style="max-width: 500px; margin: 40px auto; padding: 40px;">
                <h2 style="text-align: center; margin-bottom: 30px; font-size: 24px;">📝 회원가입</h2>

                <!-- 회원가입 form: join_action.jsp로 POST 방식 전송 -->
                <form action="join_action.jsp" method="post">

                    <!-- 아이디 입력 -->
                    <div style="margin-bottom: 20px;">
                        <label style="display:block; margin-bottom:8px; font-weight:bold; color:#374151;">아이디</label>
                        <input type="text" name="id" required
                               placeholder="사용할 아이디"
                               style="width:100%; padding:12px; border:1px solid #ddd; border-radius:8px; font-size:15px;">
                    </div>
                    <!-- 비밀번호 입력 -->
                    <div style="margin-bottom: 20px;">
                        <label style="display:block; margin-bottom:8px; font-weight:bold; color:#374151;">비밀번호</label>
                        <input type="password" name="pass" required
                               placeholder="비밀번호 (4자리 이상)"
                               style="width:100%; padding:12px; border:1px solid #ddd; border-radius:8px; font-size:15px;">
                    </div>

                    <!-- 이름 입력 -->
                    <div style="margin-bottom: 30px;">
                        <label style="display:block; margin-bottom:8px; font-weight:bold; color:#374151;">이름</label>
                        <input type="text" name="name" required
                               placeholder="본명"
                               style="width:100%; padding:12px; border:1px solid #ddd; border-radius:8px; font-size:15px;">
                    </div>

                    <!-- 가입 버튼 -->
                    <button type="submit" class="btn-primary"
                            style="width:100%; padding:14px; font-size:16px; font-weight:bold; border-radius:8px;">
                        가입하기
                    </button>

                    <!-- 로그인 페이지 링크 -->
                    <div style="margin-top: 20px; text-align: center; font-size: 14px; color:#6b7280;">
                        이미 계정이 있으신가요?
                        <a href="login.jsp" style="color:#2563eb; font-weight:bold; margin-left:5px; text-decoration:underline;">로그인하기</a>
                    </div>
                </form>
            </section>
        </main>
    </div>
    <jsp:include page="/include/footer.jsp" />
</div>
</body>
</html>