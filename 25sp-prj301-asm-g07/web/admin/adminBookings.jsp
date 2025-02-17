<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List, prj301.asm.Room.RoomDTO, prj301.asm.Room.RoomDAO, prj301.asm.Booking.BookingDTO, prj301.asm.Booking.BookingDAO, java.text.SimpleDateFormat" %>
<%
    RoomDAO roomDAO = new RoomDAO();
    BookingDAO bookingDAO = new BookingDAO();

    List<RoomDTO> rooms = roomDAO.getAllRooms();
    //List<BookingDTO> bookings = bookingDAO.getAllBookings();

    java.util.Map<String, String> roomStatus = new java.util.HashMap<>();
    for (RoomDTO room : rooms) {
        roomStatus.put(String.valueOf(room.getRoomID()), "available");
    }

   // for (BookingDTO booking : bookings) {
   //     roomStatus.put(String.valueOf(booking.getRoomID()), "booked");
    }

    // request.setAttribute("rooms", rooms);
    // request.setAttribute("roomStatus", roomStatus);

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý Đặt phòng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .room-status {
                font-weight: bold;
            }
            .booked {
                color: red;
            }
            .available {
                color: green;
            }
            .navbar {
                background-color: black !important;
            }

            .navbar-brand,
            .navbar-nav .nav-link {
                color: white !important;
            }

            .navbar-nav .nav-link.active {
                color: #cccccc !important; 
            }

        </style>
    </head>
    <body>
        <div class="container mt-5">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container">
                    <a class="navbar-brand" href="#">THD-Hotel</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="index.jsp">Trang chủ</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="roomList.jsp">Danh sách phòng</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Đặt phòng</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Liên hệ</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>

            <h2>Quản lý Đặt phòng</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Room ID</th>
                        <th>Tên phòng</th>
                        <th>Loại phòng</th>
                        <th>Giá</th>
                        <th>Mô tả</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="room" items="${rooms}">
                        <tr>
                            <td><c:out value="${room.getRoomID()}"/></td>
                            <td><c:out value="${room.getRomeName()}"/></td>
                            <td><c:out value="${room.getTypeName()}"/></td>
                            <td><c:out value="${room.getPrice()}"/></td>
                            <td><c:out value="${room.getDescription()}"/></td>
                            <td class="room-status ${roomStatus[room.roomID] == 'booked'? 'booked': 'available'}">
                                <c:out value="${roomStatus[room.roomID] == 'booked'? 'Booked': 'Available'}"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>