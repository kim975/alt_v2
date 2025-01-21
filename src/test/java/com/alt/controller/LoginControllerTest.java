package com.alt.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.alt.domain.ClientVO;
import com.alt.domain.MemberVO;
import com.alt.domain.VendorAuthVO;
import com.alt.domain.VendorVO;
import com.alt.mapper.ClientMapper;
import com.alt.mapper.VendorMapper;
import com.alt.service.ClientServiceImpl;
import com.alt.service.VendorServiceImpl;
import javax.servlet.ServletException;
import lombok.Setter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockServletConfig;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/security-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Transactional
public class LoginControllerTest {

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Setter(onMethod_ = @Autowired)
    private ClientMapper clientMapper;

    @Setter(onMethod_ = @Autowired)
    private ClientServiceImpl clientService;

    @Setter(onMethod_ = @Autowired)
    private VendorServiceImpl vendorService;

    @Setter(onMethod_ = @Autowired)
    private VendorMapper vendorMapper;

    private DispatcherServlet dispatcherServlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;

    private ClientVO newClient;
    private VendorVO newVendor;
    private ClientVO alreadyJoinedClient;
    private VendorVO alreadyJoinedVendor;

    @BeforeEach
    public void setUp() throws Exception {
        this.request = new MockHttpServletRequest();
        this.response = new MockHttpServletResponse();
        this.dispatcherServlet = new DispatcherServlet(webApplicationContext);
        this.dispatcherServlet.init(new MockServletConfig());
    }

    @BeforeEach
    public void createNewUser() throws Exception {
        newClient = new ClientVO();
        this.newClient.setCid("testId");
        this.newClient.setCpassword("testPassword");
        this.newClient.setCname("testName");
        this.newClient.setCnick("testNickName");
        this.newClient.setCphone("010-1234-1234");
        this.newClient.setCaddress("서울시 강남구");

        newVendor = new VendorVO();
        this.newVendor.setVid("testVendorId");
        this.newVendor.setVpassword("testPassword");
        this.newVendor.setVname("가게 상호");
        this.newVendor.setVregisterNo("123-12-123456");
        this.newVendor.setVphone("010-1234-1234");
        this.newVendor.setVaddress("서울시 강남구");
        this.newVendor.setVinfo("가게 설명");
    }

    @BeforeEach
    public void alreadyJoinedUser() throws Exception {
        alreadyJoinedClient = new ClientVO();
        this.alreadyJoinedClient.setCid("testId11");
        this.alreadyJoinedClient.setCpassword("testPassword");
        this.alreadyJoinedClient.setCname("duplicateName");
        this.alreadyJoinedClient.setCnick("nicknamedupli");
        this.alreadyJoinedClient.setCphone("010-9999-9999");
        this.alreadyJoinedClient.setCaddress("서울시 강남구");

        alreadyJoinedVendor = new VendorVO();
        this.alreadyJoinedVendor.setVid("duplicateVendorId");
        this.alreadyJoinedVendor.setVpassword("duplicatePassword");
        this.alreadyJoinedVendor.setVname("duplicate 가게 상호");
        this.alreadyJoinedVendor.setVregisterNo("999-99-999999");
        this.alreadyJoinedVendor.setVphone("010-9999-9999");
        this.alreadyJoinedVendor.setVaddress("서울시 강남구");
        this.alreadyJoinedVendor.setVinfo("가게 설명");

        clientService.register(alreadyJoinedClient);

        vendorService.VendorRegister(alreadyJoinedVendor);
        VendorAuthVO vendorAuthVO = new VendorAuthVO();
        vendorAuthVO.setVid(alreadyJoinedVendor.getVid());
        vendorAuthVO.setAuthority("ROLE_VENDOR");
        vendorService.RoleRegister(vendorAuthVO);
    }


    @Test
    @DisplayName("신규 사용자가 회원가입을 하면 회원가입이 완료된다")
    public void whenJoinNewClientThenSuccess() throws Exception {

        //given
        request.setMethod("POST");
        request.setRequestURI("/client_join");

        request.setParameter("cid", newClient.getCid());
        request.setParameter("cnick", newClient.getCnick());
        request.setParameter("cpassword", newClient.getCpassword());
        request.setParameter("cname", newClient.getCname());
        request.setParameter("cphone", newClient.getCphone());
        request.setParameter("caddress", newClient.getCaddress());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("", response.getContentAsString()); // 기대하는 응답 내용 검증

        ClientVO joinedClient = clientService.listClient(newClient.getCid());
        assertEquals(newClient.getCid(), joinedClient.getCid());
        assertEquals(newClient.getCpassword(), joinedClient.getCpassword());
        assertEquals(newClient.getCname(), joinedClient.getCname());
        assertEquals(newClient.getCnick(), joinedClient.getCnick());
        assertEquals(newClient.getCphone(), joinedClient.getCphone());
        assertEquals(newClient.getCaddress(), joinedClient.getCaddress());
        assertEquals(0, joinedClient.getCreport());
        assertEquals("N", joinedClient.getCdelete());
        assertEquals("?", joinedClient.getCgrade());
        assertEquals("0", joinedClient.getEnable());

        // 현재는 auth를 가져오는 service가 없어 임시로 mapper 사용
        MemberVO testId = clientMapper.read("testId");
        assertEquals(1, testId.getClientAuthList().size());
        assertEquals("ROLE_CLIENT", testId.getClientAuthList().get(0).getAuthority());

    }

    @Test
    @DisplayName("일반 회원의 아이디 검사 시 중복된 ID가 없다면 'usable' 를 리턴한다.")
    public void whenNonDuplicateClientUserIdCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/idCheck");

        request.setParameter("id", newClient.getCid());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("일반 회원의 아이디 검사 시 중복된 ID가 있다면 'not_usable' 를 리턴한다.")
    public void whenDuplicateClientUserIdCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/idCheck");

        request.setParameter("id", alreadyJoinedClient.getCid());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("not_usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("일반 회원의 닉네임 검사 시 중복된 닉네임이 없다면 'usable' 를 리턴한다.")
    public void whenNonDuplicateClientUserNicknameCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/nickCheck");

        request.setParameter("nick", newClient.getCnick());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("일반 회원의 닉네임 검사 시 중복된 닉네임이 있다면 'not_usable' 를 리턴한다.")
    public void whenDuplicateClientUserNicknameCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/nickCheck");

        request.setParameter("nick", alreadyJoinedClient.getCnick());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("not_usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("일반 회원의 핸드폰 번호 검사 시 중복된 핸드폰 번호가 없다면 'usable' 를 리턴한다.")
    public void whenNonDuplicateClientUserPhoneCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/phoneCheck_client");

        request.setParameter("cphone", newClient.getCphone());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("일반 회원의 핸드폰 번호 검사 시 중복된 핸드폰 번호가 있다면 'not_usable' 를 리턴한다.")
    public void whenDuplicateClientUserPhoneCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/phoneCheck_client");

        request.setParameter("cphone", alreadyJoinedClient.getCphone());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("not_usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("신규 판매자가 회원가입을 하면 회원가입이 완료된다")
    public void whenJoinNewVendorThenSuccess() throws Exception {

        //given
        request.setMethod("POST");
        request.setRequestURI("/vendor_join");

        request.setParameter("vid", newVendor.getVid());
        request.setParameter("vpassword", newVendor.getVpassword());
        request.setParameter("vname", newVendor.getVname());
        request.setParameter("vregisterNo", newVendor.getVregisterNo());
        request.setParameter("vphone", newVendor.getVphone());
        request.setParameter("vaddress", newVendor.getVaddress());
        request.setParameter("vinfo", newVendor.getVinfo());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("", response.getContentAsString()); // 기대하는 응답 내용 검증

        VendorVO joinedVendor = vendorService.listVendor(newVendor.getVid());
        assertEquals(newVendor.getVid(), joinedVendor.getVid());
        assertEquals(newVendor.getVpassword(), joinedVendor.getVpassword());
        assertEquals(newVendor.getVname(), joinedVendor.getVname());
        assertEquals(newVendor.getVregisterNo(), joinedVendor.getVregisterNo());
        assertEquals(newVendor.getVphone(), joinedVendor.getVphone());
        assertEquals(newVendor.getVaddress(), joinedVendor.getVaddress());
        assertEquals(0, joinedVendor.getVreport());
        assertEquals("N", joinedVendor.getVdelete());
        assertEquals("?", joinedVendor.getVgrade());
        assertEquals(0, joinedVendor.getEnable());

        // 현재는 auth를 가져오는 service가 없어 임시로 mapper 사용
        MemberVO testId = vendorMapper.read(newVendor.getVid());
        assertEquals(1, testId.getVendorAuthList().size());
        assertEquals("ROLE_VENDOR", testId.getVendorAuthList().get(0).getAuthority());

    }

    @Test
    @DisplayName("판매자의 ID 검사 시 중복된 ID가 없다면 'usable' 를 리턴한다.")
    public void whenNonDuplicateVendorIdCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/vendoridCheck");

        request.setParameter("vid", newVendor.getVid());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("판매자의 ID 검사 시 중복된 ID가 있다면 'not_usable' 를 리턴한다.")
    public void whenDuplicateVendorIdCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/vendoridCheck");

        request.setParameter("vid", alreadyJoinedVendor.getVid());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("not_usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("판매자의 상호 검사 시 중복된 상호가 없다면 'usable' 를 리턴한다.")
    public void whenNonDuplicateVendorNameCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/vendorName");

        request.setParameter("vname", newVendor.getVname());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("판매자의 상호 검사 시 중복된 상호가 있다면 'not_usable' 를 리턴한다.")
    public void whenDuplicateVendorNameCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/vendorName");

        request.setParameter("vname", alreadyJoinedVendor.getVname());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("not_usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("판매자의 사업자번호 검사 시 중복된 사업자번호가 없다면 'usable' 를 리턴한다.")
    public void whenNonDuplicateVendorRegisterNoCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/vendorNoCheck");

        request.setParameter("vregisterNo", newVendor.getVregisterNo());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("판매자의 사업자번호 검사 시 중복된 사업자번호가 있다면 'not_usable' 를 리턴한다.")
    public void whenDuplicateVendorRegisterNoCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/vendorNoCheck");

        request.setParameter("vregisterNo", alreadyJoinedVendor.getVregisterNo());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("not_usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("판매자의 핸드폰 번호 검사 시 중복된 핸드폰 번호가 없다면 'usable' 를 리턴한다.")
    public void whenNonDuplicateVendorPhoneNumberCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/phoneCheck_vendor");

        request.setParameter("vphone", newVendor.getVphone());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }

    @Test
    @DisplayName("판매자의 핸드폰 번호 검사 시 중복된 핸드폰 번호가 있다면 'not_usable' 를 리턴한다.")
    public void whenDuplicateVendorPhoneNumberCheckThenSuccess() throws Exception {

        //given
        request.setMethod("GET");
        request.setRequestURI("/phoneCheck_vendor");

        request.setParameter("vphone", alreadyJoinedVendor.getVphone());

        //when
        dispatcherServlet.service(request, response);

        //then
        assertEquals(HttpStatus.OK.value(), response.getStatus());
        assertEquals("not_usable", response.getContentAsString()); // 기대하는 응답 내용 검증
    }
}