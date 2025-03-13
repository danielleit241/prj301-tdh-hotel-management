/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import prj301asm.Room.RoomDAO;
import prj301asm.Room.RoomDTO;
import prj301asm.User.UserDTO;

/**
 *
 * @author hoade
 */
public class RoomServlet extends HttpServlet {

    private static final int PAGE_SIZE = 3;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDTO user = (UserDTO) session.getAttribute("user");
        String action = request.getParameter("action");

        if (user.getRole().equals("admin")) {
            handleAdminActions(request, response, action);
        } else {
            handleMemberActions(request, response, action);
        }
    }

    private void handleMemberActions(HttpServletRequest request, HttpServletResponse response, String action) throws ServletException, IOException {
        if (action == null || action.equals("mlist")) {
            listRooms(request, response);
        } else if ("mdetails".equals(action)) {
            showRoomDetails(request, response);
        }
    }

    private void handleAdminActions(HttpServletRequest request, HttpServletResponse response, String action) throws ServletException, IOException {
        if (action == null || action.equals("adminlist")) {
            RoomDAO dao = new RoomDAO();
            request.setAttribute("list", dao.getAllRoom());
            forward(request, response, "manageRooms.jsp");
        } else if ("edit".equals(action)) {
            editRoom(request, response);
        } else if ("update".equals(action)) {
            updateRoom(request, response);
        } else {
            handleMemberActions(request, response, action);
        }
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String view = request.getParameter("view");
        String keyword = request.getParameter("keyword");

        Date sqlDateIn = parseDate(request.getParameter("dateIn"), java.time.LocalDate.now().toString());
        Date sqlDateOut = parseDate(request.getParameter("dateOut"), java.time.LocalDate.now().plusDays(1).toString());

        int page = parseInteger(request.getParameter("page"), 1);

        RoomDAO dao = new RoomDAO();
        ArrayList<RoomDTO> list = (ArrayList<RoomDTO>) dao.getListPaging(page, PAGE_SIZE, keyword, type, view, sqlDateIn, sqlDateOut);
        int totalRoom = dao.countRooms(sqlDateIn, sqlDateOut, keyword, type, view);

        request.setAttribute("list", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", (int) Math.ceil((double) totalRoom / PAGE_SIZE));
        request.setAttribute("type", type);
        request.setAttribute("view", view);
        request.setAttribute("keyword", keyword);
        request.setAttribute("dateIn", sqlDateIn.toString());
        request.setAttribute("dateOut", sqlDateOut.toString());

        forward(request, response, "roomList.jsp");
    }

    private void showRoomDetails(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int typeRoomID = parseInteger(request.getParameter("typeRoomID"), -1);
        if (typeRoomID == -1) {
            response.sendRedirect("./roomList?page=1&keyword=&dateIn=&dateOut=");
            return;
        }

        RoomDAO dao = new RoomDAO();
        RoomDTO room = dao.getTypeDetails(typeRoomID);
        if (room == null) {
            response.sendRedirect("./roomList?page=1&keyword=&dateIn=&dateOut=");
            return;
        }

        request.setAttribute("room", room);
        request.setAttribute("dateIn", request.getParameter("dateIn"));
        request.setAttribute("dateOut", request.getParameter("dateOut"));
        forward(request, response, "roomDetails.jsp");
    }

    private void editRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int typeRoomID = parseInteger(request.getParameter("typeRoomID"), -1);
        if (typeRoomID == -1) {
            response.sendRedirect("manageRooms.jsp");
            return;
        }

        RoomDAO dao = new RoomDAO();
        request.setAttribute("room", dao.getTypeDetails(typeRoomID));
        forward(request, response, "roomEdit.jsp");
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            RoomDTO room = new RoomDTO();
            room.setTypeRoomID(parseInteger(request.getParameter("typeRoomID"), -1));
            room.setTypeName(request.getParameter("typeName"));
            room.setTypeDes(request.getParameter("typeDes"));
            room.setPrice(parseInteger(request.getParameter("price"), 0));
            room.setRoomSize(request.getParameter("roomSize"));
            room.setBedSize(request.getParameter("bedSize"));
            room.setMaxOccupancy(request.getParameter("maxOccupancy"));
            room.setViewDetail(request.getParameter("viewDetail"));
            room.setBathroom(request.getParameter("bathroom"));
            room.setSmoking(request.getParameter("smoking"));

            RoomDAO dao = new RoomDAO();
            if (dao.updateRoom(room) != null) {
                response.sendRedirect("manageRooms?action=details&typeRoomID=" + room.getTypeRoomID());
            } else {
                request.setAttribute("error", "Update failed. Try again");
                forward(request, response, "roomEdit.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid input. Please check your values.");
            forward(request, response, "roomEdit.jsp");
        }
    }

    private void forward(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    private int parseInteger(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private Date parseDate(String value, String defaultValue) {
        return (value != null && !value.trim().isEmpty()) ? Date.valueOf(value) : Date.valueOf(defaultValue);
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
