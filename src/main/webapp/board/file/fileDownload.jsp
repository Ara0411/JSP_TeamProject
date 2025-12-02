<%@ page import="java.io.*" %>
<%@ page import="com.example.jsp_pr.dao.BoardFileDAO" %>
<%@ page import="com.example.jsp_pr.dto.BoardFileDTO" %>
<%@ page contentType="application/octet-stream; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String idStr = request.getParameter("id");
    if (idStr == null) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    int id = Integer.parseInt(idStr);

    BoardFileDAO dao = new BoardFileDAO();
    BoardFileDTO dto = dao.getById(id);

    if (dto == null) {
        out.println("<script>alert('파일 정보를 찾을 수 없습니다.'); history.back();</script>");
        return;
    }

    dao.increaseDownloadCnt(id);

    String fileName = dto.getFilename();
    String savePath = application.getRealPath("/upload/file");
    File file = new File(savePath, fileName);

    if (!file.exists()) {
        out.println("<script>alert('파일이 존재하지 않습니다.'); history.back();</script>");
        return;
    }

    String downloadName = java.net.URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");

    response.reset();
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + downloadName + "\";");
    response.setHeader("Content-Length", String.valueOf(file.length()));

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
