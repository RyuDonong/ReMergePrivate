package com.kh.reMerge.message.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.reMerge.message.model.vo.Message;

public interface MessageService {
    int saveMessage(Message message);
    
    List<Message> getChatHistory(int messageRoomNo);
    
    int getMessageRoomNo(String sendId, String receiveId);
    
    int createChatRoom(String sendId, String receiveId);
    
    void markAsRead(int messageRoomNo, String receiveId);
    
	void markAsUnRead(int chatRoomNo, String userId);
	
	ArrayList<Integer> getChatRoomNumbers(String userId);

	ArrayList<String> getNotificationsForUser(String userId);

	int getUnreadMessageCount(String userId);

	int saveFile(Message message);
}
