package com.kh.reMerge.feed.model.service;

import java.util.ArrayList;
import java.util.List;

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


public interface FeedService {
	
	//게시글 총 개수
	int listcount();
	
	//게시글 작성
	int insertFeed(Feed f);
	
	//게시글 목록 
	ArrayList<Feed> selectList(PageInfo pi,String userId);
	
	//댓글 목록조회
	ArrayList<Reply> replyList(int feedNo);

	//댓글 작성
	int insertReply(Reply r);
	
	//게시글 디테일
	Feed selectFeed(int feedNo);
	
	//게시글 좋아요
	int insertLike(FeedLike fl);
	
	//좋아요 취소
	int deleteLike(FeedLike fl);
	
	//좋아요 수 증가
	int addCount(int feedNo);
	
	//좋아요 감소
	int removeCount(int feedNo);
	
	//좋아요 여부
	int likeCheck(int feedNo,String userId);
	
	//좋아요 수 조회
	int likeCount(int feedNo);
	
	//태그 검색
	ArrayList<Tag> searchTag(Tag tag);

	//태그된 게시글 조회해오기
	ArrayList<Feed> selectTag(Tag tag);
	
	//게시글 삭제하기
	int deleteFeed(int feedNo);
	
	//태그 넣기
	int insertTag(Tag tag);
	
	//번호 하나 추출하기
	int selectFeedNo();
	
	//태그 리스트
	List<String> getTagsByFeedNo(int feedNo);
	
	//댓글 좋아요
	int insertReplyLike(ReplyLike rl);
	
	//댓글 좋아요 취소
	int deleteReplyLike(ReplyLike rl);

	//좋아요 여부
	int checkReplyLike(int replyNo, String userId);
	
	//좋아요 수 조회
	int countReplyLikes(int replyNo);
	
	//User 프로필 가져오기
	User getUserProfile(String userId);
	
	//팔로우 리스트 가져오기
	List<FollowList> getFollowList(String userId);
	
	//팔로우 반별
	boolean isFollowing(String fromUser, String toUser);
	
	//게시글 저장
	int saveFeed(FeedKeep feedKeep);
	
	//게시글 저장 취소
	int unsaveFeed(FeedKeep feedKeep);
	
	//게시글 상태 확인
	int checkFeedSave(int feedNo, String userId);
	
	//회원 추천
	List<User> getRecommend(String userId, int limit);
	
	//팔로우 하기
	int followUser(FollowList followList);
	
	//회원 추천 리스트
	List<User> getRecommendList(String userId, int limit);
	
	//사진 추가
	int insertFeedImg(FeedImg feedImage);
	
	
	ArrayList<FeedImg> selectImages(int feedNo);
	
	
	
}
