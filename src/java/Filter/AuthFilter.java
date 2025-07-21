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

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/MainController", "/admin/*"})
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String action = req.getParameter("action");
        String requestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        
        // Kiểm tra nếu đang truy cập admin URL
        if (path.startsWith("/admin/")) {
            if (!isLoggedIn) {
                res.sendRedirect(contextPath + "/login.jsp");
                return;
            }
            
            // Kiểm tra quyền admin
            Object userObj = session.getAttribute("user");
            if (userObj instanceof UserDTO) {
                UserDTO user = (UserDTO) userObj;
                if (user.getRole() != Role.ADMIN) {
                    res.sendRedirect(contextPath + "/auth.jsp"); // Trang báo không có quyền
                    return;
                }
            } else {
                res.sendRedirect(contextPath + "/login.jsp");
                return;
            }
            // Nếu là admin, cho phép truy cập
            chain.doFilter(request, response);
            return;
        }
        
        // Các action không cần đăng nhập (cho MainController)
        if (action == null
                || action.equals("login")
                || action.equals("register")
                || action.equals("loadForHomePage")
                || action.equals("sendMailToGetOTP")
                || action.equals("OTPToLogin")
                || action.equals("viewDetailProduct")
                ) {
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