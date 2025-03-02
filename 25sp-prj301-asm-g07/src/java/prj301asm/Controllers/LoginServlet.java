/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prj301asm.Controllers;

import java.io.IOException;
import java.io.PrintWriter;
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
 * @author hoade
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.equals("login")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            UserDAO dao = new UserDAO();
            UserDTO user = dao.login(username, password);
            HttpSession session = request.getSession(true);
            if (user != null) {
                session.setAttribute("user", user);
                if (user.getRole().equals("member")) {
                    response.sendRedirect("home.jsp");
                } else if (user.getRole().equals("admin")) {
                    response.sendRedirect("admin/dashboard.jsp");
                }
            } else {
                forwardToLoginJSP(request, response, "Username or Password is not correct!");
            }
        } else if (action.equals("logout")) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            forwardToLoginJSP(request, response, "Logout Sucessfully");
        } else if (action.equals("signup")) {
            request.setAttribute("nextAction", "createUser");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else if (action.equals("createUser")) {
            String name = request.getParameter("name");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String passwordConfirm = request.getParameter("passwordConfirm");

            if (!username.matches("^[a-zA-Z0-9]+$")) {
                request.setAttribute("errorUsername", "Username cannot contain spaces or special characters.");
                RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                rd.forward(request, response);
                return;
            }

            if (password == null || passwordConfirm == null || !password.equals(passwordConfirm)) {
                request.setAttribute("errorPassword", "Passwords do not match");
                RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                rd.forward(request, response);
                return;
            }

            UserDAO dao = new UserDAO();
            UserDTO checkUser = dao.checkUsername(username);
            if (checkUser != null) {
                request.setAttribute("errorUsername", "Username already exists");
                RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                rd.forward(request, response);
                return;
            }

            boolean createAccount = dao.createAccount(username, password, name);
            if (createAccount) {
                request.setAttribute("success", "Account created successfully");
            } else {
                request.setAttribute("fail", "Account creation failed");
            }

            RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
            rd.forward(request, response);
        }
    }

    private void forwardToLoginJSP(HttpServletRequest request, HttpServletResponse response,
            String errorMessage) throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("login.jsp").forward(request, response);
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
