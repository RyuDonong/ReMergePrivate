package com.kh.reMerge.festival.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Recommend {

	private String festivalName;
	private String userId;
	private int recommendCount;//추천수 가져오기 위한 처리
	
}
