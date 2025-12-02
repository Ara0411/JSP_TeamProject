<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>   <%-- 페이지 인코딩 및 콘텐츠 타입 설정 --%>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>           <%-- JDBC 클래스와 DB 연결 유틸 import --%>

<%
    request.setCharacterEncoding("UTF-8");                                // 요청 파라미터 인코딩을 UTF-8로 설정

    String title = request.getParameter("title");                         // 폼에서 넘어온 제목
    String content = request.getParameter("content");                     // 폼에서 넘어온 내용

    // 🔹 로그인한 사용자 아이디를 세션에서 꺼냄
    //    로그인할 때 session.setAttribute("userId", 로그인아이디); 이런 식으로 넣었다고 가정
    String writer = (String) session.getAttribute("userId");              // 세션에 저장된 로그인 아이디를 작성자로 사용

    if (writer == null || writer.trim().isEmpty()) {                      // 로그인 정보가 없으면
        // 로그인 안 되어 있으면 로그인 페이지로 보냄 (알림 후 이동)
        out.println("<script>alert('로그인 후 이용 가능합니다.'); location.href='../../member/login.jsp';</script>");
        return;                                                           // 이후 DB 처리 중단
    }

    String errMsg = "";                                                   // 오류 메시지 저장용 변수
    try {
        Connection conn = DBUtill.getConnection();                        // DB 연결 얻기
        PreparedStatement ps = conn.prepareStatement(                     // 글 등록 INSERT SQL 준비
                "INSERT INTO board_free (title, content, writer, regdate, viewcnt) VALUES (?, ?, ?, NOW(), 0)"
        );
        ps.setString(1, title);                                           // 1번째 ? 에 제목 바인딩
        ps.setString(2, content);                                         // 2번째 ? 에 내용 바인딩
        ps.setString(3, writer);                                          // 3번째 ? 에 작성자(userId) 바인딩

        int result = ps.executeUpdate();                                  // INSERT 실행 후 영향받은 행 수 확인
        ps.close();
        conn.close();

        if (result > 0) {                                                 // 등록 성공 시
            out.println("<script>alert('등록되었습니다.'); location.href='List.jsp';</script>"); // 알림 후 목록으로 이동
            return;                                                       // 더 이상 아래 코드 실행하지 않음
        } else {
            errMsg = "글 등록에 실패했습니다.";                           // 영향받은 행이 없으면 실패 메시지
        }
    } catch (Exception e) {
        e.printStackTrace();                                              // 서버 콘솔에 오류 출력
        errMsg = "오류: " + e.getMessage();                               // 예외 메시지를 errMsg에 저장
    }
%>

<% if (!errMsg.isEmpty()) { %>                                            <%-- 에러 메시지가 있을 때만 실행 --%>
<script>
    alert('<%= errMsg.replace("'", "\\'") %>');                           // 경고창으로 오류 내용 보여주기
    history.back();                                                       // 이전 페이지(글쓰기 폼)로 돌아가기
</script>
<% } %>
