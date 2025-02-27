/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import prj301asm.User.UserDAO;
import prj301asm.User.UserDTO;

/**
 *
 * @author TRAN PHU THINH
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
           HttpSession session = request.getSession(false);
           UserDTO user = (UserDTO) session.getAttribute("user");
           String action = request.getParameter("action");
           
           if (user.getRole().equals("admin")){
               if(action == null || action.equals("ManageUser")){
                   UserDAO dao = new UserDAO();
                   ArrayList<UserDTO> list = (ArrayList<UserDTO>) dao.getAllUser();
                   request.setAttribute("list", list);
                   RequestDispatcher rd = request.getRequestDispatcher("manageUser.jsp");
                   rd.forward(request, response);
                   
               } else if(action.equals("delete")){
               
               
                String username = request.getParameter("username");      
                   
                if(username != null && !username.isEmpty()){
                }
                UserDAO dao = new UserDAO();
                if (username != null && !username.isEmpty()) {
                    dao.delete(username);
               
                 }

               List<UserDTO> list = dao.getAllUser();
                
                request.setAttribute("list", list);
                RequestDispatcher rd = request.getRequestDispatcher("./manageUser.jsp");
                rd.forward(request, response);
                                           
            }
               
           }
               
                       
            
           
        }
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
