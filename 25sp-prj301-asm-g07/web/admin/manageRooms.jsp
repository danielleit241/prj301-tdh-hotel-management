<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Phòng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <%@include file="/admin/adminNavbar.jsp"%>
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
                            <button type="button" class="btn btn-warning btn-sm">
                                <a href="roomEdit?roomId=${room.roomID}">Sửa</a>
                            </button>
                        </td>
                    </tr>                   
                </c:forEach>
            </tbody>
        </table>


    </div>
</body>
</html>