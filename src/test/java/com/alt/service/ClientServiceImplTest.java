package com.alt.service;

import static org.junit.jupiter.api.Assertions.assertEquals;

import com.alt.domain.ClientVO;
import lombok.Setter;
import org.junit.jupiter.api.BeforeEach;
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
    private ClientServiceImpl clientService;

    @Test
    public void testRegister() {

        //given
        ClientVO newClient;
        newClient = new ClientVO();
        newClient.setCid("testId");
        newClient.setCpassword("testPassword");
        newClient.setCname("testName");
        newClient.setCnick("testNickName");
        newClient.setCphone("010-1234-1234");
        newClient.setCaddress("서울시 강남구");

        //when
        String register = clientService.register(newClient);



    }
}