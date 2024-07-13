package com.kh.reMerge.message.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.message.model.vo.Message;

@Repository
public class MessageDao {

    public int saveMessage(SqlSessionTemplate sqlSession, Message message) {
        return sqlSession.insert("messageMapper.saveMessage", message);
    }

    public List<Message> getChatHistory(SqlSessionTemplate sqlSession, int messageRoomNo) {
        return sqlSession.selectList("messageMapper.getChatHistory", messageRoomNo);
    }

    public Integer getMessageRoomNo(SqlSession sqlSession, String sendId, String receiveId) {
        Map<String, String> params = new HashMap<>();
        params.put("sendId", sendId);
        params.put("receiveId", receiveId);
        return sqlSession.selectOne("messageMapper.getMessageRoomNo", params);
    }
    
    public int createChatRoom(SqlSession sqlSession, String sendId, String receiveId) {
        Map<String, String> params = new HashMap<>();
        params.put("sendId", sendId);
        params.put("receiveId", receiveId);
        return sqlSession.insert("messageMapper.createChatRoom", params);
    }

    public void markAsRead(SqlSessionTemplate sqlSession, int messageRoomNo, String receiveId) {
        Map<String, Object> params = new HashMap<>();
        params.put("messageRoomNo", messageRoomNo);
        params.put("receiveId", receiveId);
        sqlSession.update("messageMapper.markAsRead", params);
    }

	public void markAsUnRead(SqlSessionTemplate sqlSession, int chatRoomNo, String userId) {
		Map<String, Object> params = new HashMap<>();
        params.put("messageRoomNo", chatRoomNo);
        params.put("receiveId", userId);
        sqlSession.update("messageMapper.markAsUnread", params);
	}

	public ArrayList<Integer> getChatRoomNumbers(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("messageMapper.getChatRoomNumbers", userId);
	}

	public String getNotificationForUser(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("messageMapper.getNotificationForUser", userId);
	}

	public ArrayList<String> getNotificationsForUser(SqlSessionTemplate sqlSession, String userId) {
		return (ArrayList)sqlSession.selectList("messageMapper.getNotificationsForUser", userId);
	}

	public int getUnreadMessageCount(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.selectOne("messageMapper.getUnreadMessageCount", userId);
	}

	public int saveFile(SqlSessionTemplate sqlSession, Message message) {
		 return sqlSession.insert("messageMapper.saveFile", message);
	}
}
