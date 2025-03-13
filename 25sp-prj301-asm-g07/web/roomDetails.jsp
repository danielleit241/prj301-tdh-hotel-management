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

        <link rel="stylesheet" type="text/css" href="css/footer.css">
        <link rel="stylesheet" href="css/ionicons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <!-- Bootstrap CSS -->
        <link 
            rel="stylesheet" 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            />
        <!-- Bootstrap Icons CSS -->
        <link 
            rel="stylesheet" 
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
            />
    </head>
    <body class="room-details-page">
        <%@ include file="/navbar.jsp" %>
        <div class="room-details-container">
            <div class="image-section">
                <img src="images/${requestScope.room.typeRoomID}/${requestScope.room.typeRoomID}.jpg" alt="Room Image" class="main-image">
                <div class="gallery-row">
                    <img src="images/${requestScope.room.typeRoomID}/${requestScope.room.typeRoomID}.1.jpg" alt="Room Image 1">
                    <img src="images/${requestScope.room.typeRoomID}/${requestScope.room.typeRoomID}.2.jpg" alt="Room Image 2">
                    <img src="images/${requestScope.room.typeRoomID}/${requestScope.room.typeRoomID}.3.jpg" alt="Room Image 3">
                    <img src="images/${requestScope.room.typeRoomID}/${requestScope.room.typeRoomID}.4.jpg" alt="Room Image 4">
                </div>
            </div>
            <div class="details-section">
                <h1>${requestScope.room.typeName}</h1>
                <p>Type room: ${requestScope.room.typeName}</p>
                <p class="price">Price: <fmt:formatNumber value="${requestScope.room.price}" pattern="#,##0" /> VNĐ</p>
                <p>Description: ${requestScope.room.typeDes}</p>

                <div class="row row-cols-2 g-2 text-center">
                    <div class="col d-flex flex-column">
                        <i class="bi bi-buildings fs-2"></i>
                        <p class="mt-2 mb-0">${room.viewDetail}</p>
                    </div>
                    <div class="col d-flex flex-column">
                        <i class="bi bi-cup-hot fs-2"></i>
                        <p class="mt-2 mb-0">Complimentary Nespresso</p>
                    </div>
                    <div class="col d-flex flex-column">
                        <i class="bi bi-rulers fs-2"></i>
                        <p class="mt-2 mb-0">${room.roomSize}</p>
                    </div>
                    <div class="col d-flex flex-column">
                        <i class="bi bi-wifi fs-2"></i>
                        <p class="mt-2 mb-0">Complimentary Wifi</p>
                    </div>
                </div>

                <form action="booking" method="post">
                    <input type="hidden" name="typeRoomID" value="${requestScope.room.typeRoomID}">
                    <input type="hidden" name="dateIn" value="${requestScope.dateIn}">
                    <input type="hidden" name="dateOut" value="${requestScope.dateOut}">
                    <input type="hidden" name="action" value="mbooking">
                    <input type="submit" value="Book now">
                </form>

            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>

