package com.alt.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatMsgVO {

	private long msgno;	//메세지번호
    private String roomno;	//방번호
    private String id;	//채팅접속 id
    private String msg;	//내용
    private String msgread;		//읽음'Y' 안읽음'N'
    private Timestamp msgdate;
    private MessageType type;	//채팅 타입 //ENTER(입장),CHAT(메세지),LEAVE(퇴장)
    
    public enum MessageType {
        ENTER,CHAT,LEAVE
    }
    
	public ChatMsgVO(String roomno, String id, String msg) {
		super();
		this.roomno = roomno;
		this.id = id;
		this.msg = msg;
	}


}
