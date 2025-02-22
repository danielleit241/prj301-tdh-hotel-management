<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý Phòng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
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

            .dropdown-menu {
                background-color: black;
            }
            .dropdown-item {
                color: white; 
            }
            .dropdown-item:hover {
                background-color: #333;
            }
        </style>
    </head>
    <body>
        
        <div class="container mt-5">
                <h2 style="text-align: center">Quản lý Phòng</h2>
            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addRoomModal">
                Thêm phòng mới
            </button>

            <table class="table">
                <thead>
                    <tr>
                        <th>Room ID</th>
                        <th>Tên phòng</th>
                        <th>Loại phòng</th>
                        <th>Giá</th>
                        <th>Mô tả</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="room" items="${list}">
                        <tr>
                            <td><c:out value="${room.getRoomID()}"/></td>
                            <td><c:out value="${room.getRoomName()}"/></td>
                            <td><c:out value="${room.getTypeName()}"/></td>
                            <td><c:out value="${room.getPrice()}"/></td>
                            <td><c:out value="${room.getDescription()}"/></td>
                            <td>
                                <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editRoomModal${room.roomID}">Sửa</button>
                                <a href="manageRooms.jsp?action=delete&roomID=${room.roomID}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này?')">Xóa</a>
                            </td>
                        </tr>                   
                </c:forEach>
                </tbody>
            </table>

            
        </div>
    </body>
</html>