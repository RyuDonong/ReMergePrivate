package com.kh.reMerge.user.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class SearchHistory {

	private String fromUser;
	private String searchUser;
	private Date searchDate;
	
}
