<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Room Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body class="room-details-page">
        <%@ include file="navbar.jsp" %>
        <div class="room-details-container">
            <div class="image-section">
                <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}.jpg" alt="Room Image" class="main-image">
                <div class="gallery-row">
                    <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_1.jpg" alt="Room Image 1">
                    <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_2.jpg" alt="Room Image 2">
                    <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_3.jpg" alt="Room Image 3">
                    <img src="images/${requestScope.room.roomID}/${requestScope.room.roomID}_4.jpg" alt="Room Image 4">
                </div>
            </div>
            <div class="details-section">
                <h1>Modern Single Room with Air Conditioner</h1>
                <p>Type room: Single Room</p>
                <p class="price">Price: <fmt:formatNumber value="${requestScope.room.price}" pattern="#,##0" /> VNĐ</p>
                <p>Description: Modern single room equipped with an air conditioner, a 32-inch LED TV, and premium ceramic tile flooring; the bathroom features a convenient shower and a compact washing machine.</p>

                <button class="details-button">
                    <a href="booking?roomID=${requestScope.room.roomID}&action=booking">Book now!</a>
                </button>
            </div>
        </div>
    </body>
</html>
