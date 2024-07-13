package com.kh.reMerge.calendar.model.service;

import java.util.ArrayList;

import com.kh.reMerge.calendar.model.vo.Schedule;
import com.kh.reMerge.common.model.vo.FollowListPageInfo;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

public interface CalendarService {

	//일정 추가
	int insertSchedule(Schedule s);
	
	//내 일정 조회
	ArrayList<Schedule> selectSchedule(String userId);
	
	//일정 상세 조회
	Schedule detailSchedule(int scheduleNo);
	
	//일정 삭제
	int deleteSchedule(int scheduleNo);
	
	//일정 수정
	int updateSchedule(Schedule s);

	//팔로우 리스트로 이동하기 위한 팔로우 리스트 조회 
	ArrayList<User> followList(String userId, FollowListPageInfo fpi);
	
	//공유 캘린더 조회
	ArrayList<Schedule> selectShareSchedule(String[] follower);

	//팔로우 리스트 페이징 처리를 위한 팔로잉 수 조회
	int followListCount(String userId);

	//팔로우 리스트에서 검색
	ArrayList<User> searchFollower(FollowList followList);

}
