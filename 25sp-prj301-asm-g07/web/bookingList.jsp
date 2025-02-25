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
    </head>
    <body>
        <%@include file="/navbar.jsp"%>
        <div class="container mt-4">

            <h2 class="mb-4">My Booking</h2>

            <c:if test="${empty bookingList}">
                <div class="alert alert-info" role="alert">
                    No bookings found.
                </div>
            </c:if>

            <c:if test="${not empty bookingList}">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Room ID</th>
                            <th>Check-in Date</th>
                            <th>Check-out Date</th>
                            <th>Total Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${bookingList}">
                            <tr>
                                <td>${booking.bookingID}</td>
                                <td>${booking.roomID}</td>
                                <td>
                                    <fmt:formatDate value="${booking.checkInDate}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>
                                    <fmt:formatDate value="${booking.checkOutDate}" pattern="yyyy-MM-dd" />
                                </td>
                                <td>${booking.totalPrice}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
