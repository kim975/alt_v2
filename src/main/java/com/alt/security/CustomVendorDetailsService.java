package com.alt.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.alt.domain.MemberVO;
import com.alt.mapper.VendorMapper;
import com.alt.security.domain.CustomVendorUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomVendorDetailsService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private VendorMapper vendorMapper;

	@Override
	public UserDetails loadUserByUsername(String vid) throws UsernameNotFoundException {

		log.warn("읽어진 회원의 아이디 정보 : " + vid);

		MemberVO memberVO = vendorMapper.read(vid);

		log.warn("클라이언트 메퍼에 의해서 반환된 clientVO : " + memberVO);

		return  memberVO == null ? null : new CustomVendorUser(memberVO) ;
	} 

}
