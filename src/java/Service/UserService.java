package Service;

import DAO.BuyingDAO;
import DAO.CartDAO;
import DAO.ClientDAO;
import DAO.UserBuyingInforDAO;
import DAO.UserDAO;
import DTOs.ClientDTO;
import DTOs.UserBuyingInfoDTO;
import DTOs.UserDTO;
import DTOs.UserOrderDTO;
import Enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.PasswordUtils;

public class UserService {

    private final UserDAO userDAO = new UserDAO();
    private final UserBuyingInforDAO userBuyingInforDAO = new UserBuyingInforDAO();
    private final BuyingDAO buyingDAO = new BuyingDAO();
     
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
                HttpSession session = request.getSession();
                session.setAttribute("user", userDTO);

                ClientDTO client = ClientDAO.getClientByUserId(userDTO.getUser_id());
                if (client != null || userDTO.getRole().equals("CLIENT")) {
                    session.setAttribute("client", client);
                }

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

    public void handleRegister(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String url = "login.jsp";

        try {
            String username = request.getParameter("StrUserName");
            if (userDAO.isUsernameExists(username)) {
                request.getSession().setAttribute("message", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác.");
                url = "register.jsp";
                request.getRequestDispatcher(url).forward(request, response);
                return;
            }

            String fullName = request.getParameter("StrFullName");
            String password = request.getParameter("StrPassword");

            String hashPassword = PasswordUtils.hashPassword(password);

            UserDTO newUser = new UserDTO();
            newUser.setUsername(username);
            newUser.setFullName(fullName);
            newUser.setPassword(hashPassword);
            newUser.setRole(Role.ADMIN); // default role

            boolean success = userDAO.insertUser(newUser);

            if (success) {
                int user_id = userDAO.getUserIdByUsername(username);
                int cart_id = CartDAO.createCart();

                ClientDTO client = new ClientDTO();
                client.setUser_id(user_id);
                client.setCart_id(cart_id);
                client.setFull_name(fullName);
                client.setPhone_number("N/A");
                client.setAddress("N/A");

                ClientDAO.insertClient(client);
                request.getSession().setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
                response.sendRedirect("login.jsp");
            } else {
                request.getSession().setAttribute("message", "Đăng ký thất bại!");
                response.sendRedirect("register.jsp");
            }

        } catch (ServletException | IOException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Đã xảy ra lỗi hệ thống!");
            response.sendRedirect("register.jsp");
        }
    }

    public void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Huỷ phiên đăng nhập hiện tại
        HttpSession session = request.getSession(false); // false: không tạo session mới nếu chưa có
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect("MainController?action=loadForHomePage");
    }

    public void handleGetProfile(HttpServletRequest request, HttpServletResponse response) {
        try {
            UserDTO userDTO = (UserDTO) request.getSession().getAttribute("user");
            long userId = userDTO.getUser_id();
            UserDTO userProfile = userDAO.getUserDTOByUserId(userId);

            List<UserBuyingInfoDTO> userBuyingInfoDTOs = userBuyingInforDAO.getUserBuyingInforByUserId(userId);
            request.setAttribute("userBuyingInfoList", userBuyingInfoDTOs);

            request.getRequestDispatcher("User/Profile.jsp").forward(request, response);

        } catch (ServletException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }


    public void handleGetUserOrder(HttpServletRequest request, HttpServletResponse response) {
        try {
            UserDTO userDTO = (UserDTO) request.getSession().getAttribute("user");
            long userId = userDTO.getUser_id();
            List<UserOrderDTO> listUserOrderDTOs = buyingDAO.getUserBuying(userId);
            
            request.setAttribute("userOrders", listUserOrderDTOs);
            request.getRequestDispatcher("User/order.jsp").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

    public void cancelOrderStatusByUserId(HttpServletRequest request, HttpServletResponse response) {
        String strBuyingId =  request.getParameter("buyingId");
        long buyingId = Long.parseLong(strBuyingId);
        UserDTO userDTO = (UserDTO) request.getSession().getAttribute("user");
        long userId = userDTO.getUser_id();
        
        buyingDAO.updateStatusByUser(userId,buyingId);
        
        try {
            request.getRequestDispatcher("MainController?action=myOrders").forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(UserService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
}
