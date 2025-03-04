<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lý Đánh Giá - Hotel Management (Giao Diện Đẹp)</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../css/style.css"/>
        <!--font - family-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f9; margin: 0; padding: 0; color: #333; }
            .container { width: 90%; max-width: 1200px; margin: 20px auto; background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.05); }
            h1 { text-align: center; color: #007bff; margin-bottom: 25px; }
            table { width: 100%; border-collapse: collapse; margin-top: 20px; background-color: #fff; box-shadow: 0 2px 4px rgba(0,0,0,0.03); }
            th, td { border: 1px solid #e0e0e0; padding: 12px 15px; text-align: left; }
            th { background-color: #e9ecef; color: #495057; font-weight: 500; }
            tbody tr:nth-child(even) { background-color: #f9f9f9; }
            tbody tr:hover { background-color: #f0f0f0; }
            .action-buttons { text-align: center; }
            .action-buttons button {
                padding: 8px 15px;
                margin: 5px;
                cursor: pointer;
                border: none;
                border-radius: 5px;
                color: #fff;
                font-weight: 500;
                transition: background-color 0.3s ease;
            }
            .action-buttons button.view { background-color: #007bff; }
            .action-buttons button.view:hover { background-color: #0056b3; }
            .action-buttons button.delete { background-color: #dc3545; }
            .action-buttons button.delete:hover { background-color: #c82333; }
            .no-reviews { text-align: center; padding: 20px; color: #777; }

            .dropdown-menu {
                background-color: black;
            }
            .dropdown-item {
                color: white;
            }
            .dropdown-item:hover {
                background-color: #333;
            }
            .bg-light {
                padding: 10px 355px;

            }
        </style>
    </head>
    <body>
        <%@include file="adminNavbar.jsp" %>
        <div class="container">
            <h1>Quản Lý Đánh Giá Phản Hồi</h1>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Room ID</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Ngày tạo</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>nguyenvana</td>
                        <td>101</td>
                        <td>5</td>
                        <td>Phòng rất tuyệt vời, sạch sẽ và tiện nghi. Nhân viên thân thiện.</td>
                        <td>2024-07-28 10:30</td>
                        <td class="action-buttons">
                            <button class="view">Xem</button>
                            <button class="delete">Xóa</button>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>tranthib</td>
                        <td>205</td>
                        <td>4</td>
                        <td>Khách sạn ở vị trí đẹp, gần trung tâm. Giá cả hợp lý.</td>
                        <td>2024-07-29 15:45</td>
                        <td class="action-buttons">
                            <button class="view">Xem</button>
                            <button class="delete">Xóa</button>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>leminhc</td>
                        <td>310</td>
                        <td>3</td>
                        <td>Phòng ổn, nhưng hơi ồn vào ban đêm.</td>
                        <td>2024-07-30 09:10</td>
                        <td class="action-buttons">
                            <button class="view">Xem</button>
                            <button class="delete">Xóa</button>
                        </td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>phamthidung</td>
                        <td>105</td>
                        <td>5</td>
                        <td>Tôi rất hài lòng với dịch vụ của khách sạn. Chắc chắn sẽ quay lại.</td>
                        <td>2024-07-31 14:20</td>
                        <td class="action-buttons">
                            <button class="view">Xem</button>
                            <button class="delete">Xóa</button>
                        </td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>vothikim</td>
                        <td>201</td>
                        <td>4</td>
                        <td>Ăn sáng ngon và đa dạng. Phòng tắm sạch sẽ.</td>
                        <td>2024-08-01 11:55</td>
                        <td class="action-buttons">
                            <button class="view">Xem</button>
                            <button class="delete">Xóa</button>
                        </td>
                    </tr>
                    <tr>
                        <td>6</td>
                        <td>nguyenvanb</td>
                        <td>402</td>
                        <td>2</td>
                        <td>Wifi yếu, phòng không được cách âm tốt.</td>
                        <td>2024-08-02 16:30</td>
                        <td class="action-buttons">
                            <button class="view">Xem</button>
                            <button class="delete">Xóa</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>