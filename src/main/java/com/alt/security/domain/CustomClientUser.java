package com.alt.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.alt.domain.MemberVO;

import lombok.Getter;
import lombok.extern.log4j.Log4j;

@Getter
@Log4j
public class CustomClientUser extends User {

	private static final long serialVersionUID = 1L;

	private MemberVO memberVO;

	//여기부분은 굳지 사용하지 않아도 됩니다. 주석처리 가능!!
	public CustomClientUser(String username, 
					  String password, 
					  Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public CustomClientUser(MemberVO memberVO) {
		
		super(memberVO.getCid() , //시큐리티가 사용하는 username 셋팅
			  memberVO.getCpassword(), //시큐리티가 사용하는 password 셋팅
			  memberVO.getClientAuthList().stream()
				                  .map(authority -> new SimpleGrantedAuthority(authority.getAuthority()))
				                  .collect(Collectors.toList()));

		log.info("clientVO: " + memberVO);
		this.memberVO = memberVO;
	}
}
