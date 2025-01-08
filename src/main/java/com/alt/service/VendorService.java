package com.alt.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.OrdVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.VendorAuthVO;
import com.alt.domain.VendorVO;

public interface VendorService {
	
	//서영
	
	//업체 계정 삽입
	public String VendorRegister(VendorVO vendorVO);
	 
	//업체 권한 삽입
	public String RoleRegister(VendorAuthVO vendorAuthVO);
	
	//업체 아이디 중복 체크
	public String vendoridCheck(String vid);
	
	//업체 이름 중복 체크
	public String vendorName(String vname);
	
	//업체 사업자 번호 중복 체크
	public String vendorNoCheck(String vregisterNo);
	
	//업체 전화번호 중복 체크
	public String phoneCheck(String vphone);
	
	
	//서영
	//마이페지이-업체 정보 수정 (비밀번호)
	public boolean modifyPasswordVendor(VendorVO vendorVO);
	//서영
	//마이페이지 - 회원  정보 출력
	public VendorVO listVendor(String vid);
	
	//지영
	//마이페이지-업체 정보 출력
	public VendorVO infoListVendor(String vid);
	
	//지영
	//마이페이지-업체 정보 수정
	public boolean modifyVendor(VendorVO vendorVO);
	
	//지영
	//마이페이지-업체 탈퇴 
	public boolean deleteVendor(VendorVO vendorVO);
	
	//서영
	//마이페이지 - 업체 탈퇴 권한 삭제
	public boolean deleteVendorAuth(VendorAuthVO vendorauthVO);
	
 	//지영
	//마이페이지-업체 판매 리스트
 	public List<SaleBoardVO> saleListVendor(String vid);
	
	//지영
	//마이페이지-업체 주문 리스트
	public List<HashMap<String, String>> ordListVendor(String vid);
	
 	//지영
 	//마이페이지-업체 주문 결제확인
 	public boolean ordCheckVendor(String ocode);
 	
 	//지영
 	//마이페이지-업체 주문 결제 검색
 	public List<HashMap<String, String>> ordSearchVendor(@Param("vid") String vid,@Param("type") String type);
 	
    //성환
   	//마이페이지 - 주문 상세 내역
  	public List<HashMap<String, String>> listOrdProduct(String ocode);
	
}