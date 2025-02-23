/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prj301asm.Room.RoomDAO;
import prj301asm.Room.RoomDTO;

/**
 *
 * @author TRAN PHU THINH
 */
public class RoomDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomIDParam = request.getParameter("roomID");
        if (roomIDParam == null || roomIDParam.trim().isEmpty()) {
            response.sendRedirect("./roomList?page=1");
            return;
        }

        int id = Integer.parseInt(roomIDParam);
        request.setAttribute("id", id);
        RoomDAO dao = new RoomDAO();
        RoomDTO room = dao.getRoomByID(id);
        if (room == null) {
            response.sendRedirect("./roomList?page=1");
            return;
        } else {
            request.setAttribute("roomDetail", room);
            request.getRequestDispatcher("roomDetails.jsp").forward(request, response);
            return;
        }
    }

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
