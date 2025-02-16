<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
</head>
<body>
    <form action="signup" method="post">
        <p>
            Name:
            <input type="text" name="name" value="${param.name}" />
        </p>
        <p>
            Username:
            <input type="text" name="username" value="${param.username}" />
        </p>
        <c:if test="${not empty errorUsername}">
            <h4 style="color:red;">${errorUsername}</h4>
        </c:if>
        <p>
            Password:
            <input type="password" name="password" />
        </p>
        <p>
            Confirm Password:
            <input type="password" name="passwordConfirm" />
        </p>
        <c:if test="${not empty errorPassord}">
            <h4 style="color:red;">${errorPassord}</h4>
        </c:if>
        <p>
            <input type="submit" value="Sign Up" />
        </p>
        <c:if test="${not empty success}">
            <h4 style="color:green;">${success}</h4>
        </c:if>
        <c:if test="${not empty fail}">
            <h4 style="color:red;">${fail}</h4>
        </c:if>
    </form>
</body>
</html>
