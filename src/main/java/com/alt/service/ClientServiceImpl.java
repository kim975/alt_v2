package com.alt.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.domain.OrdVO;
import com.alt.domain.ZimVO;
import com.alt.mapper.ClientMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ClientServiceImpl implements ClientService{
	
	@Autowired
	private ClientMapper clientMapper;
	
	   //회원 추가
		public String register(ClientVO clientVO) {
			log.info("회원 추가 Service "+ clientVO);
			clientMapper.register(clientVO);
			
			return "register";
			
		}
		
		//권한 추가
				public String Roleregister(ClientAuthVO clientAuthVO) {
					log.info("회원 추가 Service "+ clientAuthVO);
					clientMapper.Roleregister(clientAuthVO);
					
					return "Roleregister";
					
				}
		
		//로그인 체크
		 @Override
		 public HashMap<String, String> loginCheck(ClientVO vo, HttpSession session) {
			 log.info("로그인 체크 Service "+ vo);
				 HashMap<String, String> result = clientMapper.loginCheck(vo);
				 return result;
			   }
		
		 
		 //아이디 중복 확인
		   @Override
			public String idCheck(String cid)  {
			   log.info("cid 중복확인서비스 " + cid);
			   String result = clientMapper.idCheck(cid);
			   return result;
		   }
		   
		 //cnick 중복 확인
		   @Override
			public String nickCheck(String cnick)  {
			   log.info("cnick 중복확인서비스" +cnick );
			   String result = clientMapper.nickCheck(cnick);
			   return result;
		   }
		   
		 //cphone 중복 확인
		   @Override
			public String phoneCheck(String cphone)  {
			   log.info("cphone 중복확인서비스" +cphone );
			   String result = clientMapper.phoneCheck(cphone);
			   return result;
		   }
		   
		   //로그아웃
		   public void logout(HttpSession session){
				  
				  session.invalidate();
				  
		   }
	
 
		   //////////////////////////////////////////////////////////////////////
		   
		   
		   //서영
		//마이페이지 - 회원 정보 출력
		@Override
		public ClientVO listClient(String cid) {

			log.info("ServiceImpl Client List..........");

			System.out.println("cid = " + cid);
			
			return clientMapper.listClient(cid);
		}
		
		
		//서영
		//마이페이지 -회원 정보 수정
		@Override
		public boolean modifyClient(ClientVO clientVO) {
			
			log.info("회원 정보 수정 실행......" + clientVO);
			
			clientMapper.modifyClient(clientVO);
			
			//만족하면 true
			return clientMapper.modifyClient(clientVO) == 1;
		}
		
		//서영
		//마이페이지 -회원 정보 수정(비밀번호)
		@Override
		public boolean modifyPasswordClient(ClientVO clientVO) {
			
			log.info("회원 정보 수정 실행......" + clientVO);
			
			clientMapper.modifyPasswordClient(clientVO);
			
			//만족하면 true
			return clientMapper.modifyPasswordClient(clientVO) == 1;
		}
		
		//서영
		//마이페이지 - 회원 탈퇴
		public boolean deleteClient(ClientVO clientVO) {
			
			log.info("remove......" + clientVO);
			
			clientMapper.deleteClient(clientVO);
			
			//만족하면 true
			return clientMapper.deleteClient(clientVO) == 1;
		}
		
		//서영
		//마이페이지 - 회원 탈퇴 권한 삭제
		public boolean deleteClientAuth(ClientAuthVO clientauthVO) {
			
			log.info("remove......" + clientauthVO);
			
			clientMapper.deleteClientAuth(clientauthVO);
			
			//만족하면 true
			return clientMapper.deleteClientAuth(clientauthVO) == 1;
		}
		
		//서영
		//마이페이지 - 회원 찜 목록
		@Override
		public List<ZimVO> listZim(String cid) {

			log.info("getList..........");

			return clientMapper.listZim(cid);
		}
		
		//서영
		//마이페이지 - 회원 주문 목록
		@Override
		public List<OrdVO> listOrd(String cid) {

			log.info("getList..........");

			return clientMapper.listOrd(cid);
		}
		
		//서영
		//마이페이지 - 회원 주문 목록 - 검색
	 	public List<OrdVO> ordSearchClient(String cid, String type) {
	 		log.info("Service ordSearchClient() : " + cid);
	 		return clientMapper.ordSearchClient(cid, type);

	 	}
	 	
	 	//성환
	 	//마이페이지 - 주문 상세 내역
	 	public List<HashMap<String, String>> listOrdProduct(String ocode) {
	 		
	 		log.info("getList..........");
			
	 		return clientMapper.listOrdProduct(ocode);
	 	}
	 
	
}
