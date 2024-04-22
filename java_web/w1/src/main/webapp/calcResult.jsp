<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2024-04-03
  Time: 오후 12:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <h1>NUM1 ${param.num1}</h1> <%--num1에 입력한 데이터값을 가져옴, 버전에 따라 무조건 문자열로 가져오기도해서 주의--%>
    <h1>NUM2 ${param.num2}</h1>
    <h1>SUM ${param.num1+param.num2}</h1>
</body>
</html>
