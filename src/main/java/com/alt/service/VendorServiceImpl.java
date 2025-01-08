package com.alt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.OrdVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.VendorAuthVO;
import com.alt.domain.VendorVO;
import com.alt.mapper.VendorMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class VendorServiceImpl implements VendorService {

    @Setter(onMethod_ = {
        @Autowired
    })
    private VendorMapper vendorMapper;

  //서영
	//마이페이지 -회원 정보 수정(비밀번호)
	@Override
	public boolean modifyPasswordVendor(VendorVO vendorVO) {
		
		log.info("회원 정보 수정 실행......" + vendorVO);
		
		vendorMapper.modifyPasswordVendor(vendorVO);
		
		//만족하면 true
		return vendorMapper.modifyPasswordVendor(vendorVO) ==1;
	}
  	
    //서영
	//마이페이지 - 회원 정보 출력
	@Override
	public VendorVO listVendor(String vid) {

		log.info("ServiceImpl vendor List..........");

		System.out.println("vid = " + vid);
		
		return vendorMapper.listVendor(vid);
	}
  		

    //업체 계정 삽입
    public String VendorRegister(VendorVO vendorVO) {
        log.info("업체 계정 삽입  " + vendorVO);
        vendorMapper.VendorRegister(vendorVO);

        return "VendorRegister";

    }

    //업체 권한 삽입
    public String RoleRegister(VendorAuthVO vendorauthVO) {
        log.info("회원 추가 Service " + vendorauthVO);
        vendorMapper.RoleRegister(vendorauthVO);

        return "RoleRegister";

    }

    //업체 아이디 중복 체크
    @Override
    public String vendoridCheck(String vid) {
        log.info("cid 중복확인서비스 " + vid);
        String result = vendorMapper.vendoridCheck(vid);
        return result;
    }

    //업체 이름 중복 체크
    @Override
    public String vendorName(String vname) {
        log.info("cnick 중복확인서비스" + vname);
        String result = vendorMapper.vendorName(vname);
        return result;
    }

    //업체 사업자 등록번호 중복 체크
    @Override
    public String vendorNoCheck(String vregisterNo) {
        log.info("cphone 중복확인서비스" + vregisterNo);
        String result = vendorMapper.vendorNoCheck(vregisterNo);
        return result;
    }
    
    //업체 전화번호 중복 체크
    @Override
    public String phoneCheck(String vphone) {
        log.info("cphone 중복확인서비스" + vphone);
        String result = vendorMapper.phoneCheck(vphone);
        return result;
    }






    //지영
    //마이페이지-업체 정보 출력
    @Override
    public VendorVO infoListVendor(String vid) {
        log.info("Service infoListVendor() : " + vid);
        return vendorMapper.infoListVendor(vid);
    }

    //지영
    //마이페이지-업체 정보 수정
    @Override
    public boolean modifyVendor(VendorVO vendorVO) {
        log.info("Service modifyVendor() : " + vendorVO);
        return vendorMapper.modifyVendor(vendorVO) == 1;
    }

    //지영
    //마이페이지-업체 탈퇴 
    @Override
    public boolean deleteVendor(VendorVO vendorVO) {
        log.info("Service deleteVendor() : " + vendorVO);
        return vendorMapper.deleteVendor(vendorVO) == 1; //만족하면 true 'T'
    }
    
	//서영
	//마이페이지 - 업체 탈퇴 권한 삭제
	public boolean deleteVendorAuth(VendorAuthVO vendorauthVO) {
		
		log.info("remove......" + vendorauthVO);
		
		vendorMapper.deleteVendorAuth(vendorauthVO);
		
		//만족하면 true
		return vendorMapper.deleteVendorAuth(vendorauthVO) == 1;
	}

    //지영
    //마이페이지-업체 판매 리스트
    public List < SaleBoardVO > saleListVendor(String vid) {
        log.info("saleListVendor");
        return vendorMapper.saleListVendor(vid);
    }

    //지영
    //마이페이지-업체 주문 리스트
    @Override
    public List < HashMap < String, String >> ordListVendor(String vid) {
        log.info("Service ordListVendor() " + vid);
        return vendorMapper.ordListVendor(vid);
    }

    //지영
    //마이페이지-업체 주문 결제확인
    public boolean ordCheckVendor(String ocode) {
        log.info("Service ordCheckVendor() : " + ocode);
        return vendorMapper.ordCheckVendor(ocode) == 1;
    }

    //지영
    //마이페이지-업체 주문 결제 검색
    public List <HashMap<String, String>> ordSearchVendor(String vid, String type) {
        log.info("Service ordCheckVendor() : " + vid);
        return vendorMapper.ordSearchVendor(vid, type);
    }
    
    //성환
 	//마이페이지 - 주문 상세 내역
 	public List<HashMap<String, String>> listOrdProduct(String ocode) {
 		
 		log.info("getList..........");
		
 		return vendorMapper.listOrdProduct(ocode);
 	}
 
    


}