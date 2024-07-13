package com.kh.reMerge.user.model.service;

import org.springframework.stereotype.Service;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

public interface MyPageService {

	
	
	int updateUser(User u);

	int updatePwd(User u);

	

	int updateProfile(User u);

	int deleteUser(String userId);



}
