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
                int typeRoomID = Integer.parseInt(request.getParameter("typeRoomID"));
                String dateInStr = request.getParameter("dateIn");
                String dateOutStr = request.getParameter("dateOut");

                Date dateIn = null, dateOut = null;

                if ((dateInStr != null && !dateInStr.trim().isEmpty())
                        || (dateOutStr != null && !dateOutStr.trim().isEmpty())) {
                    dateIn = Date.valueOf(dateInStr);
                    dateOut = Date.valueOf(dateOutStr);
                }

                RoomDTO typeRoomDetails = roomDao.getTypeDetails(typeRoomID);

                Integer roomID = bookingDao.findAvailableRoomID(typeRoomID, dateIn, dateOut);
                if (roomID != null) {
                    request.setAttribute("roomID", roomID);
                }

                request.setAttribute("bookingID", generateBookingID());
                request.setAttribute("typeRoomDetails", typeRoomDetails);
                request.setAttribute("dateIn", dateInStr);
                request.setAttribute("dateOut", dateOutStr);
                request.setAttribute("nextAction", "createBooking");
                request.getRequestDispatcher("booking.jsp").forward(request, response);
            } else if (action.equals("createBooking")) {
                int typeRoomID = Integer.parseInt(request.getParameter("typeRoomID"));
                String bookingID = request.getParameter("bookingID");
                String phone = request.getParameter("phone");
                int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));

                String dateInStr = request.getParameter("dateIn");
                String dateOutStr = request.getParameter("dateOut");

                Date dateIn = null, dateOut = null;

                if ((dateInStr != null && !dateInStr.trim().isEmpty())
                        || (dateOutStr != null && !dateOutStr.trim().isEmpty())) {
                    dateIn = Date.valueOf(dateInStr);
                    dateOut = Date.valueOf(dateOutStr);
                }

                RoomDTO typeRoomDetails = roomDao.getTypeDetails(typeRoomID);

                if (dateIn == null || dateOut == null || dateIn.compareTo(dateOut) >= 0) {
                    forwardToBooking(request, response, bookingID, typeRoomDetails,
                            "Error Date: Check-in must be before Check-out.");
                } else {
                    Integer roomID = bookingDao.findAvailableRoomID(typeRoomID, dateIn, dateOut);
                    if (roomID == null) {
                        forwardToBooking(request, response, bookingID, typeRoomDetails,
                                "Error Date: Room is already booked in the selected time period.");
                    }
                    BookingDTO booking = new BookingDTO(bookingID, roomID, typeRoomID, user.getUsername(), phone, dateIn, dateOut, totalPrice);
                    boolean isAdded = bookingDao.addBooking(booking);
                    if (isAdded) {
                        ArrayList<BookingDTO> list = (ArrayList<BookingDTO>) bookingDao.getListUserBooking(user.getUsername());
                        request.setAttribute("bookingList", list);
                        request.getRequestDispatcher("bookingList.jsp").forward(request, response);
                    } else {
                        forwardToBooking(request, response, bookingID, typeRoomDetails, "Booking Fail");
                    }
                }
            }
        }
    }

    private void forwardToBooking(HttpServletRequest request, HttpServletResponse response,
            String bookingID, RoomDTO typeRoomDetails, String errorMessage) throws ServletException, IOException {
        request.setAttribute("bookingID", bookingID);
        request.setAttribute("typeRoomDetails", typeRoomDetails);
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
