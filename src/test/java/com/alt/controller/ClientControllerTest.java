package com.alt.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.flash;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.alt.domain.BasketVO;
import com.alt.domain.ClientVO;
import com.alt.domain.OrdVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.SaleImgVO;
import com.alt.domain.SaleThumbImgVO;
import com.alt.domain.VendorVO;
import com.alt.domain.ZimVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.math.BigDecimal;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
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

@ExtendWith(SpringExtension.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
    "file:src/main/webapp/WEB-INF/spring/security-context.xml",
    "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@Transactional
public class ClientControllerTest {

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
    @DisplayName("마이 페이지를 요청하면 데이터를 리턴한다.")
    public void whenGetMyPageThenSuccess() throws Exception {

        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_info")
                .param("cid", String.valueOf(TEST_CLIENT.getCid())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("client"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        ClientVO getClient = (ClientVO) model.get("client");

        assertEquals(TEST_CLIENT.getCid(), getClient.getCid());
        assertEquals(TEST_CLIENT.getCpassword(), getClient.getCpassword());
        assertEquals(TEST_CLIENT.getCname(), getClient.getCname());
        assertEquals(TEST_CLIENT.getCphone(), getClient.getCphone());
        assertEquals(TEST_CLIENT.getCaddress(), getClient.getCaddress());
        assertNotNull(getClient.getCjoinDate());
        assertEquals(0, getClient.getCreport());
        assertEquals("N", getClient.getCdelete());
        assertEquals("?", getClient.getCgrade());
        assertEquals("0", getClient.getEnable());
    }

    @Test
    @DisplayName("마이 페이지의 수정 페이지를 요청하면 데이터를 리턴한다.")
    public void whenGetUpdateMyPageThenSuccess() throws Exception {

        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_update")
                .param("cid", String.valueOf(TEST_CLIENT.getCid())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("client"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        ClientVO getClient = (ClientVO) model.get("client");

        assertEquals(TEST_CLIENT.getCid(), getClient.getCid());
        assertEquals(TEST_CLIENT.getCpassword(), getClient.getCpassword());
        assertEquals(TEST_CLIENT.getCname(), getClient.getCname());
        assertEquals(TEST_CLIENT.getCphone(), getClient.getCphone());
        assertEquals(TEST_CLIENT.getCaddress(), getClient.getCaddress());
        assertNotNull(getClient.getCjoinDate());
        assertEquals(0, getClient.getCreport());
        assertEquals("N", getClient.getCdelete());
        assertEquals("?", getClient.getCgrade());
        assertEquals("0", getClient.getEnable());
    }

    @Test
    @DisplayName("마이 페이지의 비밀번호 변경 페이지를 요청하면 데이터를 리턴한다.")
    public void whenGetUpdatePasswordMyPageThenSuccess() throws Exception {

        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_update_password")
                .param("cid", String.valueOf(TEST_CLIENT.getCid())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("client"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        ClientVO getClient = (ClientVO) model.get("client");

        assertEquals(TEST_CLIENT.getCid(), getClient.getCid());
        assertEquals(TEST_CLIENT.getCpassword(), getClient.getCpassword());
        assertEquals(TEST_CLIENT.getCname(), getClient.getCname());
        assertEquals(TEST_CLIENT.getCphone(), getClient.getCphone());
        assertEquals(TEST_CLIENT.getCaddress(), getClient.getCaddress());
        assertNotNull(getClient.getCjoinDate());
        assertEquals(0, getClient.getCreport());
        assertEquals("N", getClient.getCdelete());
        assertEquals("?", getClient.getCgrade());
        assertEquals("0", getClient.getEnable());
    }

    @Test
    @DisplayName("내 정보를 수정하면 수정된 데이터를 리턴한다.")
    public void whenUpdateMyInfoThenSuccess() throws Exception {

        // given
        ClientVO updateClientVo = TEST_CLIENT;
        updateClientVo.setCpassword("modifyPass");
        updateClientVo.setCname("modifyName");
        updateClientVo.setCnick("modifyNickname");
        updateClientVo.setCphone("010-6549-7894");
        updateClientVo.setCaddress("수정 주소");

        // when
        // then
        mockMvc.perform(post("/client/modify")
                .param("cid", String.valueOf(updateClientVo.getCid()))
                .param("cpassword", String.valueOf(updateClientVo.getCpassword()))
                .param("cname", String.valueOf(updateClientVo.getCname()))
                .param("cnick", String.valueOf(updateClientVo.getCnick()))
                .param("cphone", String.valueOf(updateClientVo.getCphone()))
                .param("caddress", String.valueOf(updateClientVo.getCaddress()))
            )
            .andExpect(status().is3xxRedirection())
            .andExpect(flash().attributeExists("result"))
            .andReturn();

        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_info")
                .param("cid", String.valueOf(updateClientVo.getCid())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("client"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        ClientVO getClient = (ClientVO) model.get("client");

        assertEquals(updateClientVo.getCid(), getClient.getCid());
        assertEquals(updateClientVo.getCpassword(), getClient.getCpassword());
        assertEquals(updateClientVo.getCname(), getClient.getCname());
        assertEquals(updateClientVo.getCphone(), getClient.getCphone());
        assertEquals(updateClientVo.getCaddress(), getClient.getCaddress());
        assertNotNull(getClient.getCjoinDate());
        assertEquals(0, getClient.getCreport());
        assertEquals("N", getClient.getCdelete());
        assertEquals("?", getClient.getCgrade());
        assertEquals("0", getClient.getEnable());
    }

    @Test
    @DisplayName("비밀번호를 수정하면 수정된 데이터를 리턴한다.")
    @WithMockUser(
        username = "testId"
    )
    public void whenUpdatePasswordThenSuccess() throws Exception {

        // given
        ClientVO updateClientVo = TEST_CLIENT;
        updateClientVo.setCpassword("modifyPass");

        // when
        // then
        mockMvc.perform(post("/client/modifyPassword")
                .param("cid", String.valueOf(updateClientVo.getCid()))
                .param("cpassword", String.valueOf(updateClientVo.getCpassword()))
            )
            .andExpect(status().is3xxRedirection())
            .andExpect(flash().attributeExists("result"))
            .andReturn();

        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_info")
                .param("cid", String.valueOf(updateClientVo.getCid())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("client"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        ClientVO getClient = (ClientVO) model.get("client");

        assertEquals(updateClientVo.getCid(), getClient.getCid());
        assertEquals(updateClientVo.getCpassword(), getClient.getCpassword());
    }

    @Test
    @DisplayName("회원 탈퇴를 하면 cdelete가 'Y'로 리턴한다.")
    @WithMockUser(
        username = "testId"
    )
    public void whenDeleteClientThenSuccess() throws Exception {

        // given
        ClientVO updateClientVo = TEST_CLIENT;

        // when
        // then
        mockMvc.perform(post("/client/delete")
                .param("cid", String.valueOf(updateClientVo.getCid()))
                .param("cpassword", String.valueOf(updateClientVo.getCpassword()))
            )
            .andExpect(status().is3xxRedirection())
//            .andExpect(flash().attributeExists("result"))
            .andReturn();

        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_info")
                .param("cid", String.valueOf(updateClientVo.getCid())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("client"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        ClientVO getClient = (ClientVO) model.get("client");

        assertEquals(updateClientVo.getCid(), getClient.getCid());
        assertEquals("Y", getClient.getCdelete());
    }

    @Test
    @DisplayName("내 찜리스트를 요청하면 찜 리스트가 리턴한다.")
    @WithMockUser(
        username = "testId",
        authorities = {"ROLE_CLIENT"}
    )
    public void whenGetZimListThenSuccess() throws Exception {

        // given
        ZimVO zimVO = new ZimVO();
        zimVO.setCid(TEST_CLIENT.getCid());
        zimVO.setSno(newSaleBoard.getSno());

        mockMvc.perform(post("/board/doZim")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(zimVO)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("1"))
            .andReturn();

        // when
        // then
        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_zimlist")
                .param("cid", String.valueOf(TEST_CLIENT.getCid()))
            )
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("zimlist"))
            .andExpect(model().attributeExists("thumbImgSnoList"))
            .andDo(print())
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        List<ZimVO> getZimList = (List<ZimVO>) model.get("zimlist");

        assertNotNull(getZimList.get(0).getZimCode());
        assertEquals(TEST_CLIENT.getCid(), getZimList.get(0).getCid());
        assertEquals(zimVO.getSno(), getZimList.get(0).getSno());
    }

    @Test
    @DisplayName("내 주문 리스트를 요청하면 주문 리스트가 리턴한다.")
    @WithMockUser(
        username = "testId",
        authorities = {"ROLE_CLIENT"}
    )
    public void whenGetOrderListThenSuccess() throws Exception {

        //given
        BasketVO basketVO = new BasketVO();
        basketVO.setSno(newSaleBoard.getSno());
        basketVO.setBamount(10);
        basketVO.setBprice(10000);
        basketVO.setCid(TEST_CLIENT.getCid());

        mockMvc.perform(post("/board/basket")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(basketVO)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("success"))
            .andReturn();

        OrdVO ordVO = new OrdVO();
        ordVO.setCid(TEST_CLIENT.getCid());
        ordVO.setOaddress("경기도 부천시");
        ordVO.setOphone("010-1234-7890");


        mockMvc.perform(post("/board/salePay")
                .param("cid", TEST_CLIENT.getCid())
                .param("oaddress", ordVO.getOaddress())
                .param("ophone", ordVO.getOphone()))
            .andExpect(status().isOk())
            .andReturn();

        // when
        // then
        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_orderlist")
                .param("cid", String.valueOf(TEST_CLIENT.getCid()))
            )
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("ordlist"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        List<OrdVO> getOrdList = (List<OrdVO>) model.get("ordlist");

        assertNotNull(getOrdList.get(0).getOcode());
        assertEquals(TEST_CLIENT.getCid(), getOrdList.get(0).getCid());
        assertEquals(ordVO.getOaddress(), getOrdList.get(0).getOaddress());
        assertEquals(ordVO.getOphone(), getOrdList.get(0).getOphone());
        assertNotNull(getOrdList.get(0).getOphone());
        assertEquals("N", getOrdList.get(0).getOpay());
    }

    @Test
    @DisplayName("내 주문 상세를 요청하면 주문 상세가 리턴한다.")
    @WithMockUser(
        username = "testId",
        authorities = {"ROLE_CLIENT"}
    )
    public void whenGetOrderDetailThenSuccess() throws Exception {

        //given
        BasketVO basketVO = new BasketVO();
        basketVO.setSno(newSaleBoard.getSno());
        basketVO.setBamount(10);
        basketVO.setBprice(10000);
        basketVO.setCid(TEST_CLIENT.getCid());

        mockMvc.perform(post("/board/basket")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(basketVO)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("success"))
            .andReturn();

        OrdVO ordVO = new OrdVO();
        ordVO.setCid(TEST_CLIENT.getCid());
        ordVO.setOaddress("경기도 부천시");
        ordVO.setOphone("010-1234-7890");

        mockMvc.perform(post("/board/salePay")
                .param("cid", TEST_CLIENT.getCid())
                .param("oaddress", ordVO.getOaddress())
                .param("ophone", ordVO.getOphone()))
            .andExpect(status().isOk())
            .andReturn();

        MvcResult orderListResult = mockMvc.perform(get("/client/mypage_orderlist")
                .param("cid", String.valueOf(TEST_CLIENT.getCid()))
            )
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("ordlist"))
            .andReturn();

        List<OrdVO> getOrdList = (List<OrdVO>) orderListResult.getModelAndView().getModel().get("ordlist");

        String ocode = getOrdList.get(0).getOcode();

        // when
        // then
        MvcResult mvcResult = mockMvc.perform(get("/client/mypage_ordercode")
                .param("ocode", ocode)
            )
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("snoList"))
            .andExpect(model().attributeExists("ocode"))
            .andExpect(model().attributeExists("ordlistproduct"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        List<String> getSnoList = (List<String>) model.get("snoList");

        assertEquals(basketVO.getSno(), Integer.parseInt(getSnoList.get(0)));

        List<HashMap<String, Object>> getOrderList = (List<HashMap<String, Object>>) model.get("ordlistproduct");
        HashMap<String, Object> stringStringHashMap = getOrderList.get(0);
        assertNotNull(stringStringHashMap.get("ORDPRODUCTCODE"));
        assertEquals(basketVO.getBamount(), ((BigDecimal) stringStringHashMap.get("OAMOUNT")).intValue());
        assertEquals(basketVO.getBprice(), ((BigDecimal) stringStringHashMap.get("OPRICE")).intValue());
        assertEquals("N", stringStringHashMap.get("OPPAY"));


    }
}