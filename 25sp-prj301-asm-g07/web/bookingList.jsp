<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Booking</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
        <style>
            /*member/bookingList.jsp*/
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            .booking-ticket {
                background-color: #f9f9f9;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                margin: 20px auto; /* Căn giữa vé nếu cần */
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 90%; /* Điều chỉnh kích thước vé, có thể dùng 100% nếu muốn lấp đầy container */
                max-width: 1200px; /* Thêm max-width để giới hạn kích thước trên màn hình lớn */
                display: flex;
                box-sizing: border-box;
            }

            .booking-ticket .image-container {
                width: 30%;
                margin-right: 20px;
            }

            .booking-ticket .image-container img {
                max-width: 100%;
                height: auto;
                display: block;
            }

            .booking-ticket .details {
                width: 70%;
            }

            .booking-ticket h3 {
                margin-bottom: 15px;
                color: #333;
                text-align: left;
            }

            .booking-ticket p {
                margin-bottom: 10px;
                color: #555;
                line-height: 1.6;
            }

            .booking-ticket .ticket-label {
                font-weight: bold;
                margin-right: 5px;
            }

            .booking-ticket .ticket-value {
                display: inline-block;
            }

        </style>
    </head>
    <body>
        <%@include file="/navbar.jsp"%>
        <h2 style="text-align: center; font-weight: 600; margin-top: 20px; font-size: 60px">MY BOOKING</h2>
        <div class="container mt-4">

            <c:if test="${empty bookingList}">
                <div class="alert alert-info" role="alert">
                    No bookings found.
                </div>
            </c:if>
            <c:if test="${not empty bookingList}">
                <c:forEach var="booking" items="${bookingList}">
                    <div class="booking-ticket">
                        <div class="image-container">
                            <img src="images/${booking.roomID}/${booking.roomID}.jpg" alt="Room Image">
                        </div>
                        <div class="details">
                            <h3 style="font-weight: 600;">My Booking</h3>
                            <p><span class="ticket-label">Booking ID:</span> <span class="ticket-value">${booking.bookingID}</span></p>
                            <p><span class="ticket-label">Room ID:</span> <span class="ticket-value">${booking.roomID}</span></p>
                            <p><span class="ticket-label">Check-in Date:</span> <span class="ticket-value"><fmt:formatDate value="${booking.checkInDate}" pattern="yyyy-MM-dd" /></span></p>
                            <p><span class="ticket-label">Check-out Date:</span> <span class="ticket-value"><fmt:formatDate value="${booking.checkOutDate}" pattern="yyyy-MM-dd" /></span></p>
                            <p><span class="ticket-label" style="color: #E10F34">Total Price:</span> <span class="ticket-value" style="color: #E10F34"><fmt:formatNumber value="${booking.totalPrice}" pattern="#,##0"/> VNĐ</span></p>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
