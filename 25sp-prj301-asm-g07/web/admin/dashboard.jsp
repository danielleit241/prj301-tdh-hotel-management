<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .navbar {
                background-color: black !important;
            }

            .navbar-brand,
            .navbar-nav .nav-link { /* Combined selectors for efficiency */
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
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
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
            <h2 class="text-center">Quản trị viên - Bảng điều khiển</h2>
            <div class="row mt-4">
                <div class="col-md-4">
                    <a href="manageRooms.jsp" class="btn btn-outline-primary w-100">Quản lý Phòng</a>
                </div>
                <div class="col-md-4">
                    <a href="./manageBookings" class="btn btn-outline-primary w-100">Quản lý Đặt Phòng</a>
                </div>
                <div class="col-md-4">
                    <a href="manageReviews.jsp" class="btn btn-outline-primary w-100">Quản lý Đánh giá</a>
                </div>
            </div>
        </div>
    </body>
</html>
