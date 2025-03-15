/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import prj301asm.Room.RoomDAO;
import prj301asm.Room.RoomDTO;
import prj301asm.Booking.BookingDAO;
import prj301asm.Booking.BookingDTO;
import prj301asm.User.UserDTO;

/**
 *
 * @author ACER
 */
public class BookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserDTO user = (UserDTO) session.getAttribute("user");
        String username = user.getUsername();
        String action = request.getParameter("action");

        if ("admin".equals(user.getRole())) {
            handleAdminActions(request, response, action, username);
        } else if ("member".equals(user.getRole())) {
            handleMemberActions(request, response, action, username);
        }
    }

    private void handleAdminActions(HttpServletRequest request, HttpServletResponse response, String action, String username)
            throws ServletException, IOException {
        BookingDAO bDao = new BookingDAO();
        RoomDAO rDao = new RoomDAO();
        switch (action) {
            case "adminlist":
                request.setAttribute("roomBookings", bDao.getAdminBooking());
                forward(request, response, "manageBookings.jsp");
                break;
            case "edit":
                editBooking(request, response, bDao);
                forward(request, response, "bookingEdit.jsp");
                break;
            case "update":
                updateBooking(request, response, bDao);
                break;
            case "mlist":
                request.setAttribute("bookingList", bDao.getUserBooking(request.getParameter("username")));
                forward(request, response, "bookingList.jsp");
                break;
            case "mbooking":
                prepareBookingPage(request, response, bDao, rDao);
                break;
            case "createBooking":
                createBooking(request, response, bDao, rDao, username);
                break;
            default:
                response.sendRedirect("dashboard.jsp");
        }
    }

    private void handleMemberActions(HttpServletRequest request, HttpServletResponse response, String action, String username)
            throws ServletException, IOException {

        BookingDAO bDao = new BookingDAO();
        RoomDAO rDao = new RoomDAO();

        switch (action) {
            case "mlist":
                request.setAttribute("bookingList", bDao.getUserBooking(username));
                forward(request, response, "bookingList.jsp");
                break;

            case "mbooking":
                prepareBookingPage(request, response, bDao, rDao);
                break;

            case "createBooking":
                createBooking(request, response, bDao, rDao, username);
                break;

            default:
                response.sendRedirect("home.jsp");
        }
    }

    private void editBooking(HttpServletRequest request, HttpServletResponse response, BookingDAO dao) {
        String bookingID = request.getParameter("bookingID");
        BookingDTO booking = dao.load(bookingID);

        ArrayList<RoomDTO> availableRooms = (ArrayList<RoomDTO>) dao.findAllAvailableRoom(booking.getTypeRoomID(),
                booking.getCheckInDate(), booking.getCheckOutDate());

        request.setAttribute("booking", booking);
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("nextAction", "update");
    }

    private void updateBooking(HttpServletRequest request, HttpServletResponse response, BookingDAO dao)
            throws ServletException, IOException {

        String bookingID = request.getParameter("bookingID");
        String phone = request.getParameter("phone");
        String status = request.getParameter("status");
        String roomIDStr = request.getParameter("roomID");

        if (roomIDStr != null) {
            int roomID = Integer.parseInt(roomIDStr);
            if (dao.updateBooking(bookingID, phone, status, roomID)) {
                request.setAttribute("roomBookings", dao.getAdminBooking());
                forward(request, response, "manageBookings.jsp");
            }
        }
    }

    private void prepareBookingPage(HttpServletRequest request, HttpServletResponse response, BookingDAO bookingDao, RoomDAO roomDao)
            throws ServletException, IOException {

        int typeRoomID = Integer.parseInt(request.getParameter("typeRoomID"));
        Date dateIn = parseDate(request.getParameter("dateIn"));
        Date dateOut = parseDate(request.getParameter("dateOut"));

        RoomDTO typeRoomDetails = roomDao.getTypeDetails(typeRoomID);
        Integer roomID = bookingDao.findAvailableRoomID(typeRoomID, dateIn, dateOut);

        if (roomID != null) {
            request.setAttribute("roomID", roomID);
        }

        request.setAttribute("bookingID", generateBookingID());
        request.setAttribute("typeRoomDetails", typeRoomDetails);
        request.setAttribute("dateIn", request.getParameter("dateIn"));
        request.setAttribute("dateOut", request.getParameter("dateOut"));
        request.setAttribute("nextAction", "createBooking");
        forward(request, response, "booking.jsp");
    }

    private void createBooking(HttpServletRequest request, HttpServletResponse response, BookingDAO bookingDao, RoomDAO roomDao, String username)
            throws ServletException, IOException {

        int typeRoomID = Integer.parseInt(request.getParameter("typeRoomID"));
        String bookingID = request.getParameter("bookingID");
        String phone = request.getParameter("phone");
        int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));

        Date dateIn = parseDate(request.getParameter("dateIn"));
        Date dateOut = parseDate(request.getParameter("dateOut"));

        RoomDTO typeRoomDetails = roomDao.getTypeDetails(typeRoomID);

        if (dateIn == null || dateOut == null || dateIn.compareTo(dateOut) >= 0) {
            forwardToBooking(request, response, bookingID, typeRoomDetails, "Invalid check-in/check-out dates.");
            return;
        }

        Integer roomID = bookingDao.findAvailableRoomID(typeRoomID, dateIn, dateOut);
        BookingDTO booking = new BookingDTO(bookingID, roomID, typeRoomID, username, phone, dateIn, dateOut, totalPrice);
        if (bookingDao.addBooking(booking)) {
            request.setAttribute("bookingList", bookingDao.getUserBooking(username));
            forward(request, response, "bookingList.jsp");
        } else {
            forwardToBooking(request, response, bookingID, typeRoomDetails, "Error: Booking failed.");
        }
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        request.getRequestDispatcher(page).forward(request, response);
    }

    private void forwardToBooking(HttpServletRequest request, HttpServletResponse response,
            String bookingID, RoomDTO typeRoomDetails, String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("bookingID", bookingID);
        request.setAttribute("typeRoomDetails", typeRoomDetails);
        request.setAttribute("error", errorMessage);
        forward(request, response, "booking.jsp");
    }

    private Date parseDate(String dateStr) {
        return (dateStr != null && !dateStr.trim().isEmpty()) ? Date.valueOf(dateStr) : null;
    }

    private String generateBookingID() {
        int nextNumber = 1;
        String maxID = new BookingDAO().getMaxBookingId();
        if (maxID != null) {
            nextNumber = Integer.parseInt(maxID.replace("B", "")) + 1;
        }
        return "B" + String.format("%06d", nextNumber);
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
