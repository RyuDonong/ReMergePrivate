package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.SearchHistory;
import com.kh.reMerge.user.model.vo.User;

public interface UserService {

	int insertUser(User u);

	int checkId(String checkId);

	User loginUser(User u);


	// 메시지용 - 중구
	ArrayList<User> getAllUsers();
	
	//유저 검색
	ArrayList<User> searchUser(String searchStr);

	
	//팔로우 신청
	int insertFollow(FollowList followList);
	
	
	//언팔로우
	int deleteFollow(FollowList followList);
	
	//내가 아닌 유저 정보 조회해오기
	User selectUser(String userId);
	
	//팔로우 목록
	int selectFollow(FollowList followList);

	
	//이메일 중복체크
	int checkEmail(String email);
	
	//아이디 찾기
	String findId(String idForFindEmail);
	
	//이메일인증을 위한 아이디 및 이메일 일치하는지판별
	int accEmail(User u);
	
	//이메일인증을 마친 비밀번호 변경
	int updateChangePwd(User u);

	//검색 기록 넣기
	int insertSearchHistory(SearchHistory searchHistory);

	//검색 기록 조회
	ArrayList<User> selectSearchHistory(String userId);

	//검색 기록 삭제
	int deleteSearchHistory(SearchHistory searchHistory);

	
	

	
}
