<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>   <%-- JDBC와 DB 연결 유틸 import --%>

<%
    String userId = (String) session.getAttribute("userId");      // 세션에서 로그인한 사용자 ID 가져오기
    if(userId == null){                                          // 로그인 정보가 없으면
        response.sendRedirect("../member/login.jsp");            // 로그인 페이지로 이동
        return;                                                  // 이후 수정 로직 중단
    }
%>

<%
    try {
        String sid = request.getParameter("id");                  // 수정할 게시글 id 파라미터
        String title = request.getParameter("title");             // 수정할 제목 파라미터
        String content = request.getParameter("content");         // 수정할 내용 파라미터
        String writer = request.getParameter("writer");           // 수정할 작성자 파라미터

        // 필수 파라미터 체크
        if(sid == null || sid.trim().isEmpty() ||                 // id가 비었는지 확인
                title == null || title.trim().isEmpty() ||        // 제목이 비었는지 확인
                content == null || content.trim().isEmpty() ||    // 내용이 비었는지 확인
                writer == null || writer.trim().isEmpty()) {      // 작성자가 비었는지 확인
%>
<div style="color:red; text-align:center;">필수 항목이 누락되었습니다.</div> <%-- 하나라도 비었으면 에러 메시지 출력 --%>
<%
} else {
    int id = Integer.parseInt(sid);                       // 문자열 id를 정수로 변환

    Connection conn = DBUtill.getConnection();           // DB 연결 가져오기
    PreparedStatement ps = conn.prepareStatement(        // 게시글 수정용 SQL 준비
            "UPDATE board_free SET title=?, content=?, writer=? WHERE id=?"
    );
    ps.setString(1, title);                              // 1번째 ? 에 제목 바인딩
    ps.setString(2, content);                            // 2번째 ? 에 내용 바인딩
    ps.setString(3, writer);                             // 3번째 ? 에 작성자 바인딩
    ps.setInt(4, id);                                    // 4번째 ? 에 게시글 id 바인딩

    int result = ps.executeUpdate();                     // UPDATE 실행 후 영향받은 행 수 확인
    ps.close(); conn.close();                            // PreparedStatement와 Connection 정리

    if(result > 0){                                      // 실제로 수정이 되었으면
        response.sendRedirect("View.jsp?id=" + id);      // 해당 글 상세보기로 리다이렉트
        return;                                          // 이후 코드 실행 중단
    } else {
%>
<div style="color:red; text-align:center; margin-top:20px;">수정 실패</div> <%-- 수정된 행이 없을 때 실패 메시지 --%>
<%
        }
    }
} catch(Exception e){
%>
<div style="color:red; text-align:center; margin-top:20px;">오류: <%= e.getMessage()%></div> <%-- 예외 발생 시 오류 메시지 출력 --%>
<%
    }
%>
