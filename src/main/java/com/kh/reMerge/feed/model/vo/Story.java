package com.kh.reMerge.feed.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Story {

	private int storyNo;
	private String userId;
	private String storyContent;
	private Date createDate;
	private String originName;
	private String changeName;
	
}
