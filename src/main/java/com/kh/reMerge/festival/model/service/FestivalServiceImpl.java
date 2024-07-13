package com.kh.reMerge.festival.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.festival.model.dao.FestivalDao;
import com.kh.reMerge.festival.model.vo.Recommend;

@Service
public class FestivalServiceImpl implements FestivalService{

	@Autowired
	private FestivalDao festivalDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//추천 넣기 
	@Override
	public int insertRecommend(Recommend rec) {

		return festivalDao.insertRecommend(sqlSession,rec);
	}
	
	//축제 추천 조회하기
	@Override
	public ArrayList<Recommend> selectRecommendList() {

		return festivalDao.selectRecommendList(sqlSession);
	}
	
	//축제 추천 유저 조회하기(추천 여부에 따라 다르게 처리하기 위해)
	@Override
	public ArrayList<Recommend> selectRecommendUserList() {

		return festivalDao.selectRecommendUserList(sqlSession);
	}
	
	//축제 추천 삭제
	@Override
	public int deleteRecommend(Recommend rec) {

		return festivalDao.deleteRecommend(sqlSession,rec);
	}
	
}
