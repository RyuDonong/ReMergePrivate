package com.kh.reMerge.feed.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FeedLike {
	
	private int feedLike;
	private String userId;
	private int feedNo;
}
