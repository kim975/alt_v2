package com.alt.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;




import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {
   
//	@Autowired
//	private ClientService clientService;
	
//	@Autowired
//	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
   @GetMapping("/accessError")
   public String accessDenied(Authentication authentication, Model model) {
      
      System.out.println("엑세스 거부시 처리되는 컨트롤러 메소드");
      
      log.info("엑세스 거부시 처리되는 컨트롤러 메소드: " + authentication);
      
      model.addAttribute("msg", "Access Denied");
      
      return "/accessError";
   }
   
   @GetMapping("/client/loginForm")
   public String loginInput(String error, String logout, Model model) {
      
      log.info("error: " + error);
      
      log.info("logout:" + logout);
      
      if(error != null) {
         model.addAttribute("error", "아이디 비밀번호가 틀립니다. 다시 입력해주세요");
      }
      
      if(logout != null) {
         model.addAttribute("logout", "로그아웃 되었습니다.");
      }
      
      //return "/sample30/customLogin";
      return "/client/loginForm";
   }
   
   @GetMapping("/vendor/loginForm")
   public String vendor(String error, String logout, Model model) {
      
      log.info("error: " + error);
      
      log.info("logout:" + logout);
      
      if(error != null) {
         model.addAttribute("error", "아이디 비밀번호가 틀립니다. 다시 입력해주세요");
      }
      
      if(logout != null) {
         model.addAttribute("logout", "로그아웃 되었습니다.");
      }
      
      //return "/sample30/customLogin";
      return "/vendor/loginForm";
   }
   
   @GetMapping("/all/loginForm")
   public String all(String error, String logout, Model model) {
      
      log.info("error: " + error);
      
      log.info("logout:" + logout);
      
      if(error != null) {
         model.addAttribute("error", "아이디 비밀번호가 틀립니다. 다시 입력해주세요");
      }
      
      if(logout != null) {
         model.addAttribute("logout", "로그아웃 되었습니다.");
      }
      
      //return "/sample30/customLogin";
      return "/all/loginForm";
   }
   
   @GetMapping("/Logout")
   public String logoutGet() {
	   
	   log.info("GET custom logout");
	   return "redirect:/";
	   
   }
   
   @PostMapping("/Logout")
   public String logoutPost() {
	   
	   log.info("POST custom logout");
	   return "redirect:/";
	   
   }
   
   
   
}