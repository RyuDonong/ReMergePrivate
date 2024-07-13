package com.kh.reMerge.user.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.user.model.dao.UserDao;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.SearchHistory;
import com.kh.reMerge.user.model.vo.User;

@Service
public class UserServiceImpl implements UserService {

	
	@Autowired
	private UserDao userDao;

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public User loginUser(User u) {
		User loginUser = userDao.loginUser(sqlSession, u);
		return loginUser;
	}

	@Override
	public int insertUser(User u) {
		
		return userDao.insertUser(sqlSession, u);
	}

	@Override
	public int checkId(String checkId ) {
		//System.out.println(checkId);
		//System.out.println(userDao.checkId(sqlSession, checkId));
		
		return userDao.checkId(sqlSession, checkId);
	}
	
	// 메시지용 - 중구
	@Override
	public ArrayList<User> getAllUsers() {
		return userDao.getAllUsers(sqlSession);
	}

	//유저 검색
	@Override
	public ArrayList<User> searchUser(String searchStr) {

		return userDao.searchUser(sqlSession,searchStr);
	}

	//팔로우 신청
	@Override
	public int insertFollow(FollowList followList) {

		return userDao.insertFollow(sqlSession,followList);
	}
	
	//언팔로우
	@Override
	public int deleteFollow(FollowList followList) {

		return userDao.deleteFollow(sqlSession,followList);
	}

	@Override

	public User selectUser(String userId) {
		
		return userDao.selectUser(sqlSession, userId);
	}

	@Override
	public int selectFollow(FollowList followList) {
		
		return userDao.selectFollow(sqlSession, followList);
	}

	public int checkEmail(String email) {
		return userDao.emailCheck(sqlSession,email);
	}
	
	//아이디 찾기
	@Override
	public String findId(String idForFindEmail) {

		return userDao.findId(sqlSession,idForFindEmail);
	}
	
	//이메일 인증 완료후 비밀번호 변경
	@Override
	public int updateChangePwd(User u) {
		return userDao.updateChangePwd(sqlSession,u);
	}

	//이메일인증을 위한 아이디 및 이메일 일치하는지판별
	@Override
	public int accEmail(User u) {
		return userDao.accEmail(sqlSession, u);
	}

	//검색기록 넣기
	@Override
	public int insertSearchHistory(SearchHistory searchHistory) {

		return userDao.insertSearchHistory(sqlSession,searchHistory);
	}
	
	//검색기록 조회
	@Override
	public ArrayList<User> selectSearchHistory(String userId) {

		return userDao.selectSearchHistory(sqlSession,userId);
	}
	
	//검색 기록 삭제
	@Override
	public int deleteSearchHistory(SearchHistory searchHistory) {

		return userDao.deleteSearchHistory(sqlSession,searchHistory);
	}
}

