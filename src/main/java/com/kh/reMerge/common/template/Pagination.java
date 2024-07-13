package com.kh.reMerge.common.template;

import com.kh.reMerge.common.model.vo.FollowListPageInfo;
import com.kh.reMerge.common.model.vo.PageInfo;

public class Pagination {
	public static PageInfo getPageInfo(int listCount,int currentPage,int feedLimit ) {
		
		int maxPage = (int)Math.ceil((double)listCount/feedLimit);
		
		//처리된 데이터 객체에 담아주기
		PageInfo pi = new PageInfo(listCount,currentPage,feedLimit,maxPage);
		
		return pi; //페이징 정보 반환
	  }
	
	//팔로우리스트 페이징 처리를 위한 메소드 
	public static FollowListPageInfo getFollowListPageInfo(int listCount, int currentPage, int pageLimit, int userLimit) {
		
		int maxPage = (int)Math.ceil((double)listCount/userLimit);
		int startPage = (currentPage - 1)/pageLimit * pageLimit +1;
		int endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		FollowListPageInfo fpi = new FollowListPageInfo(listCount, currentPage, pageLimit, userLimit, maxPage, startPage, endPage);
				
		return fpi;
	}
}
