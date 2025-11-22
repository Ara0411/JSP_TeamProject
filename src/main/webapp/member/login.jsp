<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>로그인</title></head>
<body>
<h2>로그인</h2>
<form action="login_action.jsp" method="post">
    아이디: <input type="text" name="id" required><br>
    비밀번호: <input type="password" name="pass" required><br>
    <button type="submit">로그인</button>
</form>
</body>
</html>