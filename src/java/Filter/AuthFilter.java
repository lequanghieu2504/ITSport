package Filter;

import DTOs.UserDTO;
import Enums.Role;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/MainController"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String action = req.getParameter("action");
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        // Các action không cần đăng nhập
        if (action == null
                || action.equals("login")
                || action.equals("register")
                || action.equals("loadForHomePage")
                || action.equals("LoadViewProductDetail")) {
            chain.doFilter(request, response);
            return;
        }

        // Nếu chưa đăng nhập, chuyển đến login
        if (!isLoggedIn) {
            res.sendRedirect("login.jsp");
            return;
        }

        // Nếu cần phân quyền admin cho một số action
        if (isAdminOnlyAction(action)) {
            Object userObj = session.getAttribute("user");
            if (userObj instanceof UserDTO) {
                UserDTO user = (UserDTO) userObj;
                if (user.getRole() != Role.ADMIN) {
                    res.sendRedirect("auth.jsp");
                    return;
                }
            } else {
                res.sendRedirect("login.jsp");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    private boolean isAdminOnlyAction(String action) {
        return action.equalsIgnoreCase("insertProduct")
                || action.equalsIgnoreCase("updateProduct")
                || action.equalsIgnoreCase("deleteProduct")
                || action.equalsIgnoreCase("addCategory")
                || action.equalsIgnoreCase("deleteCategory")
                || action.equalsIgnoreCase("addBrand")
                || action.equalsIgnoreCase("loadForRevenue")
                || action.equalsIgnoreCase("updateBuyingStatus");
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
