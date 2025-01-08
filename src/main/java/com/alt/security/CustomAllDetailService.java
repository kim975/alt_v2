package com.alt.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.alt.domain.MemberVO;
import com.alt.mapper.ClientMapper;
import com.alt.mapper.VendorMapper;
import com.alt.security.domain.CustomClientUser;
import com.alt.security.domain.CustomVendorUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomAllDetailService implements UserDetailsService {

	@Setter(onMethod_ = { @Autowired })
	private ClientMapper clientMapper;
	
	@Setter(onMethod_ = { @Autowired })
	private VendorMapper vendorMapper;
	
	@Override
	public UserDetails loadUserByUsername(String cid) throws UsernameNotFoundException {
		
		log.info("aaaaaaaaaaaaaaaaaaaaaa");
		
		log.warn("읽어진 회원의 아이디 정보 : " + cid);
		
		String idCheck = cid.substring(0,1);
		
		log.info("idCheck: " + idCheck);
		
		MemberVO memberVO = new MemberVO();
		 
		if(idCheck.equals("c")) {
			
			log.info("cid.substring(1, cid.length()): " + cid.substring(1, cid.length()));
			
			memberVO = clientMapper.read(cid.substring(1, cid.length()));
			
			UserDetails userDetails = memberVO == null ? null : new CustomClientUser(memberVO);
			return  userDetails;
		} else {
			
			log.info("cid.substring(1, cid.length()): " + cid.substring(1, cid.length()));
			
			memberVO = vendorMapper.read(cid.substring(1, cid.length()));
			
			UserDetails userDetails = memberVO == null ? null : new CustomVendorUser(memberVO);
			return  userDetails;
		}
		 
//		log.warn("클라이언트 메퍼에 의해서 반환된 clientVO : " + memberVO);
//
//		return  memberVO == null ? null : new CustomClientUser(memberVO);
	} 

}
