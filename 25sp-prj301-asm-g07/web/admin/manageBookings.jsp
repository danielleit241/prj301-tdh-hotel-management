<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Đặt phòng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>       
        <%@include file="./adminNavbar.jsp"%>
        <div class="container mt-5">
            <h2>Quản lý Đặt phòng</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Booking ID</th>
                        <th>Username</th>
                        <th>Room ID</th>
                        <th>Type Room ID</th>
                        <th>Check In Date</th>
                        <th>Check Out Date</th>
                        <th>Phone</th>
                        <th>Total Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="booking" items="${roomBookings}">
                        <tr>
                            <td><c:out value="${booking.getBookingID()}"/></td>
                            <td><c:out value="${booking.getUsername()}"/></td>
                            <td><c:out value="${booking.getRoomID()}"/></td>
                            <td><c:out value="${booking.getTypeRoomID()}"/></td>
                            <td><c:out value="${booking.getCheckInDate()}"/></td>
                            <td><c:out value="${booking.getCheckOutDate()}"/></td>
                            <td><c:out value="${booking.getPhone()}"/></td>
                            <td>
                                <fmt:formatNumber value="${booking.getTotalPrice()}" pattern="#,##0 VNĐ" />
                            </td>     
                            <td class="room-status" 
                                <c:choose>
                                    <c:when test="${booking.getStatus() == 'chưa đặt'}">style="color: red;"</c:when>
                                    <c:when test="${booking.getStatus() == 'đã xác nhận'}">style="color: green;"</c:when>
                                    <c:when test="${booking.getStatus() == 'đang đặt (chưa thanh toán)'}">style="color: #F8B701;"</c:when>
                                    <c:otherwise>style="color: black;"</c:otherwise>
                                </c:choose>
                                > 
                                <c:out value="${booking.getStatus()}"/>
                                <c:if test="${booking.getStatus() == 'đang đặt (chưa thanh toán)'}">
                                    <form action="payment">
                                        <input type="hidden" name="bookingID" value="${booking.getBookingID()}">
                                        <input type="hidden" name="method" value="COD">
                                        <input type="hidden" name="action" value="confirmed">
                                        <input type="submit" value="Xác nhận">
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>