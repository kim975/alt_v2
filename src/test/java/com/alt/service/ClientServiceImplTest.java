package com.alt.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientVO;
import com.alt.domain.MemberVO;
import com.alt.mapper.ClientMapper;
import java.util.stream.Stream;
import lombok.Setter;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import org.junit.jupiter.params.provider.ValueSource;
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

    private ClientVO newClient;

    @BeforeEach
    public void createNewClient() throws Exception {
        newClient = new ClientVO();
        newClient.setCid("testId");
        newClient.setCpassword("testPassword");
        newClient.setCname("testName");
        newClient.setCnick("testNickName");
        newClient.setCphone("010-1234-1234");
        newClient.setCaddress("서울시 강남구");
    }

    @Test
    @DisplayName("신규 사용자가 회원가입을 하면 회원가입이 완료된다")
    public void whenJoinNewClientThenSuccess() {

        //given
        ClientVO newClient = this.newClient;

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

    @ParameterizedTest(name = "[{index}] {0}")
    @DisplayName("회원 가입 시 ID format이 다르면 에러가 발생한다.")
    @MethodSource("provideInvalidIdForJoin")
    public void whenInputInvalidFormatIdThenException(String message, String id) {
        //given
        ClientVO invalidIdClient = newClient;
        invalidIdClient.setCid(id);

        //when
        //then
        assertThrows(IllegalArgumentException.class, () ->
            clientService.register(invalidIdClient)
        );
    }
    @ParameterizedTest(name = "[{index}] {0}")
    @DisplayName("회원 가입 시 핸드폰 번호 format이 다르면 에러가 발생한다.")
    @MethodSource("provideInvalidPhoneNumberForJoin")
    public void whenInputInvalidFormatPhoneNumberThenException(String message, String phoneNumber) {
        //given
        ClientVO invalidPhoneClient = newClient;
        invalidPhoneClient.setCphone(phoneNumber);

        //when
        //then
        assertThrows(IllegalArgumentException.class, () ->
            clientService.register(invalidPhoneClient)
        );
    }

    @ParameterizedTest(name = "[{index}] {0}")
    @DisplayName("회원 가입 시 닉네암 format이 다르면 에러가 발생한다.")
    @MethodSource("provideInvalidNicknameForJoin")
    public void whenInputInvalidFormatNicknameThenException(String message, String nickname) {

        //given
        ClientVO invalidNicknameClient = newClient;
        invalidNicknameClient.setCnick(nickname);

        //when
        //then
        assertThrows(IllegalArgumentException.class, () ->
            clientService.register(invalidNicknameClient)
        );

    }

    public static Stream<Arguments> provideInvalidIdForJoin() {
        return Stream.of(
            Arguments.of("빈 값의 ID", ""),
            Arguments.of("4자리 이하의 ID", "1234"),
            Arguments.of("31자리 이상의 ID", "1234567890123456789012345678901")
        );
    }
    public static Stream<Arguments> provideInvalidPhoneNumberForJoin() {
        return Stream.of(
            Arguments.of("빈 값의 핸드폰 번호", ""),
            Arguments.of("'-'제외 하고 10~11자리가 아닌 핸드폰 번호", "123456789"),
            Arguments.of("'-'가 없는 핸드폰 번호", "01012341234")
        );
    }

    private static Stream<Arguments> provideInvalidNicknameForJoin() {
        return Stream.of(
            Arguments.of("빈 값의 닉네임", ""),
            Arguments.of("1자리 이하의 닉네임", "1"),
            Arguments.of("16자리 이상의 닉네임", "1234567890123456")
        );
    }
}