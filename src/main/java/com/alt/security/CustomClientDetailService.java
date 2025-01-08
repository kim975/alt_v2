package com.alt.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.alt.domain.MemberVO;
import com.alt.mapper.ClientMapper;
import com.alt.security.domain.CustomClientUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomClientDetailService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private ClientMapper clientMapper;

	@Override
	public UserDetails loadUserByUsername(String cid) throws UsernameNotFoundException {
		
		log.warn("읽어진 회원의 아이디 정보 : " + cid);

		MemberVO memberVO = clientMapper.read(cid);
		
		log.warn("클라이언트 메퍼에 의해서 반환된 clientVO : " + memberVO);

		return  memberVO == null ? null : new CustomClientUser(memberVO);
	} 

}
