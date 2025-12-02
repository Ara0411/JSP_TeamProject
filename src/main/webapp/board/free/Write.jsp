<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>   <%-- 페이지 인코딩 및 콘텐츠 타입 설정 --%>
<%@ include file="../../include/header.jsp" %>                             <%-- 공통 헤더 영역 포함 --%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"> <%-- 공통 스타일시트 연결 --%>

<%
    String userId = (String) session.getAttribute("userId");     // 세션에서 로그인한 사용자 ID 가져오기
    if(userId == null){                                         // 로그인하지 않은 경우
        response.sendRedirect("../member/login.jsp");           // 로그인 페이지로 리다이렉트
        return;                                                 // 이후 글쓰기 화면 표시 중단
    }
%>

<main class="main">
    <section class="free-write-card">
        <h2>자유글 작성</h2>                                   <%-- 자유게시판 글쓰기 화면 제목 --%>
        <form action="WriteAction.jsp" method="post" class="free-write-form"> <%-- 글 등록 처리용 폼 (POST 전송) --%>
            <label for="input-title">제목</label>
            <input type="text" id="input-title" name="title"
                   placeholder="제목을 입력하세요" required />   <%-- 글 제목 입력 필드 --%>

            <label for="input-content">내용</label>
            <textarea id="input-content" name="content" rows="6"
                      placeholder="내용을 작성해 주세요" required></textarea> <%-- 글 내용 입력 필드 --%>

            <button type="submit" class="btn-primary">등록</button> <%-- 작성한 글을 서버로 전송하는 버튼 --%>
        </form>
    </section>
</main>

<%@ include file="../../include/footer.jsp" %>                             <%-- 공통 푸터 영역 포함 --%>
