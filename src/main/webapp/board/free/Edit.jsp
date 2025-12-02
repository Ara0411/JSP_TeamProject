<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>   <%-- 페이지 인코딩 및 콘텐츠 타입 설정 --%>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>           <%-- JDBC와 DB 연결 유틸 import --%>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css"> <%-- 공통 스타일시트 연결 --%>

<%
    String userId = (String) session.getAttribute("userId");     // 세션에서 로그인한 사용자 ID 가져오기
    if(userId == null){                                         // 로그인되어 있지 않으면
        response.sendRedirect("../member/login.jsp");           // 로그인 페이지로 리다이렉트
        return;                                                 // 이후 수정 화면 표시 중단
    }
%>

<%
    String errMsg = "";                                         // 오류 메시지 저장용 변수
    String title = "", content = "", writer = "";               // 글 제목, 내용, 작성자 값을 담을 변수
    int id = 0;                                                 // 게시글 id 값
    try {
        id = Integer.parseInt(request.getParameter("id"));      // 요청 파라미터에서 id를 정수로 변환
        Connection conn = DBUtill.getConnection();              // DB 연결 얻기
        PreparedStatement ps = conn.prepareStatement(           // 특정 id 게시글 조회 SQL 준비
                "SELECT * FROM board_free WHERE id=?");
        ps.setInt(1, id);                                       // 1번째 ? 에 게시글 id 바인딩
        ResultSet rs = ps.executeQuery();                       // SELECT 실행

        if(rs.next()){                                          // 결과가 있으면 기존 글 정보 읽기
            title = rs.getString("title");                      // 제목
            content = rs.getString("content");                  // 내용
            writer = rs.getString("writer");                    // 작성자
        } else {
            errMsg = "글 정보를 찾을 수 없습니다.";             // 해당 id 글이 없을 때 메시지 설정
        }

        rs.close(); ps.close(); conn.close();                   // ResultSet, PreparedStatement, Connection 정리
    } catch(Exception e){
        errMsg = "오류: " + e.getMessage();                     // 예외 발생 시 오류 메시지 저장
    }
%>

<%@ include file="../../include/header.jsp" %>                  <%-- 공통 헤더 포함 --%>

<main class="main">
    <% if(!errMsg.isEmpty()){ %>                                <%-- 에러가 있으면 에러만 출력 --%>
    <div style="color:red;text-align:center; margin-top:60px;"><%=errMsg%></div>
    <% } else { %>                                              <%-- 에러가 없으면 수정 폼 출력 --%>
    <section class="free-edit-card">
        <h2>게시글 수정</h2>
        <form action="EditAction.jsp" method="post" class="free-edit-form"> <%-- 수정 내용 전송 폼 --%>
            <input type="hidden" name="id" value="<%=id%>">      <%-- 어떤 글을 수정하는지 구분하는 숨겨진 id --%>

            <label for="title">제목</label>
            <input type="text" id="title" name="title" value="<%=title%>" required> <%-- 기존 제목을 채워넣은 입력창 --%>

            <label for="content">내용</label>
            <textarea id="content" name="content" required><%=content%></textarea> <%-- 기존 내용을 채워넣은 텍스트 영역 --%>

            <label for="writer">작성자</label>
            <input type="text" id="writer" name="writer" value="<%=writer%>" required> <%-- 기존 작성자명 표시/수정 필드 --%>

            <div class="free-edit-btns">
                <button type="submit" class="edit-btn-primary">수정 완료</button> <%-- 변경 내용 저장 버튼 --%>
                <a href="../free/List.jsp" class="edit-btn-outline">취소</a>      <%-- 수정 취소 후 목록으로 이동 --%>
            </div>
        </form>
    </section>
    <% } %>
</main>

<%@ include file="../../include/footer.jsp" %>                  <%-- 공통 푸터 포함 --%>
