<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Booking: ${booking.bookingID}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Open Sans', sans-serif;
                background: #f8f9fa;
            }

           

            h1 {
                text-align: center;
                font-weight: bold;
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
                margin-top: 10px;
            }

            input, select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .update-btn {
                display: block;
                width: 150px;
                margin: 20px auto;
                padding: 10px;
                text-align: center;
                background: #ffc107;
                color: black;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                text-decoration: none;
            }

            .update-btn:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>
        <%@include file="./adminNavbar.jsp"%>

        <div class="container">
            <h1>Edit Booking</h1>
            <form action="manageBookings" method="post">
                <div class="form-group">
                    <label for="username">Booked By:</label>
                    <input type="text" id="username" name="username" value="${booking.username}" readonly>
                </div>

                <div class="form-group">
                    <label for="roomID">Room:</label>
                    <select id="roomID" name="roomID">
                        <option value="${booking.roomID}">${booking.roomID} (Current Room)</option>
                        <c:forEach var="room" items="${availableRooms}">
                            <option value="${room.roomID}">${room.roomID}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="typeRoomID">Type Room ID:</label>
                    <input type="text" id="typeRoomID" name="typeRoomID" value="${booking.typeRoomID}" readonly>
                </div>

                <div class="form-group">
                    <label for="checkInDate">Check-in Date:</label>
                    <input type="date" id="checkInDate" name="checkInDate" value="${booking.checkInDate}" readonly>
                </div>

                <div class="form-group">
                    <label for="checkOutDate">Check-out Date:</label>
                    <input type="date" id="checkOutDate" name="checkOutDate" value="${booking.checkOutDate}" readonly>
                </div>

                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <option value="${booking.status}">${booking.status} (Current status)</option>
                        <option value="pending">Pending</option>
                        <option value="confirmed">Confirmed</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="text" id="phone" name="phone" value="${booking.phone}" required>
                </div>

                <div class="form-group">
                    <label for="totalPrice">Total Price:</label>
                    <input type="text" id="totalPrice" name="totalPrice" value="${booking.totalPrice}">
                </div>

                <input type="hidden" name="bookingID" value="${booking.bookingID}">
                <input type="hidden" name="action" value="${nextAction}">
                
                <input type="submit" class="update-btn" value="Update">
            </form>
        </div>
    </body>
</html>
