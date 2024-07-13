package com.kh.reMerge.user.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.user.model.dao.MypageDao;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;
@Service
public class MyPageServiceImpl implements MyPageService {
	
	@Autowired
	private MypageDao mypageDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//정보 수정
	@Override
	public int updateUser(User u) {
		
		return mypageDao.updateUser(sqlSession, u);
	}
	
	//비밀번호 변경
	@Override
	public int updatePwd(User u) {
		// TODO Auto-generated method stub
		return mypageDao.updatePwd(sqlSession, u);
	}
		//사진 수정
		@Override
		public int updateProfile(User u) {
					
			return mypageDao.updateProfile(sqlSession,u);
		}
		//회원 탈퇴
		@Override
		public int deleteUser(String userPwd) {
			
			return mypageDao.deleteUser(sqlSession,userPwd);
		}

	





	
	
	


}
