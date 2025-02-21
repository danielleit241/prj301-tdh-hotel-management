<%-- 
    Document   : home
    Created on : Jan 11, 2025, 8:02:13 PM
    Author     : hoade
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            h2{
                padding: 20px 50px;
            }
        </style>
    </head>
    <body>
        <%@include file="/menu.jsp"%>
        <h2>Hello: ${sessionScope.user.name}</h1>
    </body>
</html>
