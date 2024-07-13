package com.kh.reMerge.festival.model.service;

import java.util.ArrayList;

import com.kh.reMerge.festival.model.vo.Recommend;

public interface FestivalService {

	//축제 추천 하기 
	int insertRecommend(Recommend rec);

	//축제 추천 조회하기
	ArrayList<Recommend> selectRecommendList();

	//축제 추천 유저 조회하기(추천 여부에 따라 다르게 처리하기 위해)
	ArrayList<Recommend> selectRecommendUserList();

	//축제 추천 삭제
	int deleteRecommend(Recommend rec);
	
}
