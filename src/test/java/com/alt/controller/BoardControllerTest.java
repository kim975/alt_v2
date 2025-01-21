package com.alt.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.flash;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.xpath;

import com.alt.domain.BasketVO;
import com.alt.domain.ClientVO;
import com.alt.domain.MemberVO;
import com.alt.domain.OrdVO;
import com.alt.domain.PageDTO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.SaleImgVO;
import com.alt.domain.SaleThumbImgVO;
import com.alt.domain.VendorVO;
import com.alt.domain.ZimVO;
import com.alt.security.domain.CustomClientUser;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.math.BigDecimal;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import lombok.Setter;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
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
public class BoardControllerTest {

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
    public void createNewSaleBoard() throws Exception {

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

    private SaleBoardVO modifyNewSaleBoard(SaleBoardVO saleBoardVO) {
        saleBoardVO.setPcode(11);
        saleBoardVO.setStitle("수정 테스트사과 팔아요");
        saleBoardVO.setSinfo("수정 맛있는 사과 입니다.");
        saleBoardVO.setSprice(9999);
        saleBoardVO.setSamount(999);

        SaleThumbImgVO saleThumbImgVO = new SaleThumbImgVO();
        saleThumbImgVO.setStuuid(UUID.randomUUID().toString());
        saleThumbImgVO.setStfileName("수정 testFileName1");
        saleThumbImgVO.setStuploadPath("수정 uploadPath1");
        saleBoardVO.setThumbImg(saleThumbImgVO);

        SaleImgVO saleImgVO1 = new SaleImgVO();
        saleImgVO1.setSuuid(UUID.randomUUID().toString());
        saleImgVO1.setSfileName("수정 testFileName1");
        saleImgVO1.setSuploadPath("수정 uploadPath1");

        SaleImgVO saleImgVO2 = new SaleImgVO();
        saleImgVO2.setSuuid(UUID.randomUUID().toString());
        saleImgVO2.setSfileName("수정 testFileName2");
        saleImgVO2.setSuploadPath("수정 uploadPath2");

        List<SaleImgVO> saleImgVOList = new ArrayList<>();
        saleImgVOList.add(saleImgVO1);
        saleImgVOList.add(saleImgVO2);
        saleBoardVO.setAttachList(saleImgVOList);

        return saleBoardVO;
    }

    @Test
    @DisplayName("판매 게시만 목록을 요청하면 데이터를 리턴한다.")
    public void whenGetSaleBoardListThenSuccess() throws Exception {

        MvcResult mvcResult = mockMvc.perform(get("/board/saleBoard")
                .param("keyword", "테스트사과"))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("saleBoardList"))
            .andExpect(model().attributeExists("pageMaker"))
            .andExpect(model().attributeExists("thumbImgSnoList"))
            .andExpect(model().attributeExists("star"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        List<SaleBoardVO> saleBoardList = (List<SaleBoardVO>) model.get("saleBoardList");

        assertEquals(newSaleBoard.getSno(), saleBoardList.get(0).getSno());
        assertEquals(newSaleBoard.getStitle(), saleBoardList.get(0).getStitle());
        assertEquals(newSaleBoard.getSinfo(), saleBoardList.get(0).getSinfo());
        assertEquals(newSaleBoard.getSprice(), saleBoardList.get(0).getSprice());

        List<Integer> thumbImgSnoList = (List<Integer>) model.get("thumbImgSnoList");
        assertEquals(newSaleBoard.getThumbImg().getSno(), thumbImgSnoList.get(0));

        List<HashMap<String, String>> star = (List<HashMap<String, String>>) model.get("star");
//        String sno = star.get(0).get("sno");
//        String rstar = star.get(0).get("rstar");
//        String cnt = star.get(0).get("cnt");

        // TODO 추후 테스트 데이터 추가
//        assertNotNull(sno);
//        assertNotNull(rstar);
//        assertNotNull(cnt);

    }

    @Test
    @DisplayName("판매 게시만 목록의 썸네일을 요청하면 데이터를 리턴한다.")
    public void whenGetSaleBoardThumbnailListThenSuccess() throws Exception {

        mockMvc.perform(get("/board/getThumbList")
                .contentType(MediaType.APPLICATION_JSON)
                .param("snoStr", "[" + newSaleBoard.getSno() + "]"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].sno").value(newSaleBoard.getThumbImg().getSno()))
            .andExpect(jsonPath("$[0].stuuid").value(newSaleBoard.getThumbImg().getStuuid()))
            .andExpect(jsonPath("$[0].stuploadPath").value(newSaleBoard.getThumbImg().getStuploadPath()))
            .andExpect(jsonPath("$[0].stfileName").value(newSaleBoard.getThumbImg().getStfileName()))
            .andReturn();

    }

    @Test
    @DisplayName("판매 게시만 상세 이미지를 요청하면 데이터를 리턴한다.")
    public void whenGetSaleBoardImageListThenSuccess() throws Exception {

        mockMvc.perform(get("/board/getImageList")
                .contentType(MediaType.APPLICATION_JSON)
                .param("sno", String.valueOf(newSaleBoard.getSno())))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].sno").value(newSaleBoard.getAttachList().get(0).getSno()))
            .andExpect(jsonPath("$[0].suuid").value(newSaleBoard.getAttachList().get(0).getSuuid()))
            .andExpect(jsonPath("$[0].suploadPath").value(newSaleBoard.getAttachList().get(0).getSuploadPath()))
            .andExpect(jsonPath("$[0].sfileName").value(newSaleBoard.getAttachList().get(0).getSfileName()))
            .andExpect(jsonPath("$[1].sno").value(newSaleBoard.getAttachList().get(1).getSno()))
            .andExpect(jsonPath("$[1].suuid").value(newSaleBoard.getAttachList().get(1).getSuuid()))
            .andExpect(jsonPath("$[1].suploadPath").value(newSaleBoard.getAttachList().get(1).getSuploadPath()))
            .andExpect(jsonPath("$[1].sfileName").value(newSaleBoard.getAttachList().get(1).getSfileName()))
            .andReturn();
    }

    @Test
    @DisplayName("판매 게시만 상세를 요청하면 데이터를 리턴한다.")
    public void whenGetSaleBoardDetailThenSuccess() throws Exception {

        MvcResult mvcResult = mockMvc.perform(get("/board/saleDetail")
                .contentType(MediaType.APPLICATION_JSON)
                .param("sno", String.valueOf(newSaleBoard.getSno())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("countRstar"))
            .andExpect(model().attributeExists("rnoList"))
            .andExpect(model().attributeExists("sale"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        SaleBoardVO saleBoardVO = (SaleBoardVO) model.get("sale");

        assertEquals(newSaleBoard.getSno(), saleBoardVO.getSno());
        assertEquals(newSaleBoard.getVid(), saleBoardVO.getVid());
        assertEquals(newSaleBoard.getPcode(), saleBoardVO.getPcode());
        assertEquals(newSaleBoard.getStitle(), saleBoardVO.getStitle());
        assertEquals(newSaleBoard.getSinfo(), saleBoardVO.getSinfo());
        assertNotNull(saleBoardVO.getSwriteDate());
        assertNotNull(saleBoardVO.getSupdateDate());
        assertEquals(newSaleBoard.getSprice(), saleBoardVO.getSprice());
        assertEquals(newSaleBoard.getSdelete(), saleBoardVO.getSdelete());
        assertEquals(newSaleBoard.getScount(), saleBoardVO.getScount());
        assertEquals(newSaleBoard.getSamount(), saleBoardVO.getSamount());
    }

    @Test
    @DisplayName("장바구니에 상품을 담으면 'success'를 리턴한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    public void whenPutProductInBasketThenSuccess() throws Exception {

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

        MvcResult basketListResult = mockMvc.perform(get("/board/basketList")
                .param("cid", TEST_CLIENT.getCid()))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("thumbImgSnoList"))
            .andExpect(model().attributeExists("totalPrice"))
            .andExpect(model().attributeExists("basketList"))
            .andReturn();

        Map<String, Object> basketListModel = basketListResult.getModelAndView().getModel();
        List<HashMap<String, Object>> basketList = (List<HashMap<String, Object>>) basketListModel.get("basketList");
        HashMap<String, Object> basket = basketList.get(0);
        String bcode = (String) basket.get("BCODE");
        BigDecimal bamount = (BigDecimal) (basket.get("BAMOUNT"));
        BigDecimal bprice = (BigDecimal) basket.get("BPRICE");

        assertNotNull(bcode);
        assertEquals(TEST_CLIENT.getCid(), basket.get("CID"));
        assertNotNull(basket.get("BDATE"));
        assertEquals(basketVO.getBamount(), bamount.intValue());
        assertEquals(basketVO.getBprice(), bprice.intValue());

        List<Integer> basketListThumbImgSnoList = (List<Integer>) basketListModel.get("thumbImgSnoList");
        assertEquals(basketVO.getSno(), basketListThumbImgSnoList.get(0));

        int basketListTotalPrice = (int) basketListModel.get("totalPrice");
        assertEquals(basketVO.getBprice() * basketVO.getBamount(), basketListTotalPrice);

        mockMvc.perform(get("/board/basketTotalPrice")
                .param("cid", TEST_CLIENT.getCid())
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(xpath("/Integer").exists())
            .andExpect(xpath("/Integer").string(String.valueOf(basketVO.getBprice() * basketVO.getBamount())))
            .andReturn();

        mockMvc.perform(delete("/board/basket/{bcode}", bcode)
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("success"))
            .andReturn();

    }

    @Test
    @DisplayName("장바구니의 상품을 삭제 하면 'success'를 리턴한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    @Disabled
    public void whenDeleteProductBasketThenSuccess() throws Exception {

        mockMvc.perform(delete("/board/basket/{bcode}", "1")
                .contentType(MediaType.APPLICATION_JSON))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("success"))
            .andReturn();
    }

    @Test
    @DisplayName("장바구니 목록을 요청하면 목록를 리턴한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    @Disabled
    public void whenGetBasketListThenSuccess() throws Exception {

        mockMvc.perform(get("/board/basketList")
                .param("cid", "testId"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("success"))
            .andReturn();
    }

    @Test
    @DisplayName("장바구니 목록의 최종 가격을 요청하면 최종가격을 리턴한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    @Disabled
    public void whenGetBasketTotalPriceThenSuccess() throws Exception {

        mockMvc.perform(get("/board/basketTotalPrice")
                .param("cid", "testId"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("success"))
            .andReturn();
    }

    @Test
    @DisplayName("찜하기를 하면 성공한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    public void whenDoDibsProductThenSuccess() throws Exception {

        ZimVO zimVO = new ZimVO();
        zimVO.setCid(TEST_CLIENT.getCid());
        zimVO.setSno(newSaleBoard.getSno());

        mockMvc.perform(post("/board/doZim")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(zimVO)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("1"))
            .andReturn();

        mockMvc.perform(post("/board/doZim")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(zimVO)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("0"))
            .andReturn();
    }

    @Test
    @DisplayName("상품 판매 등록을 하면 성공한다.")
    @WithMockUser(
        username = "testVendor",
        authorities = {"ROLE_VENDOR"}
    )
    public void whenRegisterSaleProductThenSuccess() throws Exception {

        // Mock Principal
        Principal mockPrincipal = Mockito.mock(Principal.class);
        Mockito.when(mockPrincipal.getName()).thenReturn("testVendor");

        SaleBoardVO registerSaleBoardVO = makeNewSaleBoard();
        registerSaleBoardVO.getThumbImg().setStuuid(UUID.randomUUID().toString());
        registerSaleBoardVO.getAttachList().get(0).setSuuid(UUID.randomUUID().toString());
        registerSaleBoardVO.getAttachList().get(1).setSuuid(UUID.randomUUID().toString());

        MvcResult result = mockMvc.perform(post("/board/saleRegister")
                .param("vid", registerSaleBoardVO.getVid())
                .param("pcode", String.valueOf(registerSaleBoardVO.getPcode()))
                .param("stitle", registerSaleBoardVO.getStitle())
                .param("sinfo", registerSaleBoardVO.getSinfo())
                .param("sprice", String.valueOf(registerSaleBoardVO.getSprice()))
                .param("scount", String.valueOf(registerSaleBoardVO.getScount()))
                .param("samount", String.valueOf(registerSaleBoardVO.getSamount()))
                .param("thumbImg.stuuid", registerSaleBoardVO.getThumbImg().getStuuid())
                .param("thumbImg.stfileName", registerSaleBoardVO.getThumbImg().getStfileName())
                .param("thumbImg.stuploadPath", registerSaleBoardVO.getThumbImg().getStuploadPath())
                .param("attachList[0].suuid", registerSaleBoardVO.getAttachList().get(0).getSuuid())
                .param("attachList[0].sfileName", registerSaleBoardVO.getAttachList().get(0).getSfileName())
                .param("attachList[0].suploadPath", registerSaleBoardVO.getAttachList().get(0).getSuploadPath())
                .param("attachList[1].suuid", registerSaleBoardVO.getAttachList().get(1).getSuuid())
                .param("attachList[1].sfileName", registerSaleBoardVO.getAttachList().get(1).getSfileName())
                .param("attachList[1].suploadPath", registerSaleBoardVO.getAttachList().get(1).getSuploadPath())
                .principal(mockPrincipal))
            .andExpect(status().is3xxRedirection())
            .andExpect(flash().attributeExists("result"))
            .andReturn();

        //FlashMap 값 확인
        Map<String, ?> flashMap = result.getFlashMap();

        Integer registerSno = (Integer) flashMap.get("result");

        MvcResult mvcResult = mockMvc.perform(get("/board/saleDetail")
                .contentType(MediaType.APPLICATION_JSON)
                .param("sno", String.valueOf(registerSno)))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("countRstar"))
            .andExpect(model().attributeExists("rnoList"))
            .andExpect(model().attributeExists("sale"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        SaleBoardVO getSaleBoardVO = (SaleBoardVO) model.get("sale");

        assertEquals(registerSno, getSaleBoardVO.getSno());
        assertEquals(registerSaleBoardVO.getVid(), getSaleBoardVO.getVid());
        assertEquals(registerSaleBoardVO.getPcode(), getSaleBoardVO.getPcode());
        assertEquals(registerSaleBoardVO.getStitle(), getSaleBoardVO.getStitle());
        assertEquals(registerSaleBoardVO.getSinfo(), getSaleBoardVO.getSinfo());
        assertNotNull(getSaleBoardVO.getSwriteDate());
        assertNotNull(getSaleBoardVO.getSupdateDate());
        assertEquals(registerSaleBoardVO.getSprice(), getSaleBoardVO.getSprice());
        assertEquals(registerSaleBoardVO.getSdelete(), getSaleBoardVO.getSdelete());
        assertEquals(registerSaleBoardVO.getScount(), getSaleBoardVO.getScount());
        assertEquals(registerSaleBoardVO.getSamount(), getSaleBoardVO.getSamount());

        mockMvc.perform(get("/board/getThumbList")
                .contentType(MediaType.APPLICATION_JSON)
                .param("snoStr", "[" + registerSno + "]"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].sno").value(registerSno))
            .andExpect(jsonPath("$[0].stuuid").value(registerSaleBoardVO.getThumbImg().getStuuid()))
            .andExpect(jsonPath("$[0].stuploadPath").value(registerSaleBoardVO.getThumbImg().getStuploadPath()))
            .andExpect(jsonPath("$[0].stfileName").value(registerSaleBoardVO.getThumbImg().getStfileName()))
            .andReturn();

        mockMvc.perform(get("/board/getImageList")
                .contentType(MediaType.APPLICATION_JSON)
                .param("sno", String.valueOf(registerSno)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].sno").value(registerSno))
            .andExpect(jsonPath("$[0].suuid").value(registerSaleBoardVO.getAttachList().get(0).getSuuid()))
            .andExpect(jsonPath("$[0].suploadPath").value(registerSaleBoardVO.getAttachList().get(0).getSuploadPath()))
            .andExpect(jsonPath("$[0].sfileName").value(registerSaleBoardVO.getAttachList().get(0).getSfileName()))
            .andExpect(jsonPath("$[1].sno").value(registerSno))
            .andExpect(jsonPath("$[1].suuid").value(registerSaleBoardVO.getAttachList().get(1).getSuuid()))
            .andExpect(jsonPath("$[1].suploadPath").value(registerSaleBoardVO.getAttachList().get(1).getSuploadPath()))
            .andExpect(jsonPath("$[1].sfileName").value(registerSaleBoardVO.getAttachList().get(1).getSfileName()))
            .andReturn();

    }

    @Test
    @DisplayName("상품 판매 수정을 하면 성공한다.")
    @WithMockUser(
        username = "testVendor",
        authorities = {"ROLE_VENDOR"}
    )
    public void whenModifySaleProductThenSuccess() throws Exception {

        // Mock Principal
        Principal mockPrincipal = Mockito.mock(Principal.class);
        Mockito.when(mockPrincipal.getName()).thenReturn("testVendor");

        SaleBoardVO modifySaleBoardVO = modifyNewSaleBoard(newSaleBoard);
        modifySaleBoardVO.getThumbImg().setStuuid(UUID.randomUUID().toString());
        modifySaleBoardVO.getAttachList().get(0).setSuuid(UUID.randomUUID().toString());
        modifySaleBoardVO.getAttachList().get(1).setSuuid(UUID.randomUUID().toString());

        MvcResult result = mockMvc.perform(post("/board/saleRegister")
                .param("vid", modifySaleBoardVO.getVid())
                .param("pcode", String.valueOf(modifySaleBoardVO.getPcode()))
                .param("stitle", modifySaleBoardVO.getStitle())
                .param("sinfo", modifySaleBoardVO.getSinfo())
                .param("sprice", String.valueOf(modifySaleBoardVO.getSprice()))
                .param("scount", String.valueOf(modifySaleBoardVO.getScount()))
                .param("samount", String.valueOf(modifySaleBoardVO.getSamount()))
                .param("thumbImg.stuuid", modifySaleBoardVO.getThumbImg().getStuuid())
                .param("thumbImg.stfileName", modifySaleBoardVO.getThumbImg().getStfileName())
                .param("thumbImg.stuploadPath", modifySaleBoardVO.getThumbImg().getStuploadPath())
                .param("attachList[0].suuid", modifySaleBoardVO.getAttachList().get(0).getSuuid())
                .param("attachList[0].sfileName", modifySaleBoardVO.getAttachList().get(0).getSfileName())
                .param("attachList[0].suploadPath", modifySaleBoardVO.getAttachList().get(0).getSuploadPath())
                .param("attachList[1].suuid", modifySaleBoardVO.getAttachList().get(1).getSuuid())
                .param("attachList[1].sfileName", modifySaleBoardVO.getAttachList().get(1).getSfileName())
                .param("attachList[1].suploadPath", modifySaleBoardVO.getAttachList().get(1).getSuploadPath())
                .principal(mockPrincipal))
            .andExpect(status().is3xxRedirection())
            .andExpect(flash().attributeExists("result"))
            .andReturn();

        //FlashMap 값 확인
        Map<String, ?> flashMap = result.getFlashMap();

        Integer registerSno = (Integer) flashMap.get("result");

        MvcResult mvcResult = mockMvc.perform(get("/board/saleDetail")
                .contentType(MediaType.APPLICATION_JSON)
                .param("sno", String.valueOf(registerSno)))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("countRstar"))
            .andExpect(model().attributeExists("rnoList"))
            .andExpect(model().attributeExists("sale"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        SaleBoardVO getSaleBoardVO = (SaleBoardVO) model.get("sale");

        assertEquals(registerSno, getSaleBoardVO.getSno());
        assertEquals(modifySaleBoardVO.getPcode(), getSaleBoardVO.getPcode());
        assertEquals(modifySaleBoardVO.getStitle(), getSaleBoardVO.getStitle());
        assertEquals(modifySaleBoardVO.getSinfo(), getSaleBoardVO.getSinfo());
        assertNotNull(getSaleBoardVO.getSwriteDate());
        assertNotNull(getSaleBoardVO.getSupdateDate());
        assertEquals(modifySaleBoardVO.getSprice(), getSaleBoardVO.getSprice());
        assertEquals(modifySaleBoardVO.getSamount(), getSaleBoardVO.getSamount());

        mockMvc.perform(get("/board/getThumbList")
                .contentType(MediaType.APPLICATION_JSON)
                .param("snoStr", "[" + registerSno + "]"))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].sno").value(registerSno))
            .andExpect(jsonPath("$[0].stuuid").value(modifySaleBoardVO.getThumbImg().getStuuid()))
            .andExpect(jsonPath("$[0].stuploadPath").value(modifySaleBoardVO.getThumbImg().getStuploadPath()))
            .andExpect(jsonPath("$[0].stfileName").value(modifySaleBoardVO.getThumbImg().getStfileName()))
            .andReturn();

        mockMvc.perform(get("/board/getImageList")
                .contentType(MediaType.APPLICATION_JSON)
                .param("sno", String.valueOf(registerSno)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$[0].sno").value(registerSno))
            .andExpect(jsonPath("$[0].suuid").value(modifySaleBoardVO.getAttachList().get(0).getSuuid()))
            .andExpect(jsonPath("$[0].suploadPath").value(modifySaleBoardVO.getAttachList().get(0).getSuploadPath()))
            .andExpect(jsonPath("$[0].sfileName").value(modifySaleBoardVO.getAttachList().get(0).getSfileName()))
            .andExpect(jsonPath("$[1].sno").value(registerSno))
            .andExpect(jsonPath("$[1].suuid").value(modifySaleBoardVO.getAttachList().get(1).getSuuid()))
            .andExpect(jsonPath("$[1].suploadPath").value(modifySaleBoardVO.getAttachList().get(1).getSuploadPath()))
            .andExpect(jsonPath("$[1].sfileName").value(modifySaleBoardVO.getAttachList().get(1).getSfileName()))
            .andReturn();

    }

    @Test
    @DisplayName("상품 판매 삭제를 하면 성공한다.")
    public void whenDeleteSaleProductThenSuccess() throws Exception {

        SaleBoardVO deleteSaleBoard = newSaleBoard;

        MvcResult result = mockMvc.perform(get("/board/saleDelete")
                .param("sno", String.valueOf(deleteSaleBoard.getSno())))
            .andExpect(status().is3xxRedirection())
            .andReturn();

        MvcResult mvcResult = mockMvc.perform(get("/board/saleDetail")
                .contentType(MediaType.APPLICATION_JSON)
                .param("sno", String.valueOf(deleteSaleBoard.getSno())))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("countRstar"))
            .andExpect(model().attributeExists("rnoList"))
            .andExpect(model().attributeExists("sale"))
            .andReturn();

        ModelAndView modelAndView = mvcResult.getModelAndView();
        Map<String, Object> model = modelAndView.getModel();
        SaleBoardVO getSaleBoardVO = (SaleBoardVO) model.get("sale");

        assertEquals("Y", getSaleBoardVO.getSdelete());

    }

    @Test
    @DisplayName("결제 페이지를 호출하면 성공한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    public void whenGetSalePayPageThenSuccess() throws Exception {

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

        //when
        //then
        MvcResult basketListResult = mockMvc.perform(get("/board/salePay")
                .param("cid", TEST_CLIENT.getCid()))
            .andExpect(status().isOk())
            .andExpect(model().attributeExists("thumbImgSnoList"))
            .andExpect(model().attributeExists("totalPrice"))
            .andExpect(model().attributeExists("basketList"))
            .andReturn();

        Map<String, Object> basketListModel = basketListResult.getModelAndView().getModel();
        List<HashMap<String, Object>> basketList = (List<HashMap<String, Object>>) basketListModel.get("basketList");
        HashMap<String, Object> basket = basketList.get(0);
        String bcode = (String) basket.get("BCODE");
        BigDecimal bamount = (BigDecimal) (basket.get("BAMOUNT"));
        BigDecimal bprice = (BigDecimal) basket.get("BPRICE");

        assertNotNull(bcode);
        assertEquals(TEST_CLIENT.getCid(), basket.get("CID"));
        assertNotNull(basket.get("BDATE"));
        assertEquals(basketVO.getBamount(), bamount.intValue());
        assertEquals(basketVO.getBprice(), bprice.intValue());

        List<Integer> basketListThumbImgSnoList = (List<Integer>) basketListModel.get("thumbImgSnoList");
        assertEquals(basketVO.getSno(), basketListThumbImgSnoList.get(0));

        int basketListTotalPrice = (int) basketListModel.get("totalPrice");
        assertEquals(basketVO.getBprice() * basketVO.getBamount(), basketListTotalPrice);

    }

    @Test
    @DisplayName("주문 결제 정보를 저정하면 성공한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    public void whenSaveOrderThenSuccess() throws Exception {

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


        //when
        //then
        MvcResult basketListResult = mockMvc.perform(post("/board/salePay")
                .param("cid", TEST_CLIENT.getCid())
                .param("oaddress", ordVO.getOaddress())
                .param("ophone", ordVO.getOphone()))
            .andExpect(status().isOk())
            .andReturn();

        // TODO 값 검증하는 service or controller 만든후 검증하기

    }

    @Test
    @DisplayName("찜하기가 되어있으면 '1'을 리턴한다.")
    @WithMockUser(
        authorities = {"ROLE_CLIENT"}
    )
    public void whenDoneZimThenReturn1() throws Exception {

        //given
        ZimVO zimVO = new ZimVO();
        zimVO.setCid(TEST_CLIENT.getCid());
        zimVO.setSno(newSaleBoard.getSno());

        mockMvc.perform(post("/board/doZim")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(zimVO)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("1"))
            .andReturn();

        //when
        //then
        mockMvc.perform(post("/board/checkZim")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(zimVO)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$").value("1"))
            .andReturn();
    }
}