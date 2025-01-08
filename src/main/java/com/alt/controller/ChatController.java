package com.alt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alt.domain.ChatMsgVO;
import com.alt.domain.ChatRoomVO;
import com.alt.service.ChatService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChatController {
	
	@Setter(onMethod_ = {@Autowired})
	private ChatService chatService;
	
	List<ChatRoomVO> roomList = new ArrayList<ChatRoomVO>();
	static int roomno = 0;
	
	//판매게시판 채팅
	@RequestMapping("/chat")
	public String chat_vendor(@RequestParam HashMap<Object, Object> params,
							  @RequestParam("vid") String vid,
							  Authentication auth,
							  Model model ) {
		
		UserDetails userDetails = (UserDetails) auth.getPrincipal();
		String cid = userDetails.getUsername();
		System.out.println("cid : " + cid);
		
		int roomCheck = chatService.selectRoomCheck(cid, vid);
		if(roomCheck == 0) {
			createRoom(cid,vid);
		}
		
		model.addAttribute("roomno",  chatService.selectRoom(cid, vid));
		
		return  "redirect:/moveChating";
	}
	
	//채팅방 만들기
	public List<ChatRoomVO> createRoom(String cid, String vid){
		
		ChatRoomVO chatRoomVO = new ChatRoomVO();
		chatRoomVO.setCid(cid);
		chatRoomVO.setVid(vid);
		
		chatService.createRoom(chatRoomVO);

		log.info("roomList : " + roomList);
		return roomList;
	}
	
	//채팅방 생성 이동
	@RequestMapping("/room")
	public String room() {
		return "/chat/room";
	}
	
	//방 정보가져오기
	@RequestMapping("/getRoom")
	@ResponseBody
	public List<ChatRoomVO> getRoom(Authentication auth){
		
		UserDetails userDetails = (UserDetails) auth.getPrincipal();
		
		String name = userDetails.getAuthorities().toString();
		
		log.info("userDetails.getAuthorities():" + name);
		
		if (name.equals("[ROLE_VENDOR]")) {
			String vid = userDetails.getUsername();
			log.info("vid:" + vid);
			roomList = chatService.selectVendorChatRoom(vid);
		} else {
			String cid = userDetails.getUsername();
			log.info("cid:" + cid);
			roomList = chatService.selectClientChatRoom(cid);
		}
		
		return roomList;
	}
	
	//채팅방 이동
	@RequestMapping("/moveChating")
	public String moveChating(String roomno, 
							  Model model,
							  @RequestParam(value = "ide", required=false) String ide,
							  Authentication auth, 
							  RedirectAttributes redirectAttr) {
		
		UserDetails userDetails = (UserDetails) auth.getPrincipal();
		String id = userDetails.getUsername();
		log.info("msgreadCheck id : " + id);
		
		if(chatService.updateMsgRead(id)) {
			redirectAttr.addFlashAttribute("result", "success");
		}
		
		List<ChatMsgVO> msgList = chatService.selectMsg(roomno);
		model.addAttribute("roomno", roomno);
		model.addAttribute("msgList", msgList);
		model.addAttribute("ide", ide);

		return "/chat/chat";
	}
	
}