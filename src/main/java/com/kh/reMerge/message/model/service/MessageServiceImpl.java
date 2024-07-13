package com.kh.reMerge.message.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.message.model.dao.MessageDao;
import com.kh.reMerge.message.model.vo.Message;

@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private MessageDao messageDao;

    @Override
    public int saveMessage(Message message) {
        return messageDao.saveMessage(sqlSession, message);
    }

    @Override
    public List<Message> getChatHistory(int messageRoomNo) {
        return messageDao.getChatHistory(sqlSession, messageRoomNo);
    }

    @Override
    public int getMessageRoomNo(String sendId, String receiveId) {
        Integer messageRoomNo = messageDao.getMessageRoomNo(sqlSession, sendId, receiveId);
        return (messageRoomNo != null) ? messageRoomNo : 0;
    }
    
    @Override
    public int createChatRoom(String sendId, String receiveId) {
        int messageRoomNo = messageDao.createChatRoom(sqlSession, sendId, receiveId);
        return messageRoomNo;
    }
    
    @Override
    public void markAsRead(int chatRoomNo, String receiveId) {
        messageDao.markAsRead(sqlSession, chatRoomNo, receiveId);
    }

	@Override
	public void markAsUnRead(int chatRoomNo, String userId) {
		 messageDao.markAsUnRead(sqlSession, chatRoomNo, userId);
	}

	@Override
	public ArrayList<Integer> getChatRoomNumbers(String userId) {
		return messageDao.getChatRoomNumbers(sqlSession, userId);
	}

	@Override
	public ArrayList<String> getNotificationsForUser(String userId) {
		return messageDao.getNotificationsForUser(sqlSession, userId);
	}

	@Override
	public int getUnreadMessageCount(String userId) {
		return messageDao.getUnreadMessageCount(sqlSession, userId);
	}

	@Override
	public int saveFile(Message message) {
		return messageDao.saveFile(sqlSession, message);
	}

}
