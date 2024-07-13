package com.kh.reMerge.user.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.SearchHistory;
import com.kh.reMerge.user.model.vo.User;

@Repository
public class UserDao {

	public User loginUser(SqlSessionTemplate sqlSession, User u) {
		User loginUser = sqlSession.selectOne("userMapper.loginUser",u);
		
		return loginUser;
	}

	public int insertUser(SqlSessionTemplate sqlSession, User u) {

		return sqlSession.insert("userMapper.insertUser",u);
	}

	public int checkId(SqlSessionTemplate sqlSession, String checkId) {
		// TODO Auto-generated method stub
		
		return sqlSession.selectOne("userMapper.checkId",checkId);
	}
	

	// 메시지용 - 중구
	public ArrayList<User> getAllUsers(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("userMapper.getAllUsers");
	}

	//유저 검색
	public ArrayList<User> searchUser(SqlSessionTemplate sqlSession, String searchStr) {

		return (ArrayList)sqlSession.selectList("userMapper.searchUser",searchStr);
	}
	
	//내가 아닌 다른 유저 프로필 보기 위한 조회
	public User selectUser(SqlSessionTemplate sqlSession,String userId) {
		
		return sqlSession.selectOne("userMapper.selectUser",userId);
	}

	//팔로우 신청
	public int insertFollow(SqlSessionTemplate sqlSession, FollowList followList) {

		return sqlSession.insert("userMapper.insertFollow", followList);
	}

	//팔로우 되어있는지 확인하기 위한 조회
	public int selectFollow(SqlSessionTemplate sqlSession, FollowList followList) {

		return sqlSession.selectOne("userMapper.selectFollow",followList);
	}

	//언팔로우
	public int deleteFollow(SqlSessionTemplate sqlSession, FollowList followList) {

		return sqlSession.delete("userMapper.deleteFollow", followList);
	}


	public int emailCheck(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("userMapper.emailCheck",email);
	}

	public String findId(SqlSessionTemplate sqlSession, String forFindEmail) {
		return sqlSession.selectOne("userMapper.findId",forFindEmail);
	}

	public int updateChangePwd(SqlSessionTemplate sqlSession, User u) {
		//System.out.println("유저 정보 : "+u);
		return sqlSession.update("userMapper.updateChangePwd",u);
	}

	public int accEmail(SqlSessionTemplate sqlSession, User u) {
		return sqlSession.selectOne("userMapper.accEmail",u);
	}

	//검색기록 넣기
	public int insertSearchHistory(SqlSessionTemplate sqlSession, SearchHistory searchHistory) {

		return sqlSession.insert("userMapper.insertSearchHistory", searchHistory);
	}

	//검색 기록 조회
	public ArrayList<User> selectSearchHistory(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("userMapper.selectSearchHistory", userId);
	}

	//검색 기록 삭제
	public int deleteSearchHistory(SqlSessionTemplate sqlSession, SearchHistory searchHistory) {

		return sqlSession.delete("userMapper.deleteSearchHistory", searchHistory);
	}
}
