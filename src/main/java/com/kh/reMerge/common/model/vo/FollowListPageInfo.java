package com.kh.reMerge.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class FollowListPageInfo {

	private int listCount; // 총 팔로우 수
	private int currentPage; // 현재페이지 
	private int pageLimit; // 페이지 하단에 보여질 페이징 바에 최대 개수
	private int userLimit; // 한 페이지에 보여줄 게시글 개수 
	
	private int maxPage; // 가장 마지막 페이징바가 몇번인지 (총 페이지 개수)
	private int startPage; // 페이지 하단에 보여질 페이징바의 시작수
	private int endPage; // 페이지 하단에 보여질 페이징바의 끝수
	
}
