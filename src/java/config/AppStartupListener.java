/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

/**
 *
 * @author ASUS
 */
public class AppStartupListener  implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        AppContextHolder.setContext(context); // ✅ Gán vào holder
        System.out.println("[AppStartupListener] ServletContext initialized");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        AppContextHolder.setContext(null); // ✅ Clear nếu cần
        System.out.println("[AppStartupListener] ServletContext destroyed");
    }
}
