package com.kh.reMerge.user.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class FollowList {

	private String toUser;//팔로우 신청 받는 유저
	private String fromUser;//신청한 유저
	
}
