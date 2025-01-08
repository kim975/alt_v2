package com.alt.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.domain.OrdVO;
import com.alt.domain.ZimVO;

public interface ClientService {

	//정민
	//client 추가
	public String register(ClientVO clientVO);
	
	//서영
	//client 추가
	public String Roleregister(ClientAuthVO clientAuthVO);

	//정민
	//로그인체크
	public HashMap<String, String> loginCheck(ClientVO vo, HttpSession session);
	
	//정민
	//아이디 중복확인
	public String idCheck(String cid);
	
	//정민
	//닉 중복확인
	public String nickCheck(String cnick);
	
	//정민
	//폰 중복확인
	public String phoneCheck(String cphone);
	 
	//로그아웃
	public void logout(HttpSession session);
	//////////////////////////////////////////////////////////////////////
	
	
	//서영
	//마이페이지 - 회원  정보 출력
	public ClientVO listClient(String cid);
	
	//서영
	//마이페지이-회원 정보 수정
	public boolean modifyClient(ClientVO clientVO);
	
	//서영
	//마이페지이-회원 정보 수정 (비밀번호)
	public boolean modifyPasswordClient(ClientVO clientVO);
	
	//서영
	//마이페이지 - 회원 탈퇴
	public boolean deleteClient(ClientVO clientVO);
	
	//서영
	//마이페이지 - 회원 탈퇴 권한 삭제
	public boolean deleteClientAuth(ClientAuthVO clientauthVO);
	
	//서영
	//마이페이지 - 회원 찜 목록
	public List<ZimVO> listZim(String cid);
	
	//서영
	//마이페이지 - 회원 주문 목록
	public List<OrdVO> listOrd(String cid);
	
	//서영
	//마이페이지 - 회원 주문 목록 - 검색
	public List<OrdVO> ordSearchClient(String cid, String type);
	
	//성환
	//마이페이지 - 주문 상세 내역
	public List<HashMap<String, String>> listOrdProduct(String ocode);
	
	
	

}
