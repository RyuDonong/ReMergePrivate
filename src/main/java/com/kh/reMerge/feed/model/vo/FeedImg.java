package com.kh.reMerge.feed.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FeedImg {
	private int imgId;
	private int feedNo;
	private String originName;
	private String changeName;
}
