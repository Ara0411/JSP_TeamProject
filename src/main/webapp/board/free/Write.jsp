<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<%--
    [주석 작성자] 최아라
    [파일 역할] 자유게시판 글쓰기 화면
    [주요 기능]
      - 세션에 로그인된 사용자(userId)가 없으면 로그인 페이지로 강제 이동
      - 로그인한 사용자만 제목/내용을 입력해서 글을 등록할 수 있는 화면 제공
      - 등록 버튼 클릭 시 WriteAction.jsp로 POST 요청 전송
 --%>

<%
    // 세션에서 로그인한 사용자 아이디를 꺼낸다.
    // 로그인 시 session.setAttribute("userId", 로그인아이디)로 저장해 두었다고 가정.
    String userId = (String) session.getAttribute("userId");

    // 로그인하지 않은 사용자는 자유게시판 글쓰기 화면에 접근할 수 없도록 바로 로그인 페이지로 보낸다.
    if(userId == null){
        // 상대 경로 기준으로 member/login.jsp로 리다이렉트
        // (프로젝트 구조에 따라 경로는 필요 시 조정 가능)
        response.sendRedirect("../member/login.jsp");
        return; // 더 이상 아래 JSP가 실행되지 않도록 즉시 종료
    }
%>


<main class="main">
    <section class="free-write-card">
        <h2>자유글 작성</h2>
        <%--
            글쓰기 폼
            - method="post"로 WriteAction.jsp에게 제목/내용 전달
            - 작성자(writer)는 화면에서 받지 않고, 서버에서 세션 값(userId)을 사용함
        --%>
        <form action="WriteAction.jsp" method="post" class="free-write-form">
            <label for="input-title">제목</label>
            <input type="text" id="input-title" name="title" placeholder="제목을 입력하세요" required />

            <label for="input-content">내용</label>
            <textarea id="input-content" name="content" rows="6" placeholder="내용을 작성해 주세요" required></textarea>

            <button type="submit" class="btn-primary">등록</button>
        </form>
    </section>
</main>
<%@ include file="../../include/footer.jsp" %>
