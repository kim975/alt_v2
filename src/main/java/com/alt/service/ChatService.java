package com.alt.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alt.domain.ChatMsgVO;
import com.alt.domain.ChatRoomVO;

import com.alt.mapper.ChatMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ChatService {

	
	@Setter(onMethod_ = {@Autowired})
	private ChatMapper chatMapper;
	
	/////////////////채팅방
	
	//지영
	//채팅방 id 확인
	public int selectRoomCheck(String cid, String vid) {
		log.info("ChatService selectRoom : " + cid + vid);
		return chatMapper.selectRoomCheck(cid, vid);
	}
	
	//지영
	//채팅방 id 확인
	public String selectRoom(String cid, String vid) {
		log.info("ChatService selectRoom : " + cid + vid);
		return chatMapper.selectRoom(cid, vid);
	}

	//지영
	//채팅방 생성
	//@Transactional
	public void createRoom(ChatRoomVO chatRoomVO) {
		log.info("ChatService createRoom : " + chatRoomVO);
		chatMapper.createRoom(chatRoomVO);
	}
	
	//vendor 채팅방 목록
	public List<ChatRoomVO> selectVendorChatRoom(String vid) {
		return chatMapper.selectVendorChatRoom(vid);
	}
	
	//client 채팅방 목록
	public List<ChatRoomVO> selectClientChatRoom(String cid) {
		return chatMapper.selectClientChatRoom(cid);
	}
	
	//지영
	//채팅방 삭제	- 채팅내용포함
	//@Transactional
	public int removeRoom(@Param("cid") String cid,@Param("vid") String vid) {
		log.info("ChatService removeRoom : " + cid + vid);
		return chatMapper.removeRoom(cid, vid);
	}

	
	///////////////채팅메세지
	
	//메세지 DB저장
	public int insertMsg(ChatMsgVO chatMsgVO) {
		return chatMapper.insertMsg(chatMsgVO);
	}
	
	//메세지 DB불러오기
	public List<ChatMsgVO> selectMsg(String roomno){
		return chatMapper.selectMsg(roomno);
	}
	
	//메세지 읽음/안읽음처리
	public boolean updateMsgRead(String id) {
		return chatMapper.updateMsgRead(id)==1;
	}
	
}
