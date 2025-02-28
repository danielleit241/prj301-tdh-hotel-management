package prj301asm.utils;

import java.io.IOException;
import javax.servlet.*;
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
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");

        if (uri.contains("/admin/")) {
            if ("member".equals(user.getRole())) {
                res.sendRedirect(contextPath + "/home.jsp");
                return;
            } else if (user == null || !"admin".equals(user.getRole())) {
                res.sendRedirect(contextPath + "/login.jsp");
                return;
            }
        } else if (uri.startsWith(contextPath + "/booking/")
                || uri.startsWith(contextPath + "/payment/")) {
            if (user == null) {
                res.sendRedirect(contextPath + "/login.jsp");
                return;
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp tài nguyên nếu cần thiết.
    }
}
