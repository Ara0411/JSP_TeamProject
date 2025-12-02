<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>   <%-- 페이지 인코딩 및 콘텐츠 타입 설정 --%>
<%@ page import="java.sql.*, com.example.jsp_pr.dao.DBUtill" %>           <%-- JDBC와 DB 연결 유틸 import --%>

<%
    String errMsg = "";                                                   // 오류 메시지 저장용 변수
    try {
        String userName = (String)session.getAttribute("userName");       // 세션에서 로그인한 사용자 이름 가져오기
        if(userName == null){                                             // 로그인하지 않은 경우
            response.sendRedirect("../member/login.jsp");                // 로그인 페이지로 리다이렉트
            return;                                                      // 댓글 저장 로직 중단
        }
        int board_id = Integer.parseInt(request.getParameter("board_id"));// 요청 파라미터에서 게시글 번호(board_id) 얻기
        String content = request.getParameter("content");                // 요청 파라미터에서 댓글 내용 가져오기

        Connection conn = DBUtill.getConnection();                       // DB 연결 얻기
        PreparedStatement ps = conn.prepareStatement(                    // 댓글 INSERT SQL 준비
                "INSERT INTO board_comment (board_id, writer, content) VALUES (?, ?, ?)");
        ps.setInt(1, board_id);                                          // 1번째 ? 에 게시글 번호 바인딩
        ps.setString(2, userName);                                       // 2번째 ? 에 작성자(로그인 사용자) 바인딩
        ps.setString(3, content);                                        // 3번째 ? 에 댓글 내용 바인딩
        ps.executeUpdate();                                              // INSERT 실행
        ps.close(); conn.close();                                        // PreparedStatement와 Connection 정리

        response.sendRedirect("View.jsp?id=" + board_id);                // 댓글 저장 후 해당 게시글 보기 페이지로 이동
    } catch(Exception e){
        e.printStackTrace();                                             // 서버 콘솔에 오류 스택 출력
        errMsg = "<h3>댓글 저장 중 오류가 발생했습니다: "              // 사용자에게 보여줄 오류 메시지 HTML 생성
                + e.getMessage() + "</h3>";
    }
%>

<% if(errMsg.length() > 0) { %>                                           <%-- 오류 메시지가 있으면 화면에 출력 --%>
<%= errMsg %>
<% } %>
