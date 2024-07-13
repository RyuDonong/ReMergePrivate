package com.kh.reMerge.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Repository
public class MypageDao {
	
	public int updateUser(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("mypageMapper.updateUser",u);
	}

	public int updatePwd(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("mypageMapper.updatePwd",u);
	}

	public int deleteUser(SqlSessionTemplate sqlSession, String userPwd) {
		
		return sqlSession.update("mypageMapper.deleteUser",userPwd);
	}

	public int updateProfile(SqlSessionTemplate sqlSession, User u) {
		
		return sqlSession.update("mypageMapper.updateProfile",u);
	}


	

}
