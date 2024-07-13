package com.kh.reMerge.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PageInfo {
	
	private int listCount; //총 게시글 개수
	private int currentPage; //현재 페이지
	private int feedLimit; //한 페이지에 보여줄 게시글 개수
	
	private int maxPage; //가장 마지막 페이징바가 몇번인지 (총 페이지 개수)
}
