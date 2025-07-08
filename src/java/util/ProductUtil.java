/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import DTOs.ProductVariantDTO;
import Enums.Size;
import java.text.Normalizer;
import java.util.regex.Pattern;

/**
 *
 * @author ASUS
 */
public class ProductUtil {

    public static String generateSKU(ProductVariantDTO variant) {
        if (variant == null) {
            return null;
        }

        Long productId = variant.getProduct_id();
        String color = variant.getColor();
        Size size = variant.getSize();

        if (productId == null || color == null || size == null) {
            return null;
        }

        String normalizedColor = removeVietnameseAccents(color).toUpperCase();

        return "SP" + productId + "-" + normalizedColor + "-" + size.name();
    }

    private static String removeVietnameseAccents(String input) {
        if (input == null) {
            return null;
        }
        String normalized = Normalizer.normalize(input, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(normalized).replaceAll("").replaceAll("đ", "d").replaceAll("Đ", "D");
    }

}
