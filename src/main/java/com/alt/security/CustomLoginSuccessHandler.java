package com.alt.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
										HttpServletResponse response,
										Authentication auth) throws IOException, ServletException {
		
		log.warn("Login Success");
		
		//roleNames : 권한을 저장할 리스트 생성
		List<String> roleNames = new ArrayList<>();
		
		//
		auth.getAuthorities().forEach(authority -> {
			
			roleNames.add(authority.getAuthority());
			
		});
		
		log.warn("ROLE NAMES: " + roleNames);
		
		//권한 목록에 ROLE_ADMIN이 포함되어 있으면
		if(roleNames.contains("ROLE_ADMIN")) {
			
			response.sendRedirect("/admin/admin");
			return;
		}
		
		//권한 목록에 ROLE_MEMBER이 포함되어 있으면
		if(roleNames.contains("ROLE_CLIENT")) {
			
			response.sendRedirect("/");
			return;
		}
		
		//권한 목록에 ROLE_VENDOR이 포함되어 있으면
		if(roleNames.contains("ROLE_VENDOR")) {
			
			response.sendRedirect("/");
			return;
		}
		
		response.sendRedirect("");
	}
	
}
