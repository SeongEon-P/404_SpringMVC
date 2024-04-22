<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2024-04-03
  Time: 오후 12:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <form action="calcResult.jsp" method="GET"> <%--GET 방식으로하면 a태그와 같은 기능, 주소창에 데이터 나옴. POST방식은 주소창에 데이터 안나옴--%>
        <input type = "number"  name="num1">
        <input type = "number"  name="num2">
        <button type = "submit">SEND</button> <%--submit 하면 action이 실행됨--%>
    </form>

</body>
</html>
