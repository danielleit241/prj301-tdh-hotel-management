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

        if (user == null || user.getRole().equals("member")) {
            if (action == null || action.equals("list")) {
                String type = request.getParameter("type");
                String view = request.getParameter("view");
                String keyword = request.getParameter("keyword");
                String dateInStr = request.getParameter("dateIn");
                String dateOutStr = request.getParameter("dateOut");
                String pageStr = request.getParameter("page");

                Date sqlDateIn = null, sqlDateOut = null;

                if ((dateInStr != null && !dateInStr.trim().isEmpty())
                        || (dateOutStr != null && !dateOutStr.trim().isEmpty())) {
                    sqlDateIn = Date.valueOf(dateInStr);
                    sqlDateOut = Date.valueOf(dateOutStr);
                } else {
                    //Back to client time today-tomorrow
                    dateInStr = java.time.LocalDate.now().toString();
                    dateOutStr = java.time.LocalDate.now().plusDays(1).toString();
                }

                int page;
                if (pageStr != null) {
                    page = Integer.parseInt(pageStr);
                } else {
                    page = 1;
                }

                RoomDAO dao = new RoomDAO();
                ArrayList<RoomDTO> list = (ArrayList<RoomDTO>) dao.getListPaging2(page, PAGE_SIZE, keyword, type, view, sqlDateIn, sqlDateOut);

                int totalRoom = dao.countRoomsByAllSearch(sqlDateIn, sqlDateOut,keyword, type, view);

                int totalPages = (int) Math.ceil((double) totalRoom / PAGE_SIZE);

                request.setAttribute("list", list);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("type", type);
                request.setAttribute("view", view);
                request.setAttribute("keyword", keyword);
                request.setAttribute("dateIn", dateInStr);
                request.setAttribute("dateOut", dateOutStr);

                request.getRequestDispatcher("roomList.jsp").forward(request, response);
            } else if (action.equals("details")) {
                String typeRoomIDStr = request.getParameter("typeRoomID");
                String dateIn = request.getParameter("dateIn");
                String dateOut = request.getParameter("dateOut");

                if (typeRoomIDStr == null || typeRoomIDStr.trim().isEmpty()) {
                    response.sendRedirect("./roomList?page=1&keyword=&dateIn=&dateOut=");
                    return;
                }
                int typeRoomID = Integer.parseInt(typeRoomIDStr);

                RoomDAO dao = new RoomDAO();
                RoomDTO room = dao.getTypeDetails(typeRoomID);

                if (room == null) {
                    response.sendRedirect("./roomList?page=1&keyword=&dateIn=&dateOut=");
                    return;
                }
                request.setAttribute("dateIn", dateIn);
                request.setAttribute("dateOut", dateOut);
                request.setAttribute("room", room);
                forwardRoom(request, response, "./roomDetails.jsp");
            }

        } else if (user.getRole().equals("admin")) {
            if (action == null || action.equals("list")) {
                RoomDAO dao = new RoomDAO();
                ArrayList<RoomDTO> list = (ArrayList<RoomDTO>) dao.getAllRoom();
                request.setAttribute("list", list);
                forwardRoom(request, response, "manageRooms.jsp");
            } else if (action.equals("details")) {
                Integer typeRoomID = null;
                try {
                    typeRoomID = Integer.parseInt(request.getParameter("typeRoomID"));
                } catch (NumberFormatException ex) {
                    log("Parameter id has wrong format.");
                }
                RoomDAO dao = new RoomDAO();
                RoomDTO room = dao.getTypeDetails(typeRoomID);

                request.setAttribute("room", room);
                forwardRoom(request, response, "roomDetails.jsp");

            } else if (action.equals("edit")) {
                Integer typeRoomID = null;
                try {
                    typeRoomID = Integer.parseInt(request.getParameter("typeRoomID"));
                } catch (NumberFormatException ex) {
                    log("Parameter id has wrong format.");
                }
                RoomDAO dao = new RoomDAO();
                RoomDTO room = dao.getTypeDetails(typeRoomID);
                request.setAttribute("room", room);
                forwardRoom(request, response, "roomEdit.jsp");

            } else if (action.equals("update")) {
                try {
                    RoomDTO room = new RoomDTO();
                    Integer typeRoomID = null;
                    Integer price = null;
                    try {
                        typeRoomID = Integer.parseInt(request.getParameter("typeRoomID"));
                        price = Integer.parseInt(request.getParameter("price"));
                    } catch (NumberFormatException ex) {
                        log("Parameter id has wrong format.");
                    }

                    room.setTypeRoomID(typeRoomID);
                    room.setTypeName(request.getParameter("typeName"));
                    room.setTypeDes(request.getParameter("typeDes"));
                    room.setPrice(price);
                    room.setRoomSize(request.getParameter("roomSize"));
                    room.setBedSize(request.getParameter("bedSize"));
                    room.setMaxOccupancy(request.getParameter("maxOccupancy"));
                    room.setViewDetail(request.getParameter("viewDetail"));
                    room.setBathroom(request.getParameter("bathroom"));
                    room.setSmoking(request.getParameter("smoking"));

                    RoomDAO dao = new RoomDAO();
                    room = dao.updateRoom(room);

                    if (room != null) {
                        response.sendRedirect("manageRooms?action=details&typeRoomID=" + typeRoomID + "");
                    } else {
                        request.setAttribute("error", "Update failed. Try again");
                        forwardRoom(request, response, "roomEdit.jsp");
                    }

                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid input. Please enter valid numbers for price and ID.");
                    forwardRoom(request, response, "roomEdit.jsp");
                }
            }
        }
    }

    private void forwardRoom(HttpServletRequest request, HttpServletResponse response, String page)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
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
