package com.kh.reMerge.message.server;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.kh.reMerge.message.model.service.MessageService;
import com.kh.reMerge.user.model.vo.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class WebSocketHandler extends TextWebSocketHandler {
    private final Set<WebSocketSession> users = Collections.synchronizedSet(new HashSet<>());
    private final Map<String, WebSocketSession> userSessions = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    @Autowired
    private MessageService messageService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        users.add(session);
        User loginUser = (User) session.getAttributes().get("loginUser");
        log.info("접속! 접속자 수 : {}", users.size());

        // 연결된 세션에 대해 추가 처리
        handleNewSession(session);
    }

    public void sendMessageToSession(WebSocketSession session, String message) throws IOException {
        if (session.isOpen()) {
            session.sendMessage(new TextMessage(message));
        }
        handleNewSession(session);
    }

    private void handleNewSession(WebSocketSession session) {
        User loginUser = (User) session.getAttributes().get("loginUser");
        String userId = loginUser.getUserId();

        if (!isUserInChatRoom(userId)) {
            try {
                // 안 읽은 메시지 개수 가져오기
                int unreadMessageCount = messageService.getUnreadMessageCount(userId);
                System.out.println("안일긍ㄴ메시지:"+unreadMessageCount);
                // 안 읽은 메시지 개수 전송
                Map<String, Object> countMessage = new HashMap<>();
                countMessage.put("type", "unreadMessageCount");
                countMessage.put("count", unreadMessageCount);

                // JSON 문자열로 변환하여 세션에 전송
                String jsonCountMessage = objectMapper.writeValueAsString(countMessage);
                session.sendMessage(new TextMessage(jsonCountMessage));

                // 나머지 처리: 알림 메시지 전송
                ArrayList<String> notifications = messageService.getNotificationsForUser(userId);
                if (notifications != null && !notifications.isEmpty()) {
                    for (String notification : notifications) {
                        // 각 알림을 포함한 JSON 객체 생성
                        Map<String, Object> message = new HashMap<>();
                        message.put("type", "notification");
                        message.put("fromUserId", userId);
                        message.put("content", notification);

                        // JSON 문자열로 변환하여 세션에 전송
                        String jsonMessage = objectMapper.writeValueAsString(message);
                        session.sendMessage(new TextMessage(jsonMessage));
                    }
                }
            } catch (IOException e) {
                log.error("알림을 보내는 중 오류 발생: {}", e.getMessage());
            }
        }
        userSessions.put(userId, session);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        if (session != null) {
            User loginUser = (User) session.getAttributes().get("loginUser");
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        users.remove(session);
        log.info("접속종료! 접속자 수 : {}", users.size());
    }
    private boolean isUserInChatRoom(String userId) {
        return false;
    }
}
