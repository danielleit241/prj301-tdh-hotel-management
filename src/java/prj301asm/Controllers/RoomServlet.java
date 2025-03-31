/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import prj301asm.Room.RoomDAO;
import prj301asm.Room.RoomDTO;
import prj301asm.User.UserDTO;

@WebServlet("/UploadImage")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)

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
            handleMemberActions(request, response, action);
        } else if (user.getRole().equals("admin")) {
            handleAdminActions(request, response, action);
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
        } else if ("details".equals(action)) {
            showRoomDetails(request, response);
        } else if ("edit".equals(action)) {
            editTypeRoom(request, response);
        } else if ("update".equals(action)) {
            updateRoom(request, response);
        } else if ("create".equals(action)) {
            createTypeRoom(request, response);
        } else if ("insert".equals(action)) {
            insertTypeRoom(request, response);
        } else if ("delete".equals(action)) {
            deleteTypeRoom(request, response);
        } else if (action.equals("deleteRoom")) {
            deleteRoom(request, response);
        } else if (action.equals("insertRoom")) {
            insertRoom(request, response);
        }else if("delete".equals(action)){
            deleteTypeRoom(request, response);
        }
        else if (action.equals("mlist")) {
            listRooms(request, response);
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
        List<RoomDTO> roomlist = dao.getlistRoomByType(typeRoomID);
        request.setAttribute("listRoom", roomlist);
        request.setAttribute("room", room);
        request.setAttribute("dateIn", request.getParameter("dateIn"));
        request.setAttribute("dateOut", request.getParameter("dateOut"));
        forward(request, response, "roomDetails.jsp");
    }

    private void editTypeRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int typeRoomID = parseInteger(request.getParameter("typeRoomID"), -1);
        if (typeRoomID == -1) {
            response.sendRedirect("manageRooms.jsp");
            return;
        }
        RoomDAO dao = new RoomDAO();
        List<RoomDTO> roomlist = dao.getlistRoomByType(typeRoomID);
        request.setAttribute("listRoom", roomlist);
        request.setAttribute("nextActionTypeRoom", "update");
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

    private void insertRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Integer roomID = parseInteger(request.getParameter("roomID"), -1);
            Integer typeRoomID = parseInteger(request.getParameter("typeRoomID"), -1);
            RoomDAO dao = new RoomDAO();

            if (roomID <= 0 || typeRoomID <= 0) {
                request.setAttribute("error", "Invalid Room ID or Type Room ID. Please enter valid values.");
                request.setAttribute("room", dao.getTypeDetails(typeRoomID));
                request.setAttribute("listRoom", dao.getlistRoomByType(typeRoomID));
                forward(request, response, "roomEdit.jsp");
                return;
            }
                     
            List<RoomDTO> existingRooms = dao.getlistRoomByType(typeRoomID);
            for (RoomDTO room : existingRooms) {
                if (room.getRoomID() == roomID) {
                    request.setAttribute("error", "Room ID " + roomID + " already exists for this type. Please enter a different Room ID.");
                    request.setAttribute("room", dao.getTypeDetails(typeRoomID));
                    request.setAttribute("listRoom", existingRooms);
                    forward(request, response, "roomEdit.jsp");
                    return;
                }
            }

            if (dao.insertRooms(roomID, typeRoomID)) {
                response.sendRedirect("manageRooms?action=edit&typeRoomID=" + typeRoomID);
            } else {
                request.setAttribute("error", "Failed to create room. Please try again.");
                request.setAttribute("room", dao.getTypeDetails(typeRoomID));
                request.setAttribute("listRoom", existingRooms);
                forward(request, response, "roomEdit.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.setAttribute("room", new RoomDAO().getTypeDetails(parseInteger(request.getParameter("typeRoomID"), -1)));
            request.setAttribute("listRoom", new RoomDAO().getlistRoomByType(parseInteger(request.getParameter("typeRoomID"), -1)));
            forward(request, response, "roomEdit.jsp");
        }
    }

    private void deleteRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Integer roomID = parseInteger(request.getParameter("roomID"), -1);
            Integer typeRoomID = parseInteger(request.getParameter("typeRoomID"), -1);
            RoomDAO dao = new RoomDAO();
            if (dao.deleteRoom(roomID, typeRoomID)) {
                List<RoomDTO> roomlist = dao.getlistRoomByType(typeRoomID);
                request.setAttribute("listRoom", roomlist);
                request.setAttribute("room", dao.getTypeDetails(typeRoomID));
                forward(request, response, "roomEdit.jsp");
            }
        } catch (Exception e) {
        }
    }

    private void deleteTypeRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            String typeRoomIDStr = request.getParameter("typeRoomID").trim();
            int typeRoomID = -1;

            try {
                typeRoomID = Integer.parseInt(typeRoomIDStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid TypeRoomID value.");
                forward(request, response, "roomEdit.jsp");
                return;
            }

            RoomDAO dao = new RoomDAO();
            if (typeRoomID != -1) {
                dao.delete(typeRoomID);
            }

            List<RoomDTO> list = dao.getAllRoom();

            request.setAttribute("list", list);
            request.getRequestDispatcher("manageRooms.jsp").forward(request, response);
        } catch (Exception e) {

        }
    }

    private void createTypeRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            RoomDAO dao = new RoomDAO();
            int newtypeRoomID = dao.getMaxTypeRoomID() + 1;  // Lấy maxID + 1 từ cơ sở dữ liệu
            
            

            RoomDTO room = new RoomDTO();
            room.setTypeRoomID(newtypeRoomID);  // Gán typeRoomID cho room
            request.setAttribute("room", room);  // Truyền room vào request            
            
            request.setAttribute("nextActionTypeRoom", "insert");  // Thiết lập hành động để insert


            request.getRequestDispatcher("roomEdit.jsp").forward(request, response);  // Chuyển hướng tới JSP
        } catch (Exception e) {
            request.setAttribute("error", "Invalid input. Please check your values.");
            request.getRequestDispatcher("roomEdit.jsp").forward(request, response);  // Chuyển hướng khi gặp lỗi
        }
    }

    private void insertTypeRoom(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            String typeRoomIDStr = request.getParameter("typeRoomID").trim();
            int typeRoomID = -1;

            try {
                typeRoomID = Integer.parseInt(typeRoomIDStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid TypeRoomID value.");
                forward(request, response, "roomEdit.jsp");
                return;
            }
            
            int price = parseInteger(request.getParameter("price"), -1);
            if (price == -1) {
                request.setAttribute("error", "Invalid Price value.");
                forward(request, response, "roomEdit.jsp");
                return;
            }
            
            String appPath = getServletContext().getRealPath("");
            String folderPath = appPath + File.separator + "images" + File.separator + typeRoomID; 

            File folder = new File(folderPath);
            if (!folder.exists()) {
                folder.mkdirs(); 
            }
            Collection<Part> fileParts = request.getParts(); 
            for (Part filePart : fileParts) {
                if (filePart.getName().equals("roomImages")) { 
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); 

                    // Lưu tệp vào thư mục
                    File file = new File(folderPath + File.separator + fileName);
                    try (InputStream fileContent = filePart.getInputStream()) {
                        Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                }
            }

            // Tiến hành lưu trữ các giá trị
            String typeName = request.getParameter("typeName");
            String typeDes = request.getParameter("typeDes");
            String roomSize = request.getParameter("roomSize");
            String bedSize = request.getParameter("bedSize");
            String maxOccupancy = request.getParameter("maxOccupancy");
            String viewDetail = request.getParameter("viewDetail");
            String bathroom = request.getParameter("bathroom");
            String smoking = request.getParameter("smoking");

            RoomDTO room = new RoomDTO();
            room.setTypeRoomID(typeRoomID);
            room.setTypeName(typeName);
            room.setTypeDes(typeDes);
            room.setPrice(price);
            room.setRoomSize(roomSize);
            room.setBedSize(bedSize);
            room.setMaxOccupancy(maxOccupancy);
            room.setViewDetail(viewDetail);
            room.setBathroom(bathroom);
            room.setSmoking(smoking);

            RoomDAO dao = new RoomDAO();
            if (dao.insert(room) != null) {
                List<RoomDTO> list = dao.getAllRoom();
                request.setAttribute("list", list);
                
                request.getRequestDispatcher("manageRooms.jsp").forward(request, response);  // Chuyển hướng khi thành công
                
                
            } else {
                request.setAttribute("error", "Create failed. Try again");
                forward(request, response, "roomEdit.jsp");  // Chuyển hướng khi thất bại
            }

        } catch (Exception e) {
            request.setAttribute("error", "Invalid input. Please check your values.");
            request.getRequestDispatcher("roomEdit.jsp").forward(request, response);  // Xử lý khi có lỗi
        }
    }
       

    private void forward(HttpServletRequest request, HttpServletResponse response, String page) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    private int parseInteger(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;  // Trả về giá trị mặc định nếu không thể ép kiểu
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
