package com.alt.mapper;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.domain.MemberVO;
import com.alt.domain.OrdVO;
import com.alt.domain.ZimVO;

public interface ClientMapper {

    //
    //client 삽입
    public void register(ClientVO clientVO);

    //
    //client 권한 삽입
    public void roleRegister(ClientAuthVO clientAuthVO);

    //
    //client 체크
    public HashMap<String, String> loginCheck(ClientVO clientVO);

    //
    //client아이디 중복 확인
    public String idCheck(String cid);

    //
    //client 닉네임중복 확인
    public String nickCheck(String cnick);

    //
    //client phone 중복 확인
    public String phoneCheck(String cphone);

    //
    //로그아웃
    public void logout(HttpSession session);

    ///////////////////////////////////////////////////////////////////////////////////////////

    //
    //마이페이지 회원 정보 출력
    public ClientVO listClient(String cid);

    //
    //마이페이지 회원 수정
    public int modifyClient(ClientVO ClientVO);

    //
    //마이페이지 회원 비밀번호 변경
    public int modifyPasswordClient(ClientVO ClientVO);

    //
    //마이페이지 회원 탈퇴
    public int deleteClient(ClientVO ClientVO);

    //
    //마이페이지 회원 탈퇴 권한 삭제
    public int deleteClientAuth(ClientAuthVO clientauthVO);

    //
    //마이페이지 회원 찜 목록
    public List<ZimVO> listZim(String cid);

    //
    //마이페이지 주문 목록
    public List<OrdVO> listOrd(String cid);

    //
    //마이페이지 - 회원 주문 목록 - 검색
    public List<OrdVO> ordSearchClient(@Param("cid") String cid, @Param("type") String type);

    //
    //마이페이지 - 주문 상세 내역
    public List<HashMap<String, String>> listOrdProduct(String ocode);

    //
    //시큐리티 적용
    public MemberVO read(String id);


}
