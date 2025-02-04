package com.alt.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import com.alt.domain.ClientVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.SaleImgVO;
import com.alt.domain.SaleThumbImgVO;
import com.alt.domain.VendorVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import lombok.Setter;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
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

@ExtendWith(SpringExtension.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/security-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Transactional
public class HomeControllerTest {
    @Autowired
    private WebApplicationContext webApplicationContext;

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
    @WithMockUser(
        username = "testVendor",
        authorities = {"ROLE_VENDOR"}
    )
    public void createDefaultInfo() throws Exception {

        mockMvc = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();

        // Mock Principal
        Principal mockPrincipal = Mockito.mock(Principal.class);
        Mockito.when(mockPrincipal.getName()).thenReturn("testVendor");

        SaleBoardVO saleBoardVO = makeNewSaleBoard();

        MvcResult result = mockMvc.perform(post("/board/saleRegister")
                .param("vid", saleBoardVO.getVid())
                .param("pcode", String.valueOf(saleBoardVO.getPcode()))
                .param("stitle", saleBoardVO.getStitle())
                .param("sinfo", saleBoardVO.getSinfo())
                .param("sprice", String.valueOf(saleBoardVO.getSprice()))
                .param("scount", String.valueOf(saleBoardVO.getScount()))
                .param("samount", String.valueOf(saleBoardVO.getSamount()))
                .param("thumbImg.stuuid", saleBoardVO.getThumbImg().getStuuid())
                .param("thumbImg.stfileName", saleBoardVO.getThumbImg().getStfileName())
                .param("thumbImg.stuploadPath", saleBoardVO.getThumbImg().getStuploadPath())
                .param("attachList[0].suuid", saleBoardVO.getAttachList().get(0).getSuuid())
                .param("attachList[0].sfileName", saleBoardVO.getAttachList().get(0).getSfileName())
                .param("attachList[0].suploadPath", saleBoardVO.getAttachList().get(0).getSuploadPath())
                .param("attachList[1].suuid", saleBoardVO.getAttachList().get(1).getSuuid())
                .param("attachList[1].sfileName", saleBoardVO.getAttachList().get(1).getSfileName())
                .param("attachList[1].suploadPath", saleBoardVO.getAttachList().get(1).getSuploadPath())
                .principal(mockPrincipal))
            .andReturn();

        int sno = (int) result.getFlashMap().get("result");

        newSaleBoard = saleBoardVO;
        newSaleBoard.setSno(sno);
        newSaleBoard.getThumbImg().setSno(sno);
        newSaleBoard.getAttachList().get(0).setSno(sno);
        newSaleBoard.getAttachList().get(1).setSno(sno);

        mockMvc.perform(post("/client_join")
                .param("cid", TEST_CLIENT.getCid())
                .param("cnick", TEST_CLIENT.getCnick())
                .param("cpassword", TEST_CLIENT.getCpassword())
                .param("cname", TEST_CLIENT.getCname())
                .param("cphone", TEST_CLIENT.getCphone())
                .param("caddress", TEST_CLIENT.getCaddress()))
            .andReturn();
    }

    private SaleBoardVO makeNewSaleBoard() {
        SaleBoardVO saleBoardVO = new SaleBoardVO();
        saleBoardVO.setVid("testVendor");
        saleBoardVO.setPcode(1);
        saleBoardVO.setStitle("테스트사과 팔아요");
        saleBoardVO.setSinfo("맛있는 사과 입니다.");
        saleBoardVO.setSprice(1000);
        saleBoardVO.setScount(0);
        saleBoardVO.setSamount(10);
        saleBoardVO.setSdelete("N");

        SaleThumbImgVO saleThumbImgVO = new SaleThumbImgVO();
        saleThumbImgVO.setStuuid(UUID.randomUUID().toString());
        saleThumbImgVO.setStfileName("testFileName1");
        saleThumbImgVO.setStuploadPath("uploadPath1");
        saleBoardVO.setThumbImg(saleThumbImgVO);

        SaleImgVO saleImgVO1 = new SaleImgVO();
        saleImgVO1.setSuuid(UUID.randomUUID().toString());
        saleImgVO1.setSfileName("testFileName1");
        saleImgVO1.setSuploadPath("uploadPath1");

        SaleImgVO saleImgVO2 = new SaleImgVO();
        saleImgVO2.setSuuid(UUID.randomUUID().toString());
        saleImgVO2.setSfileName("testFileName2");
        saleImgVO2.setSuploadPath("uploadPath2");

        List<SaleImgVO> saleImgVOList = new ArrayList<>();
        saleImgVOList.add(saleImgVO1);
        saleImgVOList.add(saleImgVO2);
        saleBoardVO.setAttachList(saleImgVOList);

        return saleBoardVO;
    }

    @Test
    @DisplayName("Client 회원 탈퇴 페이지를 요청하면 페이지를 리턴한다.")
    public void whenRequestClientDeletePageThenSuccess() throws Exception {

        mockMvc.perform(get("/mypage_delete"))
            .andExpect(status().isOk())
            .andExpect(view().name("client/mypage_delete"));

    }

    @Test
    @DisplayName("index 페이지를 요청하면 index 페이지와 데이터를 리턴한다.")
    public void whenRequestIndexPageThenSuccess() throws Exception {



        mockMvc.perform(get("/mypage_delete"))
            .andExpect(status().isOk())
            .andExpect(view().name("client/mypage_delete"));

    }
}