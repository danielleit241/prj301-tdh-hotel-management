<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Details</title>
    </head>
    <body>
        <%@ include file="navbar.jsp" %>
        <img src="images/${requestScope.roomDetail.roomID}/${requestScope.roomDetail.roomID}.jpg" alt="Room Image">
        <img src="images/${requestScope.roomDetail.roomID}/${requestScope.roomDetail.roomID}_1.jpg" alt="Room Image 1">
        <img src="images/${requestScope.roomDetail.roomID}/${requestScope.roomDetail.roomID}_2.jpg" alt="Room Image 2">
        <img src="images/${requestScope.roomDetail.roomID}/${requestScope.roomDetail.roomID}_3.jpg" alt="Room Image 3">
        <img src="images/${requestScope.roomDetail.roomID}/${requestScope.roomDetail.roomID}_4.jpg" alt="Room Image 4">

        <h3>${requestScope.roomDetail.roomName}</h3>
        <p>Type room: ${requestScope.roomDetail.typeName}</p>
        <p>Price: <fmt:formatNumber value="${requestScope.roomDetail.price}" pattern="#,##0" /> VNĐ</p>
        <p>Description: ${requestScope.roomDetail.description}</p>
        <button>
            <a href="booking?roomID=${requestScope.roomDetail.roomID}&action=booking">Book now!</a>
        </button>
    </body>
</html>
