package com.kh.reMerge.message.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MessageRoom {
	private int messageRoomNo;		//	MESSAGEROOM_NO NUMBER PRIMARY KEY,
	private int messageNo;		//    MESSAGE_NO NUMBER,
	private String sendId;		//    SEND_ID VARCHAR2(30),
	private String receiveId;		//    RECEIVE_ID VARCHAR2(30)
}
