<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
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
                            <a class="nav-link" aria-current="page" href="home.jsp">Trang chủ</a>
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
            <h2 class="text-center">Quản trị viên - Bảng điều khiển</h2>
            <div class="row mt-4">
                <div class="col-md-4">
                    <a href="./manageRooms" class="btn btn-outline-primary w-100">Quản lý Phòng</a>
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
