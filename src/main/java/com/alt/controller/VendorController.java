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

import com.alt.domain.VendorAuthVO;
import com.alt.domain.VendorVO;
import com.alt.service.VendorService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/vendor/*")
@AllArgsConstructor
public class VendorController {

	private VendorService vendorService;
	
	//지영
	//마이페이지 목록
	@GetMapping("/vendor/mypage")
	public void vendorMypage() {
	}
	
	   //서영
			//마이페지이 - 회원 정보 비밀번호 수정
			//@PreAuthorize("principal.username == #clientVO.cid")
			@PostMapping("/vendor/modifyPassword")
			public String modifyPassword(VendorVO vendorVO, RedirectAttributes rttr, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
				
				Authentication auth = SecurityContextHolder.getContext().getAuthentication();
				
				log.info("/modify......");
				if(vendorService.modifyPasswordVendor(vendorVO)) {
					rttr.addFlashAttribute("result", "success");
				}
				
				String vid  = auth.getName();
				
				System.out.println("vid : " + vid);
				
				if(vid != null){
					new SecurityContextLogoutHandler().logout(request, response, auth);
				}
				
				return "redirect:/vendor/loginForm" ;
				
			}
    //서영
	//마이페지이 - 회원 리스트 출력
	//@PreAuthorize("principal.username == #clientVO.cid")
	@GetMapping("/vendor/mypage_update_password")
	public void mypage_update_password(@RequestParam(value="vid", required=false)  String vid, Model model) {
		
		log.info("/listVendor......");
		
		System.out.println("vid = " + vid);
		model.addAttribute("vendor", vendorService.listVendor(vid));
		
	}
	
	//지영
	//마이페이지-업체 정보 출력(/info /modify /delete) get
	//@PreAuthorize("principal.username == #vendorVO.vid")
	@GetMapping({"/mypage_info","/mypage_modify","/mypage_delete"})
	public void infoListVendor(@RequestParam(value="vid")String vid, Model model) {
		log.info("mypage_info_modify_delete infoListVendor() : "+ vid);
		model.addAttribute("vendor", vendorService.infoListVendor(vid));
	}
	
	//지영
	//마이페이지-업체 정보 수정 post
	//@PreAuthorize("principal.username == #vendorVO.vid")
	@PostMapping("/modify")
	public String modifyVendor(VendorVO vendorVO, RedirectAttributes redirectAttr) {
		log.info("modifyVendor() : " + vendorVO);
		if(vendorService.modifyVendor(vendorVO)) {
			redirectAttr.addFlashAttribute("result","success");
		}
		//return "redirect:/vendor/mypage_info";
		return "redirect:/vendor/mypage";
	}

	//지영
	//마이페이지-업체 탈퇴 post
	//@PreAuthorize("principal.username == #vendorVO.vid")
	@PostMapping("/delete")
	public String deleteVendor(VendorAuthVO vendorauthVO, VendorVO vendorVO, RedirectAttributes redirectAttr, RedirectAttributes rttr, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		log.info("deleteVendor() : " + vendorVO);
		
		if(vendorService.deleteVendor(vendorVO) && vendorService.deleteVendorAuth(vendorauthVO)) {
			
			redirectAttr.addFlashAttribute("result", "success");
		
		}
		
		String vid  = auth.getName();
		
		System.out.println("cid : " + vid);
		
		if(vid != null){
			
			new SecurityContextLogoutHandler().logout(request, response, auth);
			
		}
		
		return "redirect:/";
		
	}
	
	//지영
	//마이페이지-업체 판매글 리스트
	@GetMapping("/mypage_salelist")
	public void saleListVendor(@RequestParam(value="vid") String vid, Model model) {
		log.info("saleListVendor() " + vid);
		model.addAttribute("salelist", vendorService.saleListVendor(vid));
	}
	
	//지영
	//마이페이지-업체 주문 리스트(검색)
//	@GetMapping("/mypage_orderlist")
//	public void ordListVendor(@RequestParam(value="vid") String vid, 
//							  @RequestParam(value = "type", required = false) String type,
//							  Model model) {
//		log.info("ordListVendor() "+ vid);
//		model.addAttribute("ordlist", vendorService.ordListVendor(vid));
//	}
	
	@GetMapping("/mypage_orderlist")
	public void ordListVendor(@RequestParam(value="vid") String vid, 
									 @RequestParam(value = "type", required = false) String type,
									 Model model) {
		log.info("ordListVendor() "+ vid);
		
		
		if(type=="" || type==null) {
			
			model.addAttribute("ordlist", vendorService.ordListVendor(vid));
			
		} else {
			
			model.addAttribute("ordlist", vendorService.ordSearchVendor(vid, type));
			
		}
		
	}

 	//지영
 	//마이페이지-업체 주문 결제확인
	//session을 보내서 vid 값 불러옴
	//Required String parameter 'vid' is not present(ordlist에는 vid 필요)
	@GetMapping("/chekckord")
 	public String ordCheckVendor(@RequestParam(value="ocode") String ocode, RedirectAttributes redirectAttr) {
 		log.info("ordCheckVendor ocode() : " + ocode);
 		
 		if(vendorService.ordCheckVendor(ocode)) {
 			
 			redirectAttr.addFlashAttribute("result", "success");
 			
 		}
 		
 		//return "redirect:/vendor/mypage_orderlist";
 		return "redirect:/vendor/mypage";
 		
 	}
	
	//성환
	//마이페이지 - 회원 주문 목록 - 상세 주문 내역
	@GetMapping("/vendor/mypage_ordercode")
	public void listOrdProduct(@RequestParam(value="ocode", required=false) String ocode, Model model) {
    
        log.info("ocode: "+ ocode);
		
        List<HashMap<String, String>> OrdVO = vendorService.listOrdProduct(ocode);
        
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