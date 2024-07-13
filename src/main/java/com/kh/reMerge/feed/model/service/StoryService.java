package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;

import com.kh.reMerge.feed.model.vo.History;
import com.kh.reMerge.feed.model.vo.Story;

public interface StoryService {
	
	//타이머 작동하기 위한 스토리 추가 전 시퀀스 뽑아오기
	int selectSequnece();
	
	//스토리 추가
	int insertStory(Story story);

	//스토리 조회해오기
	ArrayList<Story> selectStory(String userId);
	
	//스토리 24시간후 자동 비활성화
	int updateStoryStatus(Story story);

	//스토리 시청 기록 넣기
	int insertHistory(History history);

	//스토리 시청 기록 조회
	ArrayList<History> selectHistory(String userId);

	//스토리 시청 기록 삭제
	int deleteHistory(History history);

}
