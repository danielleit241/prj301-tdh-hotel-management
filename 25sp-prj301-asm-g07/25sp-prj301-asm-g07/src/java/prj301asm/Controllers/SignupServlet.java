package prj301asm.Controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import prj301asm.User.UserDAO;
import prj301asm.User.UserDTO;

public class SignupServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the form
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("passwordConfirm");

        if (!username.matches("^[a-zA-Z0-9]+$")) {
            request.setAttribute("errorUsername", "Username không được chứa dấu cách hoặc ký tự đặc biệt.");
            RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
            rd.forward(request, response);
            return;
        }

        // Check for null values and if passwords match
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Signup servlet handling user registration";
    }
}
