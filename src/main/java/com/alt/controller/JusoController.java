package com.alt.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/juso/*")
public class JusoController {

	@RequestMapping(value = "/juso/Sample", method = {RequestMethod.GET, RequestMethod.POST})
	public String Sample(Locale locale, Model model) {
		return "/juso/Sample";
	}
	
	@RequestMapping(value = "/juso/jusoPopup", method = {RequestMethod.GET, RequestMethod.POST})
	public String jusoPopup(Locale locale, Model model) {
		return "/juso/jusoPopup";
	}
	
	
}
