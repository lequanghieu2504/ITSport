package Service;

import DAO.UserDAO;
import DTOs.UserDTO;
import Enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.PasswordUtils;

public class UserService {

    private final UserDAO userDAO = new UserDAO();

    public void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("Vào handleLogin rồi");

        String url = "login.jsp";

        try {
            String username = request.getParameter("StrUserName");
            String password = request.getParameter("StrPassword");

            UserDTO userDTO = userDAO.getUserByUserName(username);

            if (userDTO == null) {
                request.getSession().setAttribute("message", "Tài khoản không tồn tại!");
            } else if (!PasswordUtils.verifyPassword(password, userDTO.getPassword())) {
                request.getSession().setAttribute("message", "Sai mật khẩu!");
            } else {
                request.getSession().setAttribute("user", userDTO);

                // Load dữ liệu trang chủ trước khi forward
                PageService pageService = new PageService();
                pageService.loadForHomePage(request, response);

                // Kết thúc sau khi forward trong PageService
                return;
            }

            // Nếu login fail thì forward về lại login.jsp
            request.getRequestDispatcher(url).forward(request, response);

        } catch (ServletException | IOException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void handleRegister(HttpServletRequest request, HttpServletResponse response) {
        String url = "login.jsp";

        try {
            String username = request.getParameter("StrUserName");
            String fullName = request.getParameter("StrFullName");
            String password = request.getParameter("StrPassword");

            String hashPassword = PasswordUtils.hashPassword(password);

            UserDTO newUser = new UserDTO();
            newUser.setUsername(username);
            newUser.setFullName(fullName);
            newUser.setPassword(hashPassword);
            newUser.setRole(Role.CLIENT); // default role

            boolean success = userDAO.insertUser(newUser);

            if (success) {
                request.getSession().setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            } else {
                request.getSession().setAttribute("message", "Đăng ký thất bại!");
                url = "register.jsp";
            }

            request.getRequestDispatcher(url).forward(request, response);

        } catch (ServletException | IOException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
