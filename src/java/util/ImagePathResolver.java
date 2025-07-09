/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import jakarta.servlet.ServletContext;

/**
 *
 * @author ASUS
 */
public class ImagePathResolver {

    private final ServletContext context;

    public ImagePathResolver(ServletContext context) {
        this.context = context;
    }

    public String resolveRealPath(String subFolder) {
        return context.getRealPath("/images" + subFolder);
    }
}
