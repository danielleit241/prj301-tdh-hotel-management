<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Phòng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <%@include file="adminNavbar.jsp" %>
        <button style="width: 500px; height: 50px; margin-left: 700px" type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addRoomModal">
            Thêm phòng mới
        </button>

        <table class="admin-manage-rooms">
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
                        <td class="description"><c:out value="${room.getDescription()}"/></td>
                        <td class="actions">
                            <a href="editRoom?roomId=${room.getRoomID()}" class="custom-edit-button">Sửa</a>
                            <a href="deleteRoom?roomId=${room.getRoomID()}" class="custom-delete-button" onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>