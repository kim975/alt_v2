package com.alt.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.domain.ZimVO;
import com.alt.service.ClientService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/client/*")
public class ClientController {

	   private ClientService clientService;

	   public ClientController(ClientService clientService) {
	      this.clientService = clientService;
	   }
	   
		//서영
	   @GetMapping(value="/client/mypage")
		public String loginForm() {
			
			return "/client/mypage" ;
			
		}
	   
	   @GetMapping(value="/client/mypage_delete")
		public String mypage_delete() {
			
			return "/client/mypage_delete" ;
			
		}
			
	    //서영
		//마이페지이 - 회원 정보 출력
		@GetMapping("/client/mypage_info")
		public void listClient(@RequestParam(value="cid", required=false)  String cid, Model model) {
			
			log.info("/Clientlist......");
			
			System.out.println("cid = " + cid);
			model.addAttribute("client", clientService.listClient(cid));
			
		}
		
	    //서영
		//마이페이지 - 회원 리스트 출력

		@GetMapping("/client/mypage_update")
		public void mypage_update(@RequestParam(value="cid", required=false)  String cid, Model model) {
			
			log.info("/Clientlist......");
			
			System.out.println("cid = " + cid);
			model.addAttribute("client", clientService.listClient(cid));
			
		}
		
	    //서영
		//마이페지이 - 회원 리스트 출력
		//@PreAuthorize("principal.username == #clientVO.cid")
		@GetMapping("/client/mypage_update_password")
		public void mypage_update_password(@RequestParam(value="cid", required=false)  String cid, Model model) {
			
			log.info("/Clientlist......");
			
			System.out.println("cid = " + cid);
			model.addAttribute("client", clientService.listClient(cid));
			
		}
	   
	    //서영
		//마이페지이 - 회원 정보 수정
		@PostMapping("/client/modify")
		public String modify( ClientVO clientVO, RedirectAttributes rttr) {
			
			log.info("/modify......");
			if(clientService.modifyClient(clientVO)) {
				rttr.addFlashAttribute("result", "success");
			}
			return "redirect:/client/mypage";
			
		}
		
	    //서영
		//마이페지이 - 회원 정보 비밀번호 수정
		@PostMapping("/client/modifyPassword")
		public String modifyPassword(ClientVO clientVO, RedirectAttributes rttr, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			
			log.info("/modify......");
			if(clientService.modifyPasswordClient(clientVO)) {
				rttr.addFlashAttribute("result", "success");
			}
			
			String cid  = auth.getName();
			
			System.out.println("cid : " + cid);
			
			if(cid != null){
				new SecurityContextLogoutHandler().logout(request, response, auth);
			}
			
			return "redirect:/client/loginForm";
			
		}
		
		//서영
		//회원삭제
		//마이페이지 - 회원 탈퇴
		@PostMapping("/delete")
		public String remove(ClientAuthVO clientauthVO, ClientVO clientVO, RedirectAttributes rttr, HttpSession session, HttpServletRequest request, HttpServletResponse response) {

			
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			
			log.info("/delete......");
			
			if(clientService.deleteClient(clientVO) && clientService.deleteClientAuth(clientauthVO)) {
				
				
				rttr.addFlashAttribute("result", "success");

			}
			
			
			
			String cid  = auth.getName();
			
			System.out.println("cid : " + cid);
			
			if(cid != null){
				
				new SecurityContextLogoutHandler().logout(request, response, auth);
				
			}
			
			return "redirect:/";
		}
		
		//서영
		//마이페이지 - 회원 주문 목록
		@GetMapping("/client/mypage_zimlist")
		public void listZim(@RequestParam(value="cid", required=false)  String cid, Model model) {
				
			log.info("/list......");
			
			List<ZimVO> zimList = clientService.listZim(cid);
			
			List<Integer> snoList = new ArrayList<Integer>(); 
			
			log.info(zimList);
			
			for(int i=0; zimList.size() > i ; i++) {
				
				log.info("saleBoardList.get(i).getSno(): " + zimList.get(i).getSno());
				snoList.add(zimList.get(i).getSno());
			}
			
			model.addAttribute("thumbImgSnoList", snoList);
			
			model.addAttribute("zimlist", zimList);
			
//				log.info("/list......");
//				model.addAttribute("zimlist", clientService.listZim(cid));
				
		}
		
		//서영
		//마이페이지 - 회원 주문 목록 - 검색
		@GetMapping("/client/mypage_orderlist")
		public void listOrd(@RequestParam(value="cid", required=false)  String cid, @RequestParam(value = "type", required = false) String type, Model model) {
			
			log.info("ordListClient() "+ cid);
			
			if(type=="" || type==null) {
				model.addAttribute("ordlist", clientService.listOrd(cid));
			} else {
				model.addAttribute("ordlist", clientService.ordSearchClient(cid, type));
			}
			
		}
		
		//마이페이지 - 회원 주문 목록 - 상세 주문 내역
				@GetMapping("/client/mypage_ordercode")
				public void listOrdProduct(@RequestParam(value="ocode", required=false) String ocode, Model model) {
		        
		            log.info("ocode: "+ ocode);
					
		            List<HashMap<String, String>> OrdVO = clientService.listOrdProduct(ocode);
		            
		    		List<String> snoList = new ArrayList<String>(); 
		    		
		    		for(int i=0; OrdVO.size() > i ; i++) {
		    			
		    			log.info("saleBoardList.get(i).getSno(): " + String.valueOf(OrdVO.get(i).get("SNO"))); 
		    			
		    			snoList.add(String.valueOf(OrdVO.get(i).get("SNO")));
		    		}
		            
		    		log.info(snoList);
		    		
		    		System.out.println("------------------------------");
		    		System.out.println("ordlistproduct :" + OrdVO);
		    		System.out.println("------------------------------");
		    		
		    		model.addAttribute("snoList", snoList);
		            model.addAttribute("ocode", ocode);
		            model.addAttribute("ordlistproduct", OrdVO);
				}
}
