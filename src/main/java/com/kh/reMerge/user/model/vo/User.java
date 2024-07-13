package com.kh.reMerge.user.model.vo;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class User {
	
	private String userId;
	private String userPwd;
	private String email;
	private Date joinDate;
	private String profilePath;
	private String status;
	private String shopBrandChek;
	private String userMemo;
	private String profileOriginName;
	private String profileChangeName;
}
