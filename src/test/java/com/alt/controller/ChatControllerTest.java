package com.alt.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrlPattern;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.xpath;

import com.alt.domain.ChatMsgVO;
import com.alt.domain.ClientVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.VendorVO;
import com.alt.service.ChatService;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathFactory;
import lombok.Setter;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;

@ExtendWith(SpringExtension.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/security-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Transactional
public class ChatControllerTest {

    @Autowired
    private WebApplicationContext webApplicationContext;

    @Setter(onMethod_ = {@Autowired})
    private ChatService chatService;

    private static MockMvc mockMvc;

    @Setter(onMethod_ = @Autowired)
    private ObjectMapper objectMapper;

    private static final ClientVO TEST_CLIENT = new ClientVO();
    private static final VendorVO TEST_VENDOR = new VendorVO();
    private SaleBoardVO newSaleBoard;

    @BeforeAll
    public static void createUser() throws Exception {

        TEST_CLIENT.setCid("testId");
        TEST_CLIENT.setCpassword("testPassword");
        TEST_CLIENT.setCname("testName");
        TEST_CLIENT.setCnick("testNickName");
        TEST_CLIENT.setCphone("010-1234-1234");
        TEST_CLIENT.setCaddress("서울시 강남구");

        TEST_VENDOR.setVid("testId");
        TEST_VENDOR.setVpassword("testPassword");
        TEST_VENDOR.setVname("testName");
        TEST_VENDOR.setVregisterNo("123-12-121212");
        TEST_VENDOR.setVphone("010-1234-1234");
        TEST_VENDOR.setVaddress("서울시 강남구");
        TEST_VENDOR.setVinfo("사과 가게");
    }

    @BeforeEach
    public void createNewSaleBoard() throws Exception {
        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }

    @Test
    @DisplayName("채팅방 개설을 요청하면 채팅방을 개설하고 리다이렉트 url를 리턴한다.")
    @WithMockUser(
        username = "testId"
    )
    public void whenRequestChatRoomThenReturnRedirectUrl() throws Exception {

        // given
        Authentication mockAuth = Mockito.mock(Authentication.class);
        UserDetails mockUserDetails = Mockito.mock(UserDetails.class);
        Mockito.when(mockAuth.getPrincipal()).thenReturn(mockUserDetails);
        Mockito.when(mockUserDetails.getUsername()).thenReturn("testUser");

        // when
        // then
        MvcResult mvcResult = mockMvc.perform(get("/chat")
                .param("vid", "testVid") // 요청 파라미터
                .principal(mockAuth)) // 모의 Principal 객체
            .andExpect(status().is3xxRedirection()) // 리다이렉트 예상
            .andExpect(redirectedUrlPattern("/moveChating?roomno=*")) // 리다이렉트 URL 확인
            .andReturn();

    }

    @Test
    @DisplayName("채팅 방 목록을 요청하면 채팅방 목록를 리턴한다.")
    @WithMockUser(
        username = "testId",
        authorities = {"ROLE_CLIENT"}
    )
    public void whenGetChatRoomListThenReturnChatRoomNumber() throws Exception {
        // given
        Authentication mockAuth = Mockito.mock(Authentication.class);
        UserDetails mockUserDetails = Mockito.mock(UserDetails.class);
        Mockito.when(mockAuth.getPrincipal()).thenReturn(mockUserDetails);
        Mockito.when(mockUserDetails.getUsername()).thenReturn("testUser");

        mockMvc.perform(get("/chat")
                .param("vid", "testVid") // 요청 파라미터
                .principal(mockAuth)) // 모의 Principal 객체
            .andExpect(status().is3xxRedirection()) // 리다이렉트 예상
            .andExpect(redirectedUrlPattern("/moveChating?roomno=*")) // 리다이렉트 URL 확인
            .andReturn();

        // when
        // then
        mockMvc.perform(get("/getRoom")
                .principal(mockAuth))
            .andExpect(status().isOk())
            .andExpect(xpath("/List/item[1]/roomno").exists())
            .andExpect(xpath("/List/item[1]/cid").string("testUser"))
            .andExpect(xpath("/List/item[1]/vid").string("testVid"))
            .andReturn();

    }

    @Test
    @DisplayName("채팅 방으로 이동하면 메시지 목록을 리턴한다.")
    @WithMockUser(
        username = "testId",
        authorities = {"ROLE_CLIENT"}
    )
    public void whenMoveChatRoomThenReturnChatMessage() throws Exception {
        // given
        Authentication mockAuth = Mockito.mock(Authentication.class);
        UserDetails mockUserDetails = Mockito.mock(UserDetails.class);
        Mockito.when(mockAuth.getPrincipal()).thenReturn(mockUserDetails);
        Mockito.when(mockUserDetails.getUsername()).thenReturn(TEST_CLIENT.getCid());

        mockMvc.perform(get("/chat")
                .param("vid", TEST_VENDOR.getVid()) // 요청 파라미터
                .principal(mockAuth)) // 모의 Principal 객체
            .andExpect(status().is3xxRedirection()) // 리다이렉트 예상
            .andExpect(redirectedUrlPattern("/moveChating?roomno=*")) // 리다이렉트 URL 확인
            .andReturn();

        MvcResult getRoomResult = mockMvc.perform(get("/getRoom")
                .principal(mockAuth))
            .andExpect(status().isOk())
            .andExpect(xpath("/List/item[1]/roomno").exists())
            .andExpect(xpath("/List/item[1]/cid").string(TEST_CLIENT.getCid()))
            .andExpect(xpath("/List/item[1]/vid").string(TEST_VENDOR.getVid()))
            .andReturn();

        // 응답 본문을 XML로 파싱하여 roomno 추출
        String responseContent = getRoomResult.getResponse().getContentAsString();

        // XML 파싱
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        InputStream inputStream = new ByteArrayInputStream(responseContent.getBytes());
        Document document = builder.parse(inputStream);

        // XPath로 roomno 값 추출
        XPathFactory xPathFactory = XPathFactory.newInstance();
        XPath xPath = xPathFactory.newXPath();
        String roomno = xPath.evaluate("/List/item[1]/roomno", document);

        ChatMsgVO chatMsgVO1 = new ChatMsgVO();
        chatMsgVO1.setRoomno(roomno);
        chatMsgVO1.setId(TEST_CLIENT.getCid());
        chatMsgVO1.setMsg("안녕하세요.");
        chatService.insertMsg(chatMsgVO1);

        // order by 시간으로 되어있어 milliseconds 단위가 같은 경우가 있어 추가
        Thread.sleep(10);

        ChatMsgVO chatMsgVO2 = new ChatMsgVO();
        chatMsgVO2.setRoomno(roomno);
        chatMsgVO2.setId(TEST_VENDOR.getVid());
        chatMsgVO2.setMsg("안녕하세요. 가게 입니다.");
        chatService.insertMsg(chatMsgVO2);

        String otherId = TEST_VENDOR.getVid();

        // when
        // then
        MvcResult mvcResult = mockMvc.perform(get("/moveChating")
                .param("roomno", roomno)
                .param("ide", otherId)
                .principal(mockAuth))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("roomno"))
            .andExpect(model().attributeExists("msgList"))
            .andExpect(model().attributeExists("ide"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        String getRoomno = (String) model.get("roomno");

        assertEquals(roomno, getRoomno);

        List<ChatMsgVO> getMsgList = (List<ChatMsgVO>) model.get("msgList");
        assertEquals(2, getMsgList.size());
        assertEquals(chatMsgVO1.getRoomno(), getMsgList.get(0).getRoomno());
        assertEquals(chatMsgVO1.getId(), getMsgList.get(0).getId());
        assertEquals(chatMsgVO1.getMsg(), getMsgList.get(0).getMsg());
        assertEquals(chatMsgVO2.getRoomno(), getMsgList.get(1).getRoomno());
        assertEquals(chatMsgVO2.getId(), getMsgList.get(1).getId());
        assertEquals(chatMsgVO2.getMsg(), getMsgList.get(1).getMsg());

    }

}