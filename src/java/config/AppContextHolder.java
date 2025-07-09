/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import jakarta.servlet.ServletContext;

/**
 *
 * @author ASUS
 */
public class AppContextHolder {

    private static ServletContext context;

    public static void setContext(ServletContext ctx) {
        context = ctx;
    }

    public static ServletContext getContext() {
        return context;
    }
}
