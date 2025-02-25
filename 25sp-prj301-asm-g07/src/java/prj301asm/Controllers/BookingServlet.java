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

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        /* TODO output your page here. You may use following sample code. */
        HttpSession session = request.getSession(false);
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user.getRole().equals("admin")) {
            BookingDAO dao = new BookingDAO();
            ArrayList<BookingDTO> list = (ArrayList<BookingDTO>) dao.getAllRoomBookings();
            request.setAttribute("roomBookings", list);
            request.getRequestDispatcher("manageBookings.jsp").forward(request, response);
        } else if (user.getRole().equals("member")) {
            String action = request.getParameter("action");
            BookingDAO bookingDao = new BookingDAO();
            RoomDAO roomDao = new RoomDAO();
            if (action.equals("list")) {
                ArrayList<BookingDTO> list = (ArrayList<BookingDTO>) bookingDao.getListUserBooking(user.getUsername());
                request.setAttribute("bookingList", list);
                request.getRequestDispatcher("bookingList.jsp").forward(request, response);
            } else if (action.equals("booking")) {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                RoomDTO room = roomDao.getRoomByID(roomID);
                request.setAttribute("bookingID", generateBookingID());
                request.setAttribute("room", room);
                request.setAttribute("nextAction", "createBooking");
                request.getRequestDispatcher("booking.jsp").forward(request, response);
            } else if (action.equals("createBooking")) {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                String bookingID = request.getParameter("bookingID");
                String phone = request.getParameter("phone");
                int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
                String dateIn = request.getParameter("checkin");
                String dateOut = request.getParameter("checkout");
                
                Date checkinDate = Date.valueOf(dateIn);
                Date checkoutDate = Date.valueOf(dateOut);

                RoomDTO room = roomDao.getRoomByID(roomID);

                if (checkinDate.compareTo(checkoutDate) >= 0) {
                    forwardToBookingJSP(request, response, bookingID, room,
                            "Error Date: Check-in must be before Check-out.");
                } else {
                    boolean booked = bookingDao.isBooked(roomID, checkinDate, checkoutDate);
                    if (booked) {
                        forwardToBookingJSP(request, response, bookingID, room,
                                "Error Date: Room is already booked in the selected time period.");
                    }
                    BookingDTO booking = new BookingDTO(bookingID, user.getUsername(), roomID, phone, checkinDate, checkoutDate, totalPrice);
                    boolean isAdded = bookingDao.addBooking(booking);
                    if (isAdded) {
                        ArrayList<BookingDTO> list = (ArrayList<BookingDTO>) bookingDao.getListUserBooking(user.getUsername());
                        request.setAttribute("bookingList", list);
                        request.getRequestDispatcher("bookingList.jsp").forward(request, response);
                    } else {
                        forwardToBookingJSP(request, response, bookingID, room, "Booking Fail");
                    }

                }

            }
        }
    }

    private void forwardToBookingJSP(HttpServletRequest request, HttpServletResponse response,
            String bookingID, RoomDTO room, String errorMessage) throws ServletException, IOException {
        request.setAttribute("bookingID", bookingID);
        request.setAttribute("room", room);
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("booking.jsp").forward(request, response);
    }

    private String generateBookingID() {
        String uniqueID = null;
        int nextNumber = 000001;
        BookingDAO dao = new BookingDAO();
        String maxID = dao.getMaxBookingId();
        if (maxID != null) {
            String numPart = maxID.replace("B", "");
            try {
                int currentMax = Integer.parseInt(numPart);
                nextNumber = currentMax + 1;
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
        uniqueID = "B" + String.format("%06d", nextNumber);
        return uniqueID;
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
