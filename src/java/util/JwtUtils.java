///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package util;
//
//import io.jsonwebtoken.*;
//import java.util.Date;
//import DTOs.UserDTO;
//import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.SignatureAlgorithm;
//
///**
// *
// * @author hieuh
// */
//public class JwtUtils {
//
//    private static final String SECRET_KEY = "sinhviendaihocfpt1234567890hieuh";
//
//    private static final long EXPIRATION_MS = 24 * 60 * 60 * 1000;
//
//    public static String generateToken(UserDTO user) {
//        return Jwts.builder()
//                .claim("id", user.getId())
//                .claim("username", user.getUsername())
//                .claim("name", user.getName())
//                .claim("role", user.getRole().name())
//                .claim("phoneNumber", user.getPhoneNumber())
//                .setIssuedAt(new java.util.Date())
//                .setExpiration(new java.util.Date(System.currentTimeMillis() + 86400000)) // 1 ngày
//                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
//                .compact();
//    }
//
////    /** Lấy username (subject) từ token, hoặc ném exception nếu token bất hợp lệ */
//    public static String getUsernameFromToken(String token) {
//        return parseToken(token).getSubject();
//    }
//
////    /** Kiểm tra token còn hợp lệ (signature đúng & chưa hết hạn) */
//    public static boolean validateToken(String token) {
//        try {
//            parseToken(token);
//            return true;
//        } catch (JwtException | IllegalArgumentException ex) {
//            // Có thể log chi tiết exception tại đây
//            return false;
//        }
//    }
//
//    //   Kiểm tra token đã hết hạn hay chưa 
//    public static boolean isTokenExpired(String token) {
//        Date expiration = parseToken(token).getExpiration();
//        return expiration.before(new Date());
//    }
//
//    public static Claims parseToken(String token) throws JwtException {
//        return Jwts.parser()
//                .setSigningKey(SECRET_KEY)
//                .parseClaimsJws(token)
//                .getBody();
//    }
//}
