package com.alt.controller;

import java.io.IOException;


import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.domain.VendorAuthVO;
import com.alt.domain.VendorVO;
import com.alt.service.ClientService;
import com.alt.service.VendorService;

import lombok.extern.log4j.Log4j;
@Controller
@Log4j
//@RequestMapping("/login/*")
public class LoginController {

	@Autowired
	private ClientService clientService;
	
	@Autowired
	private VendorService vendorService;
	
//	@Autowired
//	private BCryptPasswordEncoder bcryptPasswordEncoder;
	

	//서영
	//로봇이 아닙니다.
    @ResponseBody
    @RequestMapping(value = "/VerifyRecaptcha", method = RequestMethod.POST)
    public int VerifyRecaptcha(HttpServletRequest request) {
        VerifyRecaptcha.setSecretKey("6LdmFnkaAAAAAMHTi97OhthBJMqrPufMjpbzVU3Q");
        String gRecaptchaResponse = request.getParameter("recaptcha");
        System.out.println("gRecaptchaResponse 값 : " + gRecaptchaResponse);
        //0 = 성공, 1 = 실패, -1 = 오류
        try {
            if(VerifyRecaptcha.verify(gRecaptchaResponse))
                return 0;
            else return 1;
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
    }

	//서영
	//회원가입 약관 동의 (회원)
	@GetMapping(value="/sign_check_client")
	public String client_sign_check() {
		
		return "/client/sign_check" ;
		
	}
	
	//서영
	//회원가입 약관 동의 (업체)
	@GetMapping(value="/sign_check_vendor")
	public String vendor_sign_check() {
		
		return "/vendor/sign_check" ;
		
	}
	
	//서영
	//회원 가입 입력 창 (회원)
	@PostMapping(value="/sign_client")
	public String client_sign() {
		
		log.info("-----회원가입 입력 창 컨트롤러");
		return "/client/sign" ;
		
	}
	
	//서영
	//회원 가입 입력 창 (업체)
	@PostMapping(value="/sign_vendor")
	public String vendor_sign() {
		
		log.info("-----회원가입 입력 창 컨트롤러");
		return "/vendor/sign" ;
		
	}
	
	//서영
	//회원 가입 (회원)
	@PostMapping("/client_join")
	public String client_join (ClientVO clientVO, ClientAuthVO clientAuthVO) {
		
		//vo.setCpassword(bcryptPasswordEncoder.encode(vo.getCpassword()));
		
		log.info("회원가입 성공 : "+ clientVO);
		log.info("회원가입 권한 성공 : "+ clientAuthVO);
		
		clientService.register(clientVO);
		clientService.Roleregister(clientAuthVO);
		
		return "/client/loginForm";
		
	}
	
	//서영
	//아이디 중복 체크 (회원)
	@ResponseBody
	@GetMapping("/idCheck") 
	public String idCheck(@RequestParam("id") String id, HttpServletRequest req ) {
		
		log.info("중복확인 컨트롤러" + id);
	  
		String idCheck =  clientService.idCheck(id);
	  
		int result = 0;
	  
		if(idCheck != null) {
			result = 1;
	 }
	  
	  System.out.println("result: " + idCheck);
		 
     return idCheck;
	}
	
	//서영
	//닉네임 중복 체크 (회원)
	@ResponseBody
	@GetMapping("/nickCheck") 
	public String nickCheck(@RequestParam("nick") String nick, HttpServletRequest req ) {
		 log.info("cnick 중복확인 컨트롤러"+ nick);
	  
	  String nickCheck =  clientService.nickCheck(nick);
	  
	  int result = 0;
	  
	  if(nickCheck != null) {
		  result = 1;
	  }
	  
	  System.out.println("result: " + nickCheck);
		 
     return nickCheck;
	}
	
	//서영
	//전화번호 중복 체크 (회원)
	@ResponseBody
	@GetMapping("/phoneCheck_client") 
	public String phoneCheck_client(@RequestParam("cphone") String cphone, HttpServletRequest req ) {
		 log.info("cphone 중복확인 컨트롤러"+ cphone);
	  
	  String phoneCheck_client =  clientService.phoneCheck(cphone);
	  
	  int result = 0;
	  
	  if(phoneCheck_client != null) {
		  result = 1;
	  }
	  
	  System.out.println("result: " + phoneCheck_client);
		 
     return phoneCheck_client;
	}	
	
	//서영
	//회원가입 (업체)
	@PostMapping("/vendor_join")
	public String vendor_join (VendorVO vendorVO, VendorAuthVO vendorAuthVO) {
		
		//vo.setCpassword(bcryptPasswordEncoder.encode(vo.getCpassword()));
		
		log.info("회원가입 성공 : "+ vendorVO);
		log.info("회원가입 권한 성공 : "+ vendorAuthVO);
		
		vendorService.VendorRegister(vendorVO);
		vendorService.RoleRegister(vendorAuthVO);
		
		return "/vendor/loginForm";
		
	}
	
	//서영
	//아이디 중복 체크 (업체)
	@ResponseBody
	@GetMapping("/vendoridCheck") 
	public String vendoridCheck(@RequestParam("vid") String vid, HttpServletRequest request ) {
		
		log.info("중복확인 컨트롤러" + vid);
	  
		String vendoridCheck =  vendorService.vendoridCheck(vid);
	  
		int result = 0;
	  
		if(vendoridCheck != null) {
			result = 1;
	 }
	  
	  System.out.println("result: " + vendoridCheck);
		 
     return vendoridCheck;
	}

	//서영
	//업체이름 중복 체크 (업체)
	@ResponseBody
	@GetMapping("/vendorName") 
	public String vendorName(@RequestParam("vname") String vname, HttpServletRequest request ) {
		 log.info("cnick 중복확인 컨트롤러"+ vname);
	  
	  String vendorName =  vendorService.vendorName(vname);
	  
	  int result = 0;
	  
	  if(vendorName != null) {
		  result = 1;
	  }
	  
	  System.out.println("result: " + vendorName);
		 
     return vendorName;
	}	 
	
	//서영
	//업체 사업자 등록 번호 중복 체크 (업체)
	@ResponseBody
	@GetMapping("/vendorNoCheck") 
	public String vendorNoCheck(@RequestParam("vregisterNo") String vregisterNo, HttpServletRequest request ) {
		 log.info("cphone 중복확인 컨트롤러"+ vregisterNo);
	  
	  String vendorNoCheck =  vendorService.vendorNoCheck(vregisterNo);
	  
	  int result = 0;
	  
	  if(vendorNoCheck != null) {
		  result = 1;
	  }
	  
	  System.out.println("result: " + vendorNoCheck);
		 
     return vendorNoCheck;
     
	}	
	
	//서영
	//업체 전화번호 중복 체크 (업체)
	@ResponseBody
	@GetMapping("/phoneCheck_vendor") 
	public String phoneCheck_vendor(@RequestParam("vphone") String vphone, HttpServletRequest req ) {
		 log.info("cphone 중복확인 컨트롤러"+ vphone);
	  
	  String phoneCheck_vendor =  vendorService.phoneCheck(vphone);
	  
	  int result = 0;
	  
	  if(phoneCheck_vendor != null) {
		  result = 1;
	  }
	  
	  System.out.println("result: " + phoneCheck_vendor);
		 
     return phoneCheck_vendor;
     
	}	
	
	
}
