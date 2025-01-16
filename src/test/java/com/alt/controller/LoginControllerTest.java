package com.alt.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.alt.domain.ClientVO;
import com.alt.domain.MemberVO;
import com.alt.mapper.ClientMapper;
import com.alt.service.ClientServiceImpl;
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

    private DispatcherServlet dispatcherServlet;
    private MockHttpServletRequest request;
    private MockHttpServletResponse response;

    private ClientVO newClient;

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

}