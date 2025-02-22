<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">THD-Hotel</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="home.jsp">Trang chủ</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./manageRooms">Danh sách phòng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="./manageBookings">Quản Lí Đặt phòng</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Quản Lí Đánh Giá</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Liên hệ</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container mt-5">
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
                    <c:forEach var="room" items="${roomBookings}">
                        <tr>
                            <td><c:out value="${room.getRoomID()}"/></td>
                            <td><c:out value="${room.getRomeName()}"/></td>
                            <td><c:out value="${room.getTypeName()}"/></td>
                            <td><c:out value="${room.getTotalPrice()}"/></td>
                            <td><c:out value="${room.getDescription()}"/></td>
                            <td class="room-status" 
                                <c:choose>
                                    <c:when test="${room.getStatus() == 'chưa đặt'}">style="color: red;"</c:when>
                                    <c:when test="${room.getStatus() == 'đã đặt'}">style="color: green;"</c:when>
                                    <c:otherwise>style="color: black;"</c:otherwise>
                                </c:choose>
                                > 
                                <c:out value="${room.getStatus()}"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>