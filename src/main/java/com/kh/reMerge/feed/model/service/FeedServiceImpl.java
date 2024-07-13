package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.reMerge.common.model.vo.PageInfo;
import com.kh.reMerge.feed.model.dao.FeedDao;
import com.kh.reMerge.feed.model.vo.Feed;
import com.kh.reMerge.feed.model.vo.FeedImg;
import com.kh.reMerge.feed.model.vo.FeedKeep;
import com.kh.reMerge.feed.model.vo.FeedLike;
import com.kh.reMerge.feed.model.vo.Reply;
import com.kh.reMerge.feed.model.vo.ReplyLike;
import com.kh.reMerge.feed.model.vo.Tag;
import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

@Service
public class FeedServiceImpl implements FeedService {
	
	@Autowired
	private FeedDao feedDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int listcount() {
		return feedDao.listCount(sqlSession);
	}

	@Override
	public int insertFeed(Feed f) {
		return feedDao.insertFeed(sqlSession,f);
	}

	@Override
	public ArrayList<Feed> selectList(PageInfo pi,String userId) {
		
		return feedDao.selectList(sqlSession,pi,userId);
	}

	@Override
	public ArrayList<Reply> replyList(int feedNo) {
	
		return feedDao.replyList(sqlSession,feedNo);
	}

	@Override
	public int insertReply(Reply r) {
		
		return feedDao.insertReply(sqlSession,r);
	}

	@Override
	public Feed selectFeed(int feedNo) {
		
		return feedDao.selectFeed(sqlSession,feedNo);
	}

	@Override
	public int insertLike(FeedLike fl) {
		
		return feedDao.insertLike(sqlSession,fl);
		
	}

	@Override
	public int deleteLike(FeedLike fl) {
		
		return feedDao.deleteLike(sqlSession,fl);
	}

	@Override
	public int addCount(int feedNo) {
		
		return feedDao.addCount(sqlSession,feedNo);
	}

	@Override
	public int removeCount(int feedNo) {
		
		return feedDao.removeCount(sqlSession,feedNo);
	}

	@Override
	public int likeCheck(int feedNo,String userId) {
		
		return feedDao.likeCheck(sqlSession,feedNo,userId);
	}

	@Override
	public int likeCount(int feedNo) {
		return feedDao.likeCount(sqlSession,feedNo);
	}
	
	//태그 검색
	@Override
	public ArrayList<Tag> searchTag(Tag tag) {

		return feedDao.searchTag(sqlSession,tag);
	}
	
	//태그된 게시글들 조회해오기
	@Override
	public ArrayList<Feed> selectTag(Tag tag) {

		return feedDao.selectTag(sqlSession,tag);
	}

	@Override
	public int deleteFeed(int feedNo) {
		
		return feedDao.deleteFeed(sqlSession,feedNo);
	}
	
	//태그 넣기
	@Override
	public int insertTag(Tag tag) {
		
		return feedDao.insertTag(sqlSession,tag);
	}

	@Override
	public int selectFeedNo() {
		
		return feedDao.selectFeedNo(sqlSession);
	}

	@Override
	public List<String> getTagsByFeedNo(int feedNo) {
		
		return feedDao.getTagsByFeedNo(sqlSession,feedNo);
	}
	
	//댓글 좋아요
	@Override
	public int insertReplyLike(ReplyLike rl) {
		
		return feedDao.insertReplyLike(sqlSession,rl);
		
	}
	
	//댓글 좋아요 취소
	@Override
	public int deleteReplyLike(ReplyLike rl) {
		
		return feedDao.deleteReplyLike(sqlSession,rl);
		
	}
	
	//댓글 좋아요 여부
	@Override
	public int checkReplyLike(int replyNo, String userId) {
		
		return feedDao.checkReplyLike(sqlSession,replyNo,userId);
	}
	
	//댓글 좋아요 수
	@Override
	public int countReplyLikes(int replyNo) {
		
		return feedDao.countReplyLikes(sqlSession,replyNo);
	}
	
	//프로필 사진 가져오기
	@Override
	public User getUserProfile(String userId) {
		
		return feedDao.getUserProfile(sqlSession,userId);
	}
	
	//팔로우 리스트 가져오기
	@Override
	public List<FollowList> getFollowList(String userId) {

		return feedDao.getFollowList(sqlSession,userId);
	}

	@Override
	public boolean isFollowing(String fromUser, String toUser) {
		
		return feedDao.isFollowing(sqlSession,fromUser,toUser);
	}

	@Override
	public int saveFeed(FeedKeep feedKeep) {
		
		return feedDao.saveFeed(sqlSession,feedKeep);
	}

	@Override
	public int unsaveFeed(FeedKeep feedKeep) {
		
		return feedDao.unsaveFeed(sqlSession,feedKeep);
	}

	@Override
	public int checkFeedSave(int feedNo, String userId) {
		
		return feedDao.checkFeedSave(sqlSession,feedNo,userId);
	}

	@Override
	public List<User> getRecommend(String userId, int limit) {
		
		return feedDao.getRecommend(sqlSession,userId,limit);
	}

	@Override
	public int followUser(FollowList followList) {
	
		return feedDao.followUser(sqlSession,followList);
	}

	@Override
	public List<User> getRecommendList(String userId, int limit) {
		
		return feedDao.getRecommendList(sqlSession,userId,limit);
	}

	@Override
	public int insertFeedImg(FeedImg feedImage) {
		
		return feedDao.insertFeedImg(sqlSession,feedImage);
	}

	@Override
	public ArrayList<FeedImg> selectImages(int feedNo) {
		
		return feedDao.selectImages(sqlSession,feedNo);
	}

	

	



}
