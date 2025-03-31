<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>THD Hotel Contact Us</title>
        <link rel="icon" href="images/thd-icon.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">


        <link rel="stylesheet" href="css/style.css"/>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">

        <link rel="stylesheet" type="text/css" href="css/footer.css">
        <link rel="stylesheet" href="css/ionicons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>

        </style>
    </head>
    <body>
        <%@include file="navbar.jsp"%>
        <div class="contact-container mt-5">
            <h2 class="contact-heading">Contact Us</h2>
            <div class="row g-4">

                <!-- Admin 1 -->
                <div class="col-md-4-about">
                    <div class="admin-card">
                        <img src="images/admin1.jpg" alt="Admin 1" class="admin-img">
                        <h4>Lê Vũ Phương Hòa</h4>
                        <p>🛠 Chức vụ: Quản lý hệ thống</p>
                        <p>📍 Địa chỉ: TP. Hồ Chí Minh, Việt Nam</p>
                        <p class="contact-info"><i class="fa-solid fa-phone icon"></i> <a href="tel:0123456789">0123 456 789</a></p>
                        <p class="contact-info"><i class="fa-solid fa-envelope icon"></i> <a href="mailto:hoa@gmail.com">hoa@gmail.com</a></p>
                    </div>
                </div>

                <!-- Admin 2 -->
                <div class="col-md-4-about">
                    <div class="admin-card">
                        <img src="images/admin2.jpg" alt="Admin 2" class="admin-img">
                        <h4>Trần Phú Thịnh</h4>
                        <p>💼 Chức vụ: Hỗ trợ khách hàng</p>
                        <p>📍 Địa chỉ: TP. Hồ Chí Minh, Việt Nam</p>
                        <p class="contact-info"><i class="fa-solid fa-phone icon"></i> <a href="tel:0987654321">0987 654 321</a></p>
                        <p class="contact-info"><i class="fa-solid fa-envelope icon"></i> <a href="mailto:thinh@gmail.com">thinh@gmail.com</a></p>
                    </div>
                </div>
                <!-- Admin 3 -->
                <div class="col-md-4-about">
                    <div class="admin-card">
                        <img src="images/admin3.jpg" alt="Admin 3" class="admin-img">
                        <h4>Ngô Thành Đạt</h4>
                        <p>⚙ Chức vụ: Kỹ thuật viên</p>
                        <p>📍 Địa chỉ: Đà Nẵng, Việt Nam</p>
                        <p class="contact-info"><i class="fa-solid fa-phone icon"></i> <a href="tel:0345678901">0345 678 901</a></p>
                        <p class="contact-info"><i class="fa-solid fa-envelope icon"></i> <a href="mailto:dat@gmail.com">dat@gmail.com</a></p>
                    </div>
                </div>
            </div>
        </div>  
        
        <%@include file="footer.jsp"%>
    </body>
</html>
