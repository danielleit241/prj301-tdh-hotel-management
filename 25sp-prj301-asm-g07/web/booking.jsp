<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Booking Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css" />
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <%@ include file="navbar.jsp" %>

        <div class="container booking-container">
            <div class="row">
                <!-- Cột bên trái: Hình ảnh và mô tả phòng -->
                <div class="col-md-7">
                    <div class="image-section">
                        <img src="images/${room.roomID}/${room.roomID}.jpg" alt="Room Image" class="main-image">
                        <div class="row">
                            <div class="col-3 mb-3">
                                <img src="images/${room.roomID}/${room.roomID}_1.jpg" alt="Room Image 1" class="img-fluid rounded">
                            </div>
                            <div class="col-3 mb-3">
                                <img src="images/${room.roomID}/${room.roomID}_2.jpg" alt="Room Image 2" class="img-fluid rounded">
                            </div>
                            <div class="col-3 mb-3">
                                <img src="images/${room.roomID}/${room.roomID}_3.jpg" alt="Room Image 3" class="img-fluid rounded">
                            </div>
                            <div class="col-3 mb-3">
                                <img src="images/${room.roomID}/${room.roomID}_4.jpg" alt="Room Image 4" class="img-fluid rounded">
                            </div>
                        </div>

                    </div>
                    <div class="details-section">
                        <h1>${room.roomName}</h1>
                        <p>Type room: ${room.typeName}</p>
                        <p class="price">Price: <fmt:formatNumber value="${room.price}" pattern="#,##0"/> VNĐ</p>
                        <p>Description: ${room.description}</p>
                    </div>
                </div>

                <!-- Cột bên phải: Form Booking -->
                <div class="col-md-5">
                    <div class="booking-form-card">
                        <h2>Booking</h2>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                ${error}
                            </div>
                        </c:if>
                        <form action="booking" method="get">
                            <!-- Booking ID (readonly) -->
                            <div class="mb-3">
                                <label for="bookingID" class="form-label">Booking ID</label>
                                <input type="text" class="form-control" id="bookingID" name="bookingID" value="${bookingID}" readonly>
                            </div>
                            <!-- Room ID (readonly) -->
                            <div class="mb-3">
                                <label for="roomID" class="form-label">Room ID</label>
                                <input type="text" class="form-control" id="roomID" name="roomID" value="${room.roomID}" readonly>
                            </div>
                            <!-- Booked By (readonly) -->
                            <div class="mb-3">
                                <label for="bookedBy" class="form-label">Booked By</label>
                                <input type="text" class="form-control" id="bookedBy" value="${sessionScope.user.name}" readonly>
                            </div>
                            <!-- Check-in Date -->
                            <div class="mb-3">
                                <label for="checkin" class="form-label">Check-in Date</label>
                                <input type="date" class="form-control" id="checkin" name="checkin">
                            </div>
                            <!-- Check-out Date -->
                            <div class="mb-3">
                                <label for="checkout" class="form-label">Check-out Date</label>
                                <input type="date" class="form-control" id="checkout" name="checkout">
                            </div>
                            <!-- Phone -->
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone">
                            </div>
                            <input type="hidden" id="roomPrice" value="${requestScope.room.price}">
                            <div class="mb-3">
                                <label for="totalPrice" class="form-label">Total Price</label>
                                <input type="text" class="form-control" id="totalPrice" name="totalPrice" value="${param.totalPrice}" readonly>
                            </div>
                            <!-- Hidden action attribute -->
                            <input type="hidden" name="action" value="${requestScope.nextAction}">
                            <!-- Submit Button -->
                            <button type="submit" class="btn btn-primary btn-payment">Payment</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy đơn giá phòng từ hidden input
                var roomPrice = parseFloat(document.getElementById("roomPrice").value) || 0;

                // Lấy các trường ngày check-in và check-out
                var checkinInput = document.getElementById("checkin");
                var checkoutInput = document.getElementById("checkout");
                var totalPriceInput = document.getElementById("totalPrice");

                // Gắn sự kiện thay đổi cho hai trường ngày
                checkinInput.addEventListener("change", calculateTotalPrice);
                checkoutInput.addEventListener("change", calculateTotalPrice);

                function calculateTotalPrice() {
                    var checkinStr = checkinInput.value;
                    var checkoutStr = checkoutInput.value;

                    if (checkinStr && checkoutStr) {
                        var checkinDate = new Date(checkinStr);
                        var checkoutDate = new Date(checkoutStr);

                        // Tính số ngày chênh lệch
                        var timeDiff = checkoutDate - checkinDate;
                        var daysDiff = timeDiff / (1000 * 60 * 60 * 24);

                        // Nếu số ngày > 0, tính tổng giá
                        if (daysDiff > 0) {
                            var total = roomPrice * daysDiff;
                            // Nếu cần định dạng số theo kiểu không có dấu thập phân:
                            totalPriceInput.value = total;
                        } else {
                            totalPriceInput.value = "";
                        }
                    } else {
                        totalPriceInput.value = "";
                    }
                }
            });
        </script>

    </body>
</html>



