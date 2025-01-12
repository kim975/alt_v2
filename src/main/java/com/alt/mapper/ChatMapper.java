package com.alt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alt.domain.ChatMsgVO;
import com.alt.domain.ChatRoomVO;

public interface ChatMapper {

    //채팅방 id 확인
    public int selectRoomCheck(@Param("cid") String cid, @Param("vid") String vid);

    //채팅방 id 확인
    public String selectRoom(@Param("cid") String cid, @Param("vid") String vid);

    //채팅방 생성
    public void createRoom(ChatRoomVO chatRoomVO);

    //채팅방 삭제	- 채팅내용포함
    public int removeRoom(@Param("cid") String cid, @Param("vid") String vid);

    //vendor 채팅방 목록
    public List<ChatRoomVO> selectVendorChatRoom(String vid);

    //client 채팅방 목록
    public List<ChatRoomVO> selectClientChatRoom(String cid);

    /////////메세지

    //메세지 DB저장
    public int insertMsg(ChatMsgVO chatMsgVO);

    //메세지 DB불러오기
    public List<ChatMsgVO> selectMsg(String roomno);

    //메세지 읽음/안읽음처리
    public int updateMsgRead(String id);

}
