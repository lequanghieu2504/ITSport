///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package DAO;
//
//import jakarta.websocket.*;
//import jakarta.websocket.server.PathParam;
//import jakarta.websocket.server.ServerEndpoint;
//import jakarta.json.Json;
//import javax.json.JsonObject;
//import java.io.StringReader;
//import java.io.IOException;
//import java.util.concurrent.ConcurrentHashMap;
//import java.util.concurrent.ConcurrentMap;
//
//@ServerEndpoint("/chat/{userId}")
//public class ChatEndpoint {
//    private static ConcurrentMap<String, Session> sessions = new ConcurrentHashMap<>();
//
//    @OnOpen
//    public void onOpen(@PathParam("userId") String userId, Session session) {
//        sessions.put(userId, session);
//    }
//
//    @OnMessage
//    public void onMessage(String msgJson, @PathParam("userId") String fromId) {
//        // parse input JSON
//        JsonObject json = Json.createReader(new StringReader(msgJson)).readObject();
//        String toId    = json.getString("to");
//        String content = json.getString("msg");
//
//        // 1) Lưu vào DB
//        ChatDAO.save(fromId, toId, content);
//
//        // 2) build output JSON
//        JsonObject out = Json.createObjectBuilder()
//            .add("from", fromId)
//            .add("to", toId)
//            .add("msg", content)
//            .build();
//        String text = out.toString();
//
//        // 3) gửi đến sender & receiver
//        sessions.forEach((uid, sess) -> {
//            if ((uid.equals(fromId) || uid.equals(toId)) && sess.isOpen()) {
//                try {
//                    sess.getBasicRemote().sendText(text);
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        });
//    }
//
//    @OnClose
//    public void onClose(@PathParam("userId") String userId) {
//        sessions.remove(userId);
//    }
//
//    @OnError
//    public void onError(Session session, Throwable thr) {
//        thr.printStackTrace();
//    }
//}