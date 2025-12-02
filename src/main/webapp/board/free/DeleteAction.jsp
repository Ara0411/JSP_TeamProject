<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>   <%-- JDBC와 DB 연결 유틸 import --%>

<%
    String userId = (String) session.getAttribute("userId");      // 세션에서 로그인한 사용자 ID 가져오기
    if(userId == null){                                          // 로그인하지 않은 경우
        response.sendRedirect("../member/login.jsp");            // 로그인 페이지로 리다이렉트
        return;                                                  // 삭제 로직 실행 중단
    }
%>

<%
    String sid = request.getParameter("id");                      // 요청 파라미터에서 게시글 id 가져오기
    if(sid == null || sid.trim().isEmpty()){                     // id가 없거나 공백이면
%>
<div style="color:red;">ERROR: id 값이 없습니다.</div>           <%-- id 누락 오류 메시지 출력 --%>
<%
        return;                                                  // 더 이상 진행하지 않고 종료
    }
    try {
        int id = Integer.parseInt(sid);                          // 문자열 id를 정수로 변환
        Connection conn = DBUtill.getConnection();               // DB 연결 얻기
        PreparedStatement ps = conn.prepareStatement(            // 게시글 삭제 SQL 준비
                "DELETE FROM board_free WHERE id=?");
        ps.setInt(1, id);                                        // 1번째 ? 에 삭제할 게시글 id 바인딩
        int result = ps.executeUpdate();                         // DELETE 실행 후 영향받은 행 수 확인
        ps.close(); conn.close();                                // PreparedStatement와 Connection 정리

        if(result > 0){                                          // 실제로 삭제가 되었다면
            response.sendRedirect("List.jsp");                   // 목록 페이지로 리다이렉트
            return;                                              // 이후 코드 실행 중단
        } else {
%>
<div style="color:red; text-align:center;">삭제 실패</div>        <%-- 삭제된 행이 없을 때 실패 메시지 출력 --%>
<%
    }
} catch(Exception e){
%>
<div style="color:red; text-align:center;">오류: <%= e.getMessage()%></div> <%-- 예외 발생 시 오류 메시지 출력 --%>
<%
    }
%>
