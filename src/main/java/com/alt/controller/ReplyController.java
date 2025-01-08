package com.alt.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alt.domain.Criteria;
import com.alt.domain.ReplyImgVO;
import com.alt.domain.ReplyPageDTO;
import com.alt.domain.ReplyVO;
import com.alt.service.BoardService;
import com.alt.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/replies")
@Log4j
public class ReplyController {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardService boardService;
	
	@Setter(onMethod_ = {@Autowired})
	private ReplyService replyService;
	
	//용민
	//상품 상세 페이지
	@GetMapping("/replyRegister")
	public void replyRegisterPage(@RequestParam("sno") int sno, Model model) {
		
		model.addAttribute("sale", boardService.getSaleDetail(sno));
		
	}
	
	//용민
	//상품 수정 페이지
	@GetMapping("/replyModify")
	public void replyModifyPage(@RequestParam("rno") int rno, 
								@RequestParam("sno") int sno, 
								Model model) {
		
		model.addAttribute("sale", boardService.getSaleDetail(sno));
		model.addAttribute("reply", replyService.selectRelpy(rno));
		
	}
	
	@PostMapping("/modify")
	public String replyModify(ReplyVO replyVO) {
		
		log.info("/register......");
		
		if(replyVO.getAttachList() != null) {
			
			replyVO.getAttachList().forEach(boardAttachVO -> log.info(boardAttachVO));
		}
		
		log.info("===========================");
		
		log.info("ReplyVO: " + replyVO);
		
		replyService.updateReply(replyVO);
		
		//insertCount가 1과 같으면 ?실행 그렇지 않으면 :를 실행.
		return "redirect:/board/saleDetail?sno=" + replyVO.getSno();
		
	}
	
	//용민
	//------댓글 등록
	@PostMapping(value = "/new")
	public String create(ReplyVO replyVO) {
		
		log.info("/register......");
		
		if(replyVO.getAttachList() != null) {
			
			replyVO.getAttachList().forEach(boardAttachVO -> log.info(boardAttachVO));
		}
		
		log.info("===========================");
		
		log.info("ReplyVO: " + replyVO);
		
		int insertCount = replyService.insertReplyRegister(replyVO);
		
		log.info("REPLY INSERT COUNT: " + insertCount);
		
		//insertCount가 1과 같으면 ?실행 그렇지 않으면 :를 실행.
		return "redirect:/board/saleDetail?sno=" + replyVO.getSno();
		//삼항 연산자 처리.
	}
	
	//용민
	//상품 댓글 이미지
	@GetMapping(value = "/getReplyImageList",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public ResponseEntity<List<ReplyImgVO>> getReplyImageList(String rnoStr) {
		
		String tempStr = rnoStr.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(" ", "");
		
		String[] rno = tempStr.split(",");
		
		List<Integer> rnoList= new ArrayList<Integer>();
		
		log.info("rno[0]: " + rno[0]);
		
		if("".equals(rno[0])) {
			
			return null;
		}
		for(int i=0;i<rno.length; i++){
			
			rnoList.add(Integer.parseInt(rno[i])); 
		}
		
		log.info("getAttachList: " + rno);
		
		return new ResponseEntity<>(replyService.selectReplyImage(rnoList), HttpStatus.OK);
	}
	
	@GetMapping("/replyDelete")
	public String replyDelete(int rno, int sno) {
		
		replyService.deleteReply(rno);
		
		return "redirect:/board/saleDetail?sno=" + sno;
	}
	
	@GetMapping(value = "/pages/{sno}/{page}",
			produces = {"application/xml; charset=utf-8", "application/json; charset=utf-8"})
	@ResponseBody
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("sno") int sno) {

	//한 페이지에 출력되는 글 목록 개수
	Criteria cri = new Criteria(page, 10);
	
	ReplyPageDTO replyPageDTO =  replyService.getListPage(cri, sno);
	
	List<Integer> rnoList = new ArrayList<Integer>();
	
	for(int i=0; i< replyPageDTO.getList().size(); i++) {
		
		rnoList.add(replyPageDTO.getList().get(i).getRno());
	}
	
	log.info("rnoList: " + rnoList.toString());
	
	if (!rnoList.isEmpty()) {
		replyPageDTO.setReplyImg(replyService.selectReplyImage(rnoList)); 
	}
	log.info(replyPageDTO.getList());
	
	log.info(replyPageDTO.getReplyImg());
	
	log.info("get Reply List bno: " + sno);

	log.info("cri:" + cri);

	return new ResponseEntity<>(replyPageDTO, HttpStatus.OK);
}
}
