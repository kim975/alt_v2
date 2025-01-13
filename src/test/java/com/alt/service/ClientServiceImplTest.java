package com.alt.service;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.domain.MemberVO;
import com.alt.mapper.ClientMapper;
import lombok.Setter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
    "file:src/test/webapp/WEB-INF/spring/root-context.xml",
    "file:src/test/webapp/WEB-INF/spring/security-context.xml",
    "file:src/test/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Transactional
public class ClientServiceImplTest {

    @Setter(onMethod_ = @Autowired)
    private ClientMapper clientMapper;

    @Setter(onMethod_ = @Autowired)
    private ClientServiceImpl clientService;

    @Test
    @DisplayName("신규 사용자가 회원가입을 하면 회원가입이 완료된다")
    public void whenJoinNewClientThenSuccess() {

        //given
        ClientVO newClient = new ClientVO();
        newClient.setCid("testId");
        newClient.setCpassword("testPassword");
        newClient.setCname("testName");
        newClient.setCnick("testNickName");
        newClient.setCphone("010-1234-1234");
        newClient.setCaddress("서울시 강남구");

        ClientAuthVO newClientAuth = new ClientAuthVO();
        newClientAuth.setCid("testId");
        newClientAuth.setAuthority("ROLE_CLIENT");

        //when
        String registeredResult = clientService.register(newClient);

        //then
        ClientVO joinedClient = clientService.listClient("testId");
        assertEquals("register", registeredResult);
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