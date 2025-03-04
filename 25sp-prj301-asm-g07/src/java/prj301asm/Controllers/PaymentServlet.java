/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prj301.asm.Payment.PaymentDAO;
import prj301asm.Booking.BookingDAO;
import prj301asm.Booking.BookingDTO;

/**
 *
 * @author hoade
 */
public class PaymentServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        if (action.equals("confirmed")) {
            String bookingID = request.getParameter("bookingID");
            String method = request.getParameter("method");

            if (bookingID != null) {
                BookingDAO bookingDAO = new BookingDAO();
                bookingDAO.confirmedBooking(bookingID);
                PaymentDAO paymentDAO = new PaymentDAO();
                String paymentID = generatePaymentID();
                paymentDAO.createPayment(paymentID, bookingID, method);

                
                ArrayList<BookingDTO> list = (ArrayList<BookingDTO>) bookingDAO.getAllRoomBookings();
                request.setAttribute("roomBookings", list);
                request.getRequestDispatcher("manageBookings.jsp").forward(request, response);
            }

        }
    }

    private String generatePaymentID() {
        String uniqueID = null;
        int nextNumber = 000001;
        PaymentDAO dao = new PaymentDAO();
        String maxID = dao.getMaxPaymentId();
        if (maxID != null) {
            String numPart = maxID.replace("P", "");
            try {
                int currentMax = Integer.parseInt(numPart);
                nextNumber = currentMax + 1;
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }
        uniqueID = "P" + String.format("%06d", nextNumber);
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
