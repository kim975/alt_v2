package com.alt.domain;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.alt.domain.ChatMsgVO.MessageType;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
//@AllArgsConstructor
public class ChatRoomVO {

	private String roomno;
	private String cid;
	private String vid;
	private Timestamp roomdate;
	private Set<WebSocketSession> sessions = new HashSet<>();
    //private long userCount; // 채팅방 인원수, 채팅방 내에서 메시지가 전달될때 인원수 갱신시 사용
    private List<ChatMsgVO> messages = new ArrayList<>();
	
	
	public ChatRoomVO(long roomno, String cid, String vid, Timestamp roomdate) {
		this.roomno = UUID.randomUUID().toString();
		this.cid = cid;
		this.vid = vid;
		this.roomdate = roomdate;
	}
	
	//지영
	//웹소켓 입퇴장
    public void handleMessage(WebSocketSession session, ChatMsgVO chatMessage,
                              ObjectMapper objectMapper) throws IOException {
        if(chatMessage.getType() ==  MessageType.ENTER){
            sessions.add(session);
            chatMessage.setMsg(chatMessage.getId() + "님이 입장하셨습니다.");
        }
        else if(chatMessage.getType() == MessageType.LEAVE){
            sessions.remove(session);
            chatMessage.setMsg(chatMessage.getId() + "님이 퇴장하셨습니다.");
        }
        else{
            chatMessage.setMsg(chatMessage.getId() + " : " + chatMessage.getMsg());
        }
        send(chatMessage,objectMapper);
    }

    //웹소켓 session
    private void send(ChatMsgVO chatMessage, ObjectMapper objectMapper) throws IOException {
        TextMessage textMessage = new TextMessage(objectMapper.
                                    writeValueAsString(chatMessage.getMsg()));
        for(WebSocketSession sess : sessions){
            sess.sendMessage(textMessage);
        }
    }

}