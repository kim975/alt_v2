package com.alt.controller;


import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alt.service.AdminService;
import com.alt.service.ReplyService;

//import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
//@Log4j
public class HomeController {
	
	//private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	//dddd
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@Autowired
	   private AdminService adminService;
	
	@Autowired
	private ReplyService replyService;
	    
	   @RequestMapping(value = "/", method = RequestMethod.GET)
	   public String home(Locale locale, Model model) {
	      
		   model.addAttribute("reply", replyService.selectIndexReply());
		   
	      int clientCount = adminService.clientCount();
	      model.addAttribute("clientCount", clientCount);
	      
	      int vendorCount = adminService.vendorCount();
	      model.addAttribute("vendorCount", vendorCount);
	      
	      int totalsaleboard = adminService.totalsaleboard();
	      model.addAttribute("totalsaleboard", totalsaleboard);
	      
	      int totalOrd = adminService.totalOrd();
	      model.addAttribute("totalOrd", totalOrd);

	      return "index";
	   }
	
//	@RequestMapping(value = "/juso/Sample", method = {RequestMethod.GET, RequestMethod.POST})
//	public String Sample(Locale locale, Model model) {
//		return "/client/Sample";
//	}
//	
//	@RequestMapping(value = "/juso/jusoPopup", method = {RequestMethod.GET, RequestMethod.POST})
//	public String jusoPopup(Locale locale, Model model) {
//		return "/client/jusoPopup";
//	}
	
	//서영
//	@RequestMapping(value = "/mypage_update", method = RequestMethod.GET)
//	public String mypage_update(Locale locale, Model model) {
//		return "client/mypage_update";
//	}
	
	//서영
	@RequestMapping(value = "/mypage_delete", method = RequestMethod.GET)
	public String mypage_delete(Locale locale, Model model) {
		return "client/mypage_delete";
	}
	
}
