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
        <style>
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
        <div class="container mt-5">
            <%-- Thông báo thành công/thất bại --%>
            <c:if test="${param.addSuccess == 'true'}">
                <div class="alert alert-success" role="alert">Thêm phòng thành công!</div>
            </c:if>
            <c:if test="${requestScope.addError != null}">
                <div class="alert alert-danger" role="alert">${requestScope.addError}</div>
            </c:if>
            <c:if test="${param.editSuccess == 'true'}">
                <div class="alert alert-success" role="alert">Cập nhật phòng thành công!</div>
            </c:if>
            <c:if test="${requestScope.editError != null}">
                <div class="alert alert-danger" role="alert">${requestScope.editError}</div>
            </c:if>
            <c:if test="${param.deleteSuccess == 'true'}">
                <div class="alert alert-success" role="alert">Xóa phòng thành công!</div>
            </c:if>
            <c:if test="${requestScope.deleteError != null}">
                <div class="alert alert-danger" role="alert">${requestScope.deleteError}</div>
            </c:if>

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
                    <c:forEach var="room" items="${rooms}">
                        <tr>
                            <td><c:out value="${room.getRoomID()}"/></td>
                            <td><c:out value="${room.getRomeName()}"/></td>
                            <td><c:out value="${room.getTypeName()}"/></td>
                            <td><c:out value="${room.getPrice()}"/></td>
                            <td><c:out value="${room.getDescription()}"/></td>
                            <td>
                                <button type="button" class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#editRoomModal${room.roomID}">Sửa</button>
                                <a href="manageRooms.jsp?action=delete&roomID=${room.roomID}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa phòng này?')">Xóa</a>
                            </td>
                        </tr>

                    <div class="modal fade" id="editRoomModal${room.roomID}" tabindex="-1" aria-labelledby="editRoomModalLabel${room.roomID}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="editRoomModalLabel${room.roomID}">Sửa phòng: ${room.romeName}</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <form method="post" action="manageRooms.jsp?action=edit">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="roomID" class="form-label">Room ID</label>
                                            <input type="text" class="form-control" id="roomID" name="roomID" value="${room.roomID}" readonly> <%-- RoomID readonly khi sửa --%>
                                        </div>
                                        <div class="mb-3">
                                            <label for="romeName" class="form-label">Tên phòng</label>
                                            <input type="text" class="form-control" id="romeName" name="romeName" value="${room.romeName}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="typeName" class="form-label">Loại phòng</label>
                                            <input type="text" class="form-control" id="typeName" name="typeName" value="${room.typeName}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="price" class="form-label">Giá</label>
                                            <input type="number" class="form-control" id="price" name="price" value="${room.price}" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="description" class="form-label">Mô tả</label>
                                            <textarea class="form-control" id="description" name="description" rows="3" required><c:out value="${room.description}"/></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                </tbody>
            </table>

            <div class="modal fade" id="addRoomModal" tabindex="-1" aria-labelledby="addRoomModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addRoomModalLabel">Thêm phòng mới</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form method="post" action="manageRooms.jsp?action=add">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="roomID" class="form-label">Room ID</label>
                                    <input type="text" class="form-control" id="roomID" name="roomID" required>
                                </div>
                                <div class="mb-3">
                                    <label for="romeName" class="form-label">Tên phòng</label>
                                    <input type="text" class="form-control" id="romeName" name="romeName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="typeName" class="form-label">Loại phòng</label>
                                    <input type="text" class="form-control" id="typeName" name="typeName" required>
                                </div>
                                <div class="mb-3">
                                    <label for="price" class="form-label">Giá</label>
                                    <input type="number" class="form-control" id="price" name="price" required>
                                </div>
                                <div class="mb-3">
                                    <label for="description" class="form-label">Mô tả</label>
                                    <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-primary">Thêm phòng</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>