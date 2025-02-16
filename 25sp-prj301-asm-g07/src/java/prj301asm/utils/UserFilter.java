package prj301asm.utils;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import prj301asm.User.UserDTO;

public class UserFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Nếu không có logic khởi tạo, để trống.
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        HttpServletRequest req  = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String uri = req.getRequestURI();
        // Nếu là trang quản lý: chỉ cho phép admin truy cập.
        if (uri.contains("admin")) {
            if (session == null || session.getAttribute("user") == null) {
                res.sendRedirect("login.jsp");
                return;
            }
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (user == null || !"admin".equals(user.getRole())) {
                res.sendRedirect("login.jsp");
                return;
            }
        }
        // Nếu là trang booking hoặc payment: yêu cầu người dùng đã đăng nhập (member hoặc admin).
        else if (uri.contains("booking") || uri.contains("payment")) {
            if (session == null || session.getAttribute("user") == null) {
                res.sendRedirect("login.jsp");
                return;
            }
        }
        // Các trang khác có thể truy cập công khai.
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp tài nguyên nếu cần thiết.
    }
}
