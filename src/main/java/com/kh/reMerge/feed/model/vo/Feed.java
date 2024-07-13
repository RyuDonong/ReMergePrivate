package com.kh.reMerge.feed.model.vo;

import java.sql.Date;
import java.util.List;

import com.kh.reMerge.user.model.vo.FollowList;
import com.kh.reMerge.user.model.vo.User;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Feed {
	private int feedNo;
	private String feedContent;
	private String feedWriter;
	private Date createDate;
	private String status;
	private int likeCount;
	private String feedLocation;
	private String changeName;
	
	private List<String> tags;
	private User userProfile;
	private List<FollowList> followList;
	private List<User> userList;
	private List<FeedImg> feedImg;
}
