package com.kh.reMerge.calendar.model.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Schedule {

	private int scheduleNo;
	private String title;
	private String memo;
	private String startDate;
	private String endDate;
	private String location;
	private String userId;
	
}
