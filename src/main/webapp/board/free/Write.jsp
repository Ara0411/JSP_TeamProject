<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../include/header.jsp" %>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<%
    String userId = (String) session.getAttribute("userId");
    if(userId == null){
        response.sendRedirect("../member/login.jsp"); // login.jsp 경로는 프로젝트에 맞게 수정!
        return;
    }
%>


<main class="main">
    <section class="free-write-card">
        <h2>자유글 작성</h2>
        <form action="WriteAction.jsp" method="post" class="free-write-form">
            <label for="input-title">제목</label>
            <input type="text" id="input-title" name="title" placeholder="제목을 입력하세요" required />

            <label for="input-content">내용</label>
            <textarea id="input-content" name="content" rows="6" placeholder="내용을 작성해 주세요" required></textarea>

            <label for="input-writer">작성자</label>
            <input type="text" id="input-writer" name="writer" placeholder="이름 또는 별명" required />

            <button type="submit" class="btn-primary">등록</button>
        </form>
    </section>
</main>
<%@ include file="../../include/footer.jsp" %>
