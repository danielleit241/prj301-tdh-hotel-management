<%-- 
    Document   : bookingEdit
    Created on : Mar 4, 2025, 2:47:52 PM
    Author     : hoade
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Booking: ${booking.bookingID}</title>
    </head>
    <body>
        <%@include file="./adminNavbar.jsp"%>
        <form action="manageBookings" method="post">
            <label for="username">Booked By:</label>
            <input type="text" id="username" name="username" value="${booking.username}" readonly><br><br>

            <label for="roomID">Room:</label>
            <select id="roomID" name="roomID">
                <option value="${booking.roomID}">${booking.roomID} (Current Room)</option>
                <c:forEach var="room" items="${availableRooms}">
                    <option value="${room.roomID}">${room.roomID}</option>
                </c:forEach>
            </select><br><br>

            <label for="typeRoomID">Type Room ID:</label>
            <input type="text" id="typeRoomID" name="typeRoomID" value="${booking.typeRoomID}" readonly><br><br>

            <label for="checkInDate">Check-in Date:</label>
            <input type="date" id="checkInDate" name="checkInDate" value="${booking.checkInDate}" readonly><br><br>

            <label for="checkOutDate">Check-out Date:</label>
            <input type="date" id="checkOutDate" name="checkOutDate" value="${booking.checkOutDate}" readonly><br><br>

            <label for="status">Status:</label>
            <select id="status" name="status">
                <option value="${booking.status}">${booking.status} (Current status)</option>
                <option value="pending">Pending</option>
                <option value="confirmed">Confirmed</option>
            </select><br><br>
            
            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" value="${booking.phone}"><br><br>

            <label for="totalPrice">Total Price:</label>
            <input type="text" id="totalPrice" name="totalPrice" value="${booking.totalPrice}"><br><br>

            <input type="hidden" name="bookingID" value="${booking.bookingID}">
            <input type="hidden" name="action" value="${nextAction}">
            <input type="submit" value="Update">
        </form>
    </body>
</html>
