<%@ page import="java.io.*" %>
<%@ page import="com.example.jsp_pr.dao.BoardFileDAO" %>
<%@ page import="com.example.jsp_pr.dto.BoardFileDTO" %>
<%@ page contentType="application/octet-stream; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
    [주석 작성자] 최아라
    [파일 역할] 자료실 파일 다운로드 처리
    [주요 기능]
      - 요청 파라미터로 넘어온 id로 board_file에서 파일 정보 조회
      - 실제 서버에 저장된 파일을 찾아서 브라우저에게 바이너리로 전송
      - 다운로드 시 다운로드 횟수(downloadcnt)를 1 증가
      - 파일이 없거나 잘못된 접근일 경우 경고창 출력 후 이전 페이지로 이동
 --%>

<%
    // id 파라미터 검사 (필수 값)
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    int id = Integer.parseInt(idStr);

    // DAO를 통해 해당 id의 파일 정보 조회
    BoardFileDAO dao = new BoardFileDAO();
    BoardFileDTO dto = dao.getById(id);

    if (dto == null) {
        out.println("<script>alert('파일 정보를 찾을 수 없습니다.'); history.back();</script>");
        return;
    }

    // 실제로 파일을 내려받기 전에, 다운로드 횟수를 1 증가시킨다.
    dao.increaseDownloadCnt(id);

    // DB에 저장된 서버 저장 파일명과, 실제 저장 경로를 조합하여 File 객체 생성
    String fileName = dto.getFilename();
    String savePath = application.getRealPath("/upload/file");// 업로드 시 사용했던 물리 경로
    File file = new File(savePath, fileName);

    // 파일이 실제로 존재하지 않는 경우 처리
    if (!file.exists()) {
        out.println("<script>alert('파일이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

    // 다운로드 시 사용자에게 보여줄 파일명(한글 깨짐 방지용 인코딩 처리)
    String downloadName = java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

    // 기존에 설정되어 있을지 모를 응답 헤더 초기화
    response.reset();
    // 브라우저가 파일 다운로드로 인식하도록 MIME 타입을 octet-stream으로 설정
    response.setContentType("application/octet-stream");
    // Content-Disposition 헤더를 attachment로 설정해 다운로드 창이 뜨게 함
    response.setHeader("Content-Disposition", "attachment; filename=\"" + downloadName + "\";");
    // 파일의 크기를 Content-Length로 설정
    response.setHeader("Content-Length", String.valueOf(file.length()));

    // 파일을 읽어서 응답 스트림으로 흘려보내기 (버퍼 사용)
    try (BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
         BufferedOutputStream outStream = new BufferedOutputStream(response.getOutputStream())) {

        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = in.read(buffer)) != -1) {
            outStream.write(buffer, 0, bytesRead);
        }
        outStream.flush();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
