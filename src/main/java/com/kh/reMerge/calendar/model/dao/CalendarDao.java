package com.kh.reMerge.calendar.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.calendar.model.vo.Schedule;
import com.kh.reMerge.common.model.vo.FollowListPageInfo;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Repository
public class CalendarDao {

	//일정 추가
	public int insertSchedule(SqlSessionTemplate sqlSession, Schedule s) {
		
		return sqlSession.insert("calendarMapper.insertSchedule", s);
	}

	//일정 조회
	public ArrayList<Schedule> selectSchedule(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("calendarMapper.selectSchedule",userId);
	}

	//일정 상세조회
	public Schedule detailSchedule(SqlSessionTemplate sqlSession, int scheduleNo) {

		return sqlSession.selectOne("calendarMapper.detailSchedule",scheduleNo);
	}

	//일정 삭제
	public int deleteSchedule(SqlSessionTemplate sqlSession, int scheduleNo) {

		return sqlSession.delete("calendarMapper.deleteSchedule", scheduleNo);
	}

	//일정 수정
	public int updateSchedule(SqlSessionTemplate sqlSession, Schedule s) {
		
		return sqlSession.update("calendarMapper.updateSchedule",s);
	}
	
	//팔로우 리스트로 이동하기 위한 팔로우 리스트 조회 
	public ArrayList<User> followList(SqlSessionTemplate sqlSession, String userId, FollowListPageInfo fpi) {
		
		int limit = fpi.getUserLimit();
		int offset = (fpi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset,limit);
		
		return (ArrayList)sqlSession.selectList("calendarMapper.followList", userId,rowBounds);
	}

	//공유 캘린더 조회
	public ArrayList<Schedule> selectShareSchedule(SqlSessionTemplate sqlSession, String[] follower) {

		ArrayList<Schedule> list = new ArrayList<>();
		for (int i = 0; i < follower.length; i++) {
			list.addAll((ArrayList)sqlSession.selectList("calendarMapper.selectShareSchedule", follower[i]));
		}
		return list;
	}

	//팔로우 리스트 페이징 처리를 위한 팔로잉 수 조회
	public int followListCount(SqlSessionTemplate sqlSession, String userId) {

		return sqlSession.selectOne("calendarMapper.followListCount", userId);
	}

	//팔로우 리스트에서 검색
	public ArrayList<User> searchFollower(SqlSessionTemplate sqlSession, FollowList followList) {

		return (ArrayList)sqlSession.selectList("calendarMapper.searchFollower",followList);
	}


}
