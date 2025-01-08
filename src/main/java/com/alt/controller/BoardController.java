package com.alt.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alt.domain.BasketVO;
import com.alt.domain.Criteria;
import com.alt.domain.OrdProductVO;
import com.alt.domain.OrdVO;
import com.alt.domain.PageDTO;
import com.alt.domain.ReplyVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.SaleImgVO;
import com.alt.domain.SaleThumbImgVO;
import com.alt.domain.ZimVO;
import com.alt.service.BoardService;
import com.alt.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping(value = "/board")
@Log4j
public class BoardController {

	@Setter(onMethod_ = {@Autowired})
	private BoardService boardService;
	
	@Setter(onMethod_ = {@Autowired})
	private ReplyService replyService;
	
	//용민
	//상품 목록 페이지
	@GetMapping("/saleBoard")
	public void saleBoardList(Criteria cri, Model model) {
	
		log.info("list 페이징: " + cri);
		
		cri.setAmount(24);
		
		List<SaleBoardVO> saleBoardList = boardService.getList(cri);
		int total = boardService.getTotalCount();
		
		List<Integer> snoList = new ArrayList<Integer>(); 
		
		for(int i=0; saleBoardList.size() > i ; i++) {
			
			log.info("saleBoardList.get(i).getSno(): " + saleBoardList.get(i).getSno());
			snoList.add(saleBoardList.get(i).getSno());
		}
		
		if(!snoList.isEmpty()) {
			model.addAttribute("star", boardService.selectSaleBoardStar(snoList));
		}
		
		model.addAttribute("thumbImgSnoList", snoList);
		model.addAttribute("saleBoardList", saleBoardList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//용민
	//상품 썸네일 이미지
	@GetMapping(value = "/getThumbList",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public ResponseEntity<List<SaleThumbImgVO>> getThumbImgList(String snoStr) {
		
		String tempStr = snoStr.replaceAll("\\[", "").replaceAll("\\]", "").replaceAll(" ", "");
		
		if(tempStr == null || tempStr.length() <= 0 || "".equals(tempStr)) {
			
			return null;
		}
		
		String[] sno = tempStr.split(",");
		
		List<Integer> snoList= new ArrayList<Integer>();
		
		for(int i=0;i<sno.length; i++){ 
			snoList.add(Integer.parseInt(sno[i])); 
		}
		
		log.info("getAttachList: " + sno);
		
		return new ResponseEntity<>(boardService.selectSaleBoardThumbImage(snoList), HttpStatus.OK);
	}
	
	//용민
	//상품 메인 이미지
	@GetMapping(value = "/getImageList",
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public ResponseEntity<List<SaleImgVO>> getImgList(@RequestParam("sno") int sno) {

		return new ResponseEntity<>(boardService.selectSaleBoardImamge(sno), HttpStatus.OK);
	}
	
	//용민
	//상품 상세 페이지
	@GetMapping("/saleDetail")
	public void saleDetail(@RequestParam("sno") int sno, Model model) {
		
		List<ReplyVO> replyList = replyService.selectSaleBoardRelpy(sno);
		List<Integer> rnoList = new ArrayList<Integer>(); 
		
		for(int i=0; replyList.size() > i ; i++) {
			
			log.info("saleBoardList.get(i).getSno(): " + replyList.get(i).getRno());
			rnoList.add(replyList.get(i).getRno());
		}
		
		model.addAttribute("countRstar", boardService.selectCountStar(sno));
		model.addAttribute("rnoList", rnoList);
		model.addAttribute("sale", boardService.getSaleDetail(sno));
		
	}
	
	//용민
	//장바구니 등록
	@PostMapping(value = "/basket", 
				 //웹브라우저로부터 받아서 메소드가 사용하는 값의 MIME유형을 지정.
				 consumes = "application/json; charset=utf-8", 
				 //이 메소드가 웹브라우저로 전달할 데이터의 MIME-유형을 지정.
				 produces = "text/plain; charset=utf-8")
				 //produces = {MediaType.TEXT_PLAIN_VALUE}) //5.2부터 없어짐.	 
	//ResponseEntity는 반환을 하는데 있어서, 결과도 반환하고 상태정보(200, 202, 400 등)도 반환이 가능하다.
//	public void basket(@RequestBody BasketVO basketVO) {
	@PreAuthorize("hasRole('ROLE_CLIENT')")
	public ResponseEntity<String> basket(@RequestBody BasketVO basketVO) {
		
		log.info("basketVO: " + basketVO);
		
		int insertCount = boardService.insertBasket(basketVO);
		
		//log.info("REPLY INSERT COUNT: " + insertCount);
		
		//insertCount가 1과 같으면 ?실행 그렇지 않으면 :를 실행.
		return insertCount == 1 
				? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		//삼항 연산자 처리.
	}
	
	//용민
	//장바구니에서 물품 삭제
	@DeleteMapping(value = "/basket/{bcode}")
	@ResponseBody
	public ResponseEntity<String> deleteBasket(@PathVariable("bcode") String bcode, Model model) {
		
		log.info("bcode: " + bcode);
		
		//model.addAttribute("totalPrice", boardService.selectBasketTotalPrice(cid));
		
		return boardService.deleteBasket(bcode) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//용민
	//장바구니 목록 페이지 
	@GetMapping(value = "/basketList")
	@PreAuthorize("hasRole('ROLE_CLIENT')")
	public void basketList(@RequestParam("cid") String cid, Model model) {
		
		if(cid != null && cid.length() != 0 && cid != "") {
			
			List<HashMap<String, String>> basketList = boardService.selectBasketListSaleBoard(cid);
			
			List<Integer> snoList = new ArrayList<Integer>(); 
			
			for(int i=0; basketList.size() > i ; i++) {
				
				log.info("saleBoardList.get(i).getSno(): " + basketList.get(i));
				log.info("saleBoardList.get(i).getSno(): " + String.valueOf(basketList.get(i).get("SNO")));
				snoList.add(Integer.parseInt(String.valueOf(basketList.get(i).get("SNO"))));
			}
			
			model.addAttribute("thumbImgSnoList", snoList);
			model.addAttribute("totalPrice", boardService.selectBasketTotalPrice(cid));
			model.addAttribute("basketList", basketList);
		}
		
		System.out.println(boardService.selectBasketList(cid).toString());
		
	}
	
	//용민
	//장바구니 최종가격
	@GetMapping(value = "/basketTotalPrice")
	@ResponseBody
	public int basketTotalPrice(@RequestParam("cid") String cid) {
		
		Integer totalPrice = boardService.selectBasketTotalPrice(cid);
		
		if(totalPrice == 0 || totalPrice.equals(null)) {
			return 0;
		}
		
		return totalPrice;
	}
	
	//용민
	//찜하기
	@PostMapping(value = "/doZim", 
			 consumes = "application/json; charset=utf-8", 
			 produces = "text/plain; charset=utf-8")
	@ResponseBody
	@PreAuthorize("hasRole('ROLE_CLIENT')")
	public String doZim(@RequestBody ZimVO zimVO) {	
		log.info("zimVO: " + zimVO);
		
		String insertCount = Integer.toString(boardService.insertZim(zimVO));
		
		return insertCount;
	}
	
	//용민
	//판매 물품 페이지
	@GetMapping("/saleRegister")
	@PreAuthorize("hasRole('ROLE_VENDOR')")
	public void saleRegister(Model model) {
		
		model.addAttribute("product", boardService.selectPcode());
	}
	
	//용민
	//판매 물품 등록
	@PostMapping("/saleRegister")
	public String saleRegister(SaleBoardVO saleBoardVO, RedirectAttributes rttr, Principal principal) {
		
		log.info("/register......");
		
		saleBoardVO.setVid(principal.getName());
		
		log.info(principal.getName());
		
		if(saleBoardVO.getAttachList() != null) {
			
			saleBoardVO.getAttachList().forEach(boardAttachVO -> log.info(boardAttachVO));
		}
		
		log.info("saleBoardVO.getThumbImg(): " + saleBoardVO.getThumbImg());
		log.info("===========================");
		
		boardService.register(saleBoardVO);
		rttr.addFlashAttribute("result", saleBoardVO.getSno());
		return "redirect:/board/saleBoard";
		
	}
	
	//용민
	//판매 물품 수정 페이지
	@GetMapping("/saleModify")
	public void saleModify(@RequestParam("sno") int sno, Model model) {
		
		model.addAttribute("product", boardService.selectPcode());
		model.addAttribute("sale", boardService.getSaleDetail(sno));
		
	}
	
	//용민
	//판매 물품 등록
	@PostMapping("/saleModify")
	public String saleModify(SaleBoardVO saleBoardVO, RedirectAttributes rttr) {
		
		log.info("/register......");
		
		if(saleBoardVO.getAttachList() != null) {
			
			saleBoardVO.getAttachList().forEach(boardAttachVO -> log.info(boardAttachVO));
		}
		
		log.info("saleBoardVO.getThumbImg(): " + saleBoardVO.getThumbImg());
		log.info("===========================");
		
		boardService.modifyProduct(saleBoardVO);
		rttr.addFlashAttribute("result", saleBoardVO.getSno());
		return "redirect:/board/saleBoard";
		
	}
	
	//용민
	//상품 삭제
	@GetMapping("/saleDelete")
	public String saleDelete(int sno) {
		
		log.info("delete: " + sno);
		
		boardService.removeProduct(sno);
		
		return "redirect:/board/saleBoard";
	}
	
	//용민
	//결제 페이지
	@GetMapping(value = "/salePay")
	public void salePay(@RequestParam("cid") String cid, Model model) {
		
		if(cid != null && cid.length() != 0 && cid != "") {
			
			List<HashMap<String, String>> basketList = boardService.selectBasketListSaleBoard(cid);
			
			List<Integer> snoList = new ArrayList<Integer>(); 
			
			for(int i=0; basketList.size() > i ; i++) {
				
				log.info("saleBoardList.get(i).getSno(): " + basketList.get(i));
				log.info("saleBoardList.get(i).getSno(): " + String.valueOf(basketList.get(i).get("SNO")));
				snoList.add(Integer.parseInt(String.valueOf(basketList.get(i).get("SNO"))));
			}
			
			model.addAttribute("thumbImgSnoList", snoList);
			model.addAttribute("totalPrice", boardService.selectBasketTotalPrice(cid));
			model.addAttribute("basketList", basketList);
		}
		
		System.out.println(boardService.selectBasketList(cid).toString());
		
	}
	
	//용민
	//결제 페이지
	@PostMapping(value = "/salePay")
	public void salePay(OrdVO ordVO , Model model) {
		
		log.info("asd: " + ordVO);
		
		boardService.insertProductPay(ordVO);
	}
	
	//용민
	//결제 페이지
	@PostMapping(value = "/pay")
	public String pay(OrdVO ordVO , int totalPrice, Model model) {
		
		log.info(ordVO);
		log.info(totalPrice);
		
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("ordVO", ordVO);
		
		return "/admin/pay";
	}
	
	//용민
	//찜되어있나 확인
	@PostMapping(value = "/checkZim",
			 	 consumes = "application/json; charset=utf-8", 
			 	 produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String checkZim(@RequestBody ZimVO zimVO) {
		
		log.info("ZimVO:" + zimVO);
		
		return boardService.selectZim(zimVO);
	}
	
	//용민
	//conferdoc
	@GetMapping(value = "/conferDoc")
	public void conferDoc(@RequestParam(value="ocode", required = false) String ocode,
						  String cid,
						  Model model) {
	
		model.addAttribute("cid", cid);
		if (ocode != null) {
		//if (ocode != null || !("".equals(ocode))) {
			model.addAttribute("confer", boardService.selectProduct(ocode));
		}
		
	}
	
	@PostMapping(value = "/conferDocSend")
	public String conferDoc(OrdVO ordVO, OrdProductVO ordProductVO ) {
		
		log.info(ordVO);
		log.info(ordProductVO);
		
		log.info("conferDoc");
		
		boardService.insertConfer(ordVO, ordProductVO);
		
		return "/vendor/mypage";
	}
	
	@PostMapping(value = "/conferCheck")
	public String conferCheck(OrdVO ordVO) {
		
		log.info(ordVO);
		
		boardService.updateOrdConfer(ordVO);
		
		return "/client/mypage";
	}
}
