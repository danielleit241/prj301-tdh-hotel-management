<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Room List</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Monsieur+La+Doulaise&display=swap" rel="stylesheet">    
        <!--icon cây chổi-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0&icon_names=refresh" />
        <link rel="stylesheet" href="css/style.css"/>

        <!-- Bootstrap CSS -->
        <link 
            rel="stylesheet" 
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
            />
        <!-- Bootstrap Icons CSS -->
        <link 
            rel="stylesheet" 
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
            />

        <script>
            function resetForm() {
                window.location.href = "./roomList?action=list";
            }
        </script>
    </head>
    <body>
        <%@include file="/navbar.jsp"%>
        <div class="search-container" style="margin-bottom: 15px">
            <div class="date-selection">
                <input type="date" name="dateIn" value="${dateIn}">
                <input type="date" name="dateOut" value="${dateOut}">
            </div>

            <form action="./roomList" class="search-form">
                <input type="text" name="keyword" placeholder="Search..." value="${keyword}">

                <select name="type">
                    <option value="">Room Type</option>
                    <option value="DELUXE KING" ${type == 'DELUXE KING' ? 'selected' : ''}>DELUXE KING</option>
                    <option value="DELUXE DOUBLE" ${type == 'DELUXE DOUBLE' ? 'selected' : ''}>DELUXE DOUBLE</option>
                    <option value="PREMIER KING" ${type == 'PREMIER KING' ? 'selected' : ''}>PREMIER KING</option>
                    <option value="JUNIOR SUITE" ${type == 'JUNIOR SUITE' ? 'selected' : ''}>JUNIOR SUITE</option>
                    <option value="DELUXE ONE BEDROOM SUITE" ${type == 'DELUXE ONE BEDROOM SUITE' ? 'selected' : ''}>DELUXE ONE BEDROOM SUITE</option>
                    <option value="PREMIER ONE BEDROOM SUITE" ${type == 'PREMIER ONE BEDROOM SUITE' ? 'selected' : ''}>PREMIER ONE BEDROOM SUITE</option>
                    <option value="TWO BEDROOM SUITE" ${type == 'TWO BEDROOM SUITE' ? 'selected' : ''}>TWO BEDROOM SUITE</option>
                    <option value="THD PENTHOUSE SUITE" ${type == 'THD PENTHOUSE SUITE' ? 'selected' : ''}>THD PENTHOUSE SUITE</option>
                    <option value="ONE BEDROOM SUITE" ${type == 'ONE BEDROOM SUITE' ? 'selected' : ''}>ONE BEDROOM SUITE</option>
                </select>
                <select name="view">
                    <option value="">View Details</option>
                    <option value="City view" ${view == 'City view' ? 'selected' : ''}>City view</option>
                    <option value="River view" ${view == 'River view' ? 'selected' : ''}>River view</option>
                    <option value="Skyline view" ${view == 'Skyline view' ? 'selected' : ''}>Skyline view</option>
                </select>

                <input type="hidden" name="page" value="${currentPage != null ? currentPage : 1}" />
                <input type="hidden" name="action" value="list"/>
                <input type="submit" value="Search" class="search-button">

                <button type="button" onclick="resetForm()" class="reset-button">
                    <span class="material-symbols-outlined">
                        refresh
                    </span>
                </button>
            </form>
        </div>
        <!-- END SEARCH BAR -->

        <!-- ROOM LIST -->
        <div class="container mb-4 roomList">
            <c:forEach var="room" items="${list}">
                <!-- Card-style row -->
                <div class="row bg-white shadow mb-3">
                    <!-- Ảnh phòng -->
                    <div class="col-md-4">
                        <!-- img-fluid: co giãn theo cột, h-100 + object-fit-cover: cho ảnh full cột -->
                        <img 
                            src="images/${room.typeRoomID}/${room.typeRoomID}.jpg" 
                            alt="Room Image" 
                            style="width: 100%; height: 300px; margin: 20px auto"
                            />
                    </div>

                    <!-- Thông tin phòng -->
                    <div class="col-md-8 p-4 d-flex flex-column justify-content-between">
                        <!-- Tiêu đề & Giá -->
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h3 class="text-uppercase fw-bold mb-0">
                                <c:choose>
                                    <c:when test="${not empty room.viewDetail}">
                                        ${room.typeName}, ${room.viewDetail}
                                    </c:when>
                                    <c:otherwise>
                                        ${room.typeName}
                                    </c:otherwise>
                                </c:choose>
                            </h3>
                            <span class="fw-bold text-danger" style="font-size: 22px">
                                $<fmt:formatNumber value="${room.price}" pattern="#,##0"/> /NIGHT
                            </span>
                        </div>

                        <!-- Mô tả chi tiết -->
                        <div class="mb-3">
                            <h5 class="mb-1">${room.typeDes}</h5>
                        </div>
                        <div class="row row-cols-2 g-2 text-center" style="width: 45%">
                            <!-- 1. City View -->
                            <div class="col d-flex flex-column">
                                <i class="bi bi-buildings fs-2"></i>
                                <p class="mt-2 mb-0">${room.viewDetail}</p>
                            </div>

                            <!-- 4. Complimentary Nespresso -->
                            <div class="col d-flex flex-column">
                                <i class="bi bi-cup-hot fs-2"></i>
                                <p class="mt-2 mb-0">Complimentary Nespresso</p>
                            </div>

                            <!-- 5. 400 sq.ft -->
                            <div class="col d-flex flex-column">
                                <i class="bi bi-rulers fs-2"></i>
                                <p class="mt-2 mb-0">${room.roomSize}</p>
                            </div>

                            <!-- 6. Complimentary Wifi -->
                            <div class="col d-flex flex-column">
                                <i class="bi bi-wifi fs-2"></i>
                                <p class="mt-2 mb-0">Complimentary Wifi</p>
                            </div>
                        </div>


                        <div class="d-flex justify-content-between align-items-center">
                            <span class="text-muted small"></span>
                            <form action="roomList" method="get" class="mb-0">
                                <input type="hidden" name="typeRoomID" value="${room.typeRoomID}" />
                                <input type="hidden" name="dateIn" value="${dateIn}" />
                                <input type="hidden" name="dateOut" value="${dateOut}" />
                                <input type="hidden" name="action" value="details" />
                                <button type="submit" class="btn btn-warning fw-bold">
                                    VIEW OFFERS
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- END ROOM LIST -->

        <!-- PAGINATION -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="./roomList?page=${currentPage - 1}&dateIn=${dateIn}&dateOut=${dateOut}&keyword=${keyword}&type=${type}&view=${view}" class="prev">Prev</a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="./roomList?page=${i}&dateIn=${dateIn}&dateOut=${dateOut}&keyword=${keyword}&type=${type}&view=${view}"
                   <c:if test="${currentPage == i}">class="active"</c:if>>${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="./roomList?page=${currentPage + 1}&dateIn=${dateIn}&dateOut=${dateOut}&keyword=${keyword}&type=${type}&view=${view}" class="next">Next</a>
            </c:if>
        </div>

    </body>
</html>
