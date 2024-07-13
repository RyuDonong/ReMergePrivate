package com.kh.reMerge.feed.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.FeedImg;
import com.kh.reMerge.feed.model.vo.FeedKeep;
import com.kh.reMerge.feed.model.vo.FeedLike;
import com.kh.reMerge.feed.model.vo.Reply;
import com.kh.reMerge.feed.model.vo.ReplyLike;
import com.kh.reMerge.feed.model.vo.Tag;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Repository
public class FeedDao {

	public int listCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("feedMapper.listCount");
	}
	
	//게시글 작성
	public int insertFeed(SqlSessionTemplate sqlSession,Feed f) {
		
		return sqlSession.insert("feedMapper.insertFeed",f);
	}
	
	//게시글 목록
	public ArrayList<Feed> selectList(SqlSessionTemplate sqlSession, PageInfo pi, String userId) {
		
		 int offset = (pi.getCurrentPage() - 1) * pi.getFeedLimit();
		 RowBounds rowBounds = new RowBounds(offset, pi.getFeedLimit());
		 Map<String, Object> paramMap = new HashMap<>();
		 
		 paramMap.put("userId", userId);
		
		return (ArrayList)sqlSession.selectList("feedMapper.selectList", paramMap, rowBounds);
	}
	
	//댓글 목록
	public ArrayList<Reply> replyList(SqlSessionTemplate sqlSession, int feedNo) {
		
		return (ArrayList)sqlSession.selectList("feedMapper.replyList",feedNo);
	}
	
	//댓글 작성
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		
		return sqlSession.insert("feedMapper.insertReply",r);
	}

	public Feed selectFeed(SqlSessionTemplate sqlSession, int feedNo) {
		
		Feed feed = sqlSession.selectOne("feedMapper.selectFeed", feedNo);
		User userProfile = sqlSession.selectOne("feedMapper.getUserProfile", feed.getFeedWriter());
		feed.setUserProfile(userProfile);
		
		return feed;
	}

	public int insertLike(SqlSessionTemplate sqlSession, FeedLike fl) {
		
		return sqlSession.insert("feedMapper.insertLike", fl);
	}

	public int deleteLike(SqlSessionTemplate sqlSession, FeedLike fl) {
		
		return sqlSession.delete("feedMapper.deleteLike",fl);
	}
	
	//좋아요 증가
	public int addCount(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.update("feedMapper.addCount",feedNo);
	}
	
	//좋아요 감소
	public int removeCount(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.update("feedMapper.removeCount",feedNo);
	}
	
	//좋아요 여부
	public int likeCheck(SqlSessionTemplate sqlSession, int feedNo,String userId) {
		Map<String, Object> params = new HashMap<>();
        params.put("feedNo", feedNo);
        params.put("userId", userId);
		
		return sqlSession.selectOne("feedMapper.likeCheck",params);
	}
	
	//좋아요 수 조회
	public int likeCount(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.selectOne("feedMapper.likeCount",feedNo);
	}
	
	//태그 검색
	public ArrayList<Tag> searchTag(SqlSessionTemplate sqlSession, Tag tag) {

		return (ArrayList)sqlSession.selectList("feedMapper.searchTag",tag);
	}

	//태그된 게시글들 조회해오기
	public ArrayList<Feed> selectTag(SqlSessionTemplate sqlSession, Tag tag) {

		return (ArrayList)sqlSession.selectList("feedMapper.selectTag", tag);
	}

	public int deleteFeed(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.update("feedMapper.deleteFeed",feedNo);
	}
	
	//태그 넣기
	public int insertTag(SqlSessionTemplate sqlSession, Tag tag) {
		
		return sqlSession.insert("feedMapper.insertTag",tag);
	}
	
	//마지막 번호 추출
	public int selectFeedNo(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("feedMapper.selectFeedNo");
	}
	
	//태그 리스트 
	public List<String> getTagsByFeedNo(SqlSessionTemplate sqlSession, int feedNo) {
		
		return sqlSession.selectList("feedMapper.getTagsByFeedNo",feedNo);
	}
	
	//좋아요 추가
	public int insertReplyLike(SqlSessionTemplate sqlSession, ReplyLike rl) {
		
		return sqlSession.insert("feedMapper.insertReplyLike",rl);
	}
	
	//좋아요 취소
	public int deleteReplyLike(SqlSessionTemplate sqlSession, ReplyLike rl) {
		
		return sqlSession.delete("feedMapper.deleteReplyLike",rl);
	}
	
	//좋아요 여부 확인
	public int checkReplyLike(SqlSessionTemplate sqlSession, int replyNo, String userId) {
		Map<String, Object> params = new HashMap<>();
        params.put("replyNo", replyNo);
        params.put("userId", userId);
		
		return sqlSession.selectOne("feedMapper.checkReplyLike",params);
	}

	public int countReplyLikes(SqlSessionTemplate sqlSession, int replyNo) {
		
		return sqlSession.selectOne("feedMapper.countReplyLikes", replyNo);
	}

	public ArrayList<User> selectUser(SqlSessionTemplate sqlSession, String userId) {

		return (ArrayList)sqlSession.selectList("feedMapper.selectUser",userId);
	}

	public User getUserProfile(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.selectOne("feedMapper.getUserProfile", userId);
	}

	public List<FollowList> getFollowList(SqlSessionTemplate sqlSession, String userId) {
		
		return sqlSession.selectList("feedMapper.getFollowList",userId);
	}

	public boolean isFollowing(SqlSessionTemplate sqlSession, String fromUser, String toUser) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("fromUser", fromUser);
		paramMap.put("toUser", toUser);
		int count = sqlSession.selectOne("feedMapper.isFollowing",paramMap);
		return count > 0;
	}

	public int saveFeed(SqlSessionTemplate sqlSession, FeedKeep feedKeep) {
		
		return sqlSession.insert("feedMapper.saveFeed",feedKeep);
	}

	public int unsaveFeed(SqlSessionTemplate sqlSession, FeedKeep feedKeep) {
		
		return sqlSession.delete("feedMapper.unsaveFeed",feedKeep);
	}

	public int checkFeedSave(SqlSessionTemplate sqlSession, int feedNo, String userId) {
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("feedNo", feedNo);
		paramMap.put("userId", userId);
		
		return sqlSession.selectOne("feedMapper.checkFeedSave",paramMap);
	}


	public List<User> getRecommend(SqlSessionTemplate sqlSession, String userId, int limit) {
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("userId", userId);
		paramMap.put("limit", limit);
		
		return sqlSession.selectList("feedMapper.getRecommend",paramMap);
	}

	public int followUser(SqlSessionTemplate sqlSession, FollowList followList) {
		
		return sqlSession.insert("feedMapper.followUser",followList);
	}

	public List<User> getRecommendList(SqlSessionTemplate sqlSession, String userId, int limit) {
		Map<String,Object> paramMap = new HashMap<>();
		paramMap.put("userId", userId);
		paramMap.put("limit", limit);
		
		return sqlSession.selectList("feedMapper.getRecommendList",paramMap);
	}

	public int insertFeedImg(SqlSessionTemplate sqlSession, FeedImg feedImage) {
		
		return sqlSession.insert("feedMapper.insertFeedImg",feedImage);
	}

	public ArrayList<FeedImg> selectImages(SqlSessionTemplate sqlSession, int feedNo) {
		
		return (ArrayList)sqlSession.selectList("feedMapper.selectImages",feedNo);
	}


}
