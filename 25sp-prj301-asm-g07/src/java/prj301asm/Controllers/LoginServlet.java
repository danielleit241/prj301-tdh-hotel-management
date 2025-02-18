/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import prj301asm.User.UserDAO;
import prj301asm.User.UserDTO;

/**
 *
 * @author hoade
 */
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String action = request.getParameter("action");

        if (action == null || action.equals("login")) {
            UserDAO dao = new UserDAO();
            UserDTO user = dao.login(username, password);
            HttpSession session = request.getSession(true);
            if (user != null) {
                session.setAttribute("user", user);
                if(user.getRole().equals("member")){
                    response.sendRedirect("./roomList?page=1");
                }else if(user.getRole().equals("admin")){
                    response.sendRedirect("admin/dashboard.jsp");
                }   
            } else {
                request.setAttribute("error", "Username or Password is not correct!");
                RequestDispatcher rd = request.getRequestDispatcher("/login");
                rd.forward(request, response);
                return;
            }
        } else if (action.equals("logout")) {
            HttpSession session = request.getSession(false);
            session.invalidate();
            request.setAttribute("error", "Logout Sucessfully");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
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
