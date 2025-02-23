<%-- 
    Document   : roomDetails
    Created on : Feb 23, 2025, 7:41:23 PM
    Author     : TRAN PHU THINH
--%>

<%@page import="prj301asm.Room.RoomDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%@include file = "navbar.jsp" %>
        <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}.jpg">
        <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_1.jpg">
        <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_2.jpg">
        <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_3.jpg">
        <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_4.jpg">
        <h3>${room.roomName}</h3>
        <p>Type room: ${room.typeName}</p>
        <p class="price">Starting from: 
            <fmt:formatNumber value="${room.price}" pattern="#,##0" /> VNĐ
        </p>
        <p>Description:
            ${room.description}</p>
    </body>

</html>
