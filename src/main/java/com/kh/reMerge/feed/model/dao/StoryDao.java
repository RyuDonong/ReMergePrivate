package com.kh.reMerge.feed.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.feed.model.vo.History;
import com.kh.reMerge.feed.model.vo.Story;

@Repository
public class StoryDao {

	//스토리 추가기능 메소드
	public int insertStory(SqlSessionTemplate sqlSession, Story s) {

		return sqlSession.insert("storyMapper.insertStory", s);
	}

	//스토리 조회 메소드
	public ArrayList<Story> selectStory(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("storyMapper.selectStory", userId);
	}

	//스토리 24시간 뒤 자동 비활성화
	public int updateStoryStatus(SqlSessionTemplate sqlSession, Story story) {

		return sqlSession.update("storyMapper.updateStoryStatus", story);
	}
	//타이머 작동을 위한 스토리 추가 전 시퀀스 뽑아오기
	public int selectSequence(SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("storyMapper.selectSequence");
	}

	//스토리 시청 기록 넣기
	public int insertHistory(SqlSessionTemplate sqlSession, History history) {

		return sqlSession.insert("storyMapper.insertHistory", history);
	}

	//스토리 시청 기록 조회
	public ArrayList<History> selectHistory(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("storyMapper.selectHistory",userId);
	}

	//스토리 시청 기록 삭제
	public int deleteHistory(SqlSessionTemplate sqlSession, History history) {

		return sqlSession.delete("storyMapper.deleteHistory", history);
	}

}
