package com.kh.reMerge.festival.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.festival.model.vo.Recommend;

@Repository
public class FestivalDao {

	//추천 넣기 
	public int insertRecommend(SqlSessionTemplate sqlSession, Recommend rec) {

		return sqlSession.insert("festivalMapper.insertRecommend", rec);
	}

	//축제 추천 조회해오기
	public ArrayList<Recommend> selectRecommendList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("festivalMapper.selectRecommendList");
	}

	//축제 추천 유저 조회하기(추천 여부에 따라 다르게 처리하기 위해)
	public ArrayList<Recommend> selectRecommendUserList(SqlSessionTemplate sqlSession) {

		return (ArrayList)sqlSession.selectList("festivalMapper.selectRecommendUserList");
	}

	//축제 추천 삭제 
	public int deleteRecommend(SqlSessionTemplate sqlSession, Recommend rec) {

		return sqlSession.delete("festivalMapper.deleteRecommend", rec);
	}

}
