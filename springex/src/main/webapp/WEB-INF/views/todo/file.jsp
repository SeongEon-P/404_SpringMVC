<%--
  Created by IntelliJ IDEA.
  User: it
  Date: 24. 4. 30.
  Time: 오후 4:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="/todo/file" method="post" enctype="multipart/form-data">
        <input type="file" name="file">
        <button type="submit">저장</button>
    </form>
</body>
</html>
