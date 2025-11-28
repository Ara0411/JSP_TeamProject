<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 | JSP 팀 프로젝트</title>
    <!-- 공용 CSS 불러오기-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=final">
</head>
<body>
<div class="layout">

    <!-- 상단 헤더 include -->
    <jsp:include page="/include/header.jsp" />
    <div class="content-wrap">
        <!-- 좌측 메뉴 include -->
        <jsp:include page="/include/menu.jsp" />
        <main class="main">
            <!-- 로그인 UI 카드 영역 -->
            <section class="card" style="max-width: 500px; margin: 40px auto; padding: 40px;">
                <!-- 페이지 제목 -->
                <h2 style="text-align: center; margin-bottom: 30px; font-size: 24px;">🔒 로그인</h2>

                <!-- 로그인 form: login_action.jsp로 POST 방식 요청 -->
                <form action="login_action.jsp" method="post">
                    <!-- 아이디 입력 -->
                    <div style="margin-bottom: 20px;">
                        <label style="display:block; margin-bottom:8px; font-weight:bold; color:#374151;">아이디</label>
                        <input type="text" name="id" required
                               placeholder="아이디를 입력하세요"
                               style="width:100%; padding:12px; border:1px solid #ddd; border-radius:8px; font-size:15px;">
                    </div>

                    <!-- 비밀번호 입력 -->
                    <div style="margin-bottom: 30px;">
                        <label style="display:block; margin-bottom:8px; font-weight:bold; color:#374151;">비밀번호</label>
                        <input type="password" name="pass" required
                               placeholder="비밀번호를 입력하세요"
                               style="width:100%; padding:12px; border:1px solid #ddd; border-radius:8px; font-size:15px;">
                    </div>

                    <!-- 로그인 버튼 -->
                    <button type="submit" class="btn-primary"
                            style="width:100%; padding:14px; font-size:16px; font-weight:bold; border-radius:8px;">
                        로그인
                    </button>

                    <!-- 회원가입 페이지 링크 -->
                    <div style="margin-top: 20px; text-align: center; font-size: 14px; color:#6b7280;">
                        계정이 없으신가요?
                        <a href="join.jsp" style="color:#2563eb; font-weight:bold; margin-left:5px; text-decoration:underline;">회원가입하기</a>
                    </div>
                </form>
            </section>
        </main>
    </div>
    <!-- 하단 footer include -->
    <jsp:include page="/include/footer.jsp" />
</div>
</body>
</html>