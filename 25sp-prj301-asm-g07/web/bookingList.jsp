<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Booking</title>
        <link rel="icon" href="images/thd-icon.png">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" type="text/css" href="css/footer.css">
        <link rel="stylesheet" href="css/ionicons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>

        </style>
    </head>
    <body<%@include file="/navbar.jsp"%>
        <h2 style="text-align: center; font-weight: 600; margin-top: 20px; font-size: 60px">MY BOOKING</h2>
        <div class="booking-list-container"> 

            <c:if test="${empty bookingList}">
                <div class="alert alert-info" role="alert">
                    No bookings found.
                </div>
            </c:if>
            <c:if test="${not empty bookingList}">
                <c:forEach var="booking" items="${bookingList}">
                    <div class="booking-ticket"> 
                        <div class="booking-image-container"> 
                            <img src="images/${booking.typeRoomID}/${booking.typeRoomID}.jpg" alt="Room Image">
                        </div>
                        <div class="booking-details"> 
                            <h3 style="font-weight: 600;"><span class="booking-ticket-label">Booking ID:</span> <span class="booking-ticket-value">${booking.bookingID}</span></h3>
                            <p><span class="booking-ticket-label">Room ID:</span> <span class="booking-ticket-value">${booking.roomID}</span></p>
                            <p><span class="booking-ticket-label">Check-in Date:</span> <span class="booking-ticket-value"><fmt:formatDate value="${booking.checkInDate}" pattern="yyyy-MM-dd" /></span></p>
                            <p><span class="booking-ticket-label">Check-out Date:</span> <span class="booking-ticket-value"><fmt:formatDate value="${booking.checkOutDate}" pattern="yyyy-MM-dd" /></span></p>
                            <p><span class="booking-ticket-label" style="color: #E10F34">Total Price:</span> <span class="booking-ticket-value" style="color: #E10F34"><fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0"/> VNĐ</span></p>
                            <p>
                                <span class="booking-ticket-label">Status:</span>
                                <span class="booking-ticket-value">${booking.status}</span>
                            </p>

                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <%@include file="footer.jsp" %>
    </body>

</html>
