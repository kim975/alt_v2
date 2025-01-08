package com.alt.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alt.domain.ChartVO;
import com.alt.domain.ClientAuthVO;
import com.alt.domain.ClientChartVO;
import com.alt.domain.Criteria;
import com.alt.domain.PageDTO;
import com.alt.domain.ProductVO;
import com.alt.domain.RtoVO;
import com.alt.domain.TotalPriceVO;
import com.alt.domain.VendorAuthVO;
import com.alt.domain.VendorChartVO;
import com.alt.service.AdminService;
import com.alt.service.ClientService;
import com.alt.service.VendorService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private ClientService clientService;
    
    @Autowired
    private VendorService vendorService;
    
    //정민 
    //관리자 페이지
    @GetMapping(value = "/admin")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String admin(Model model) {

        int clientCount = adminService.clientCount();
        model.addAttribute("clientCount", clientCount);

        int vendorCount = adminService.vendorCount();
        model.addAttribute("vendorCount", vendorCount);

        int deleteSum = adminService.deleteSum();
        model.addAttribute("deleteSum", deleteSum);

        int reportSum = adminService.reportSum();
        model.addAttribute("reportSum", reportSum);

        List < RtoVO > Rto = adminService.vendorRto();
        model.addAttribute("vendorRto", Rto);

        List < ChartVO > orderChart = adminService.orderChart();
        model.addAttribute("orderChart", orderChart);

        List < ClientChartVO > clientChart = adminService.clientChart();
        model.addAttribute("clientChart", clientChart);

        List < ClientChartVO > clientChartD = adminService.clientChartD();
        model.addAttribute("clientChartD", clientChartD);

        List < VendorChartVO > vendorChart = adminService.vendorChart();
        model.addAttribute("vendorChart", vendorChart);

        List < VendorChartVO > vendorChartD = adminService.vendorChartD();
        model.addAttribute("vendorChartD", vendorChartD);

        List < TotalPriceVO > totalPrice = adminService.totalPrice();
        model.addAttribute("totalPrice", totalPrice);

        return "admin/admin";
        
    }

    //정민
    //client 리스트  페이징 처리 
    @GetMapping(value = "/clientInfo")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String clientInfo(Criteria cri, Model model) {
    	
        log.info("getClientList : " + cri);
        
        int total = adminService.getTotaleCountC(cri);
        model.addAttribute("getClientList", adminService.clientListPaging(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "admin/admin_info_client";
    }

    //정민
    //client 삭제
    @GetMapping("/clientDelete")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String clientDelete(@RequestParam("cid") String cid, Criteria cri, RedirectAttributes rttr) {
    	
        adminService.clientDelete(cid);

        return "redirect:/admin/clientInfo";

    }
    
    //정민
    //client업데이트
    @GetMapping("/clientUpdate")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String clientUpdate(String cid, RedirectAttributes rttr) {
    	
    	ClientAuthVO clientauthVO = new ClientAuthVO();
    	
    	clientauthVO.setCid(cid);
    	
        log.info("clientUpdate : " + cid);

        adminService.clientUpdate(cid);
        clientService.Roleregister(clientauthVO);
        rttr.addFlashAttribute("result", "success");
           
 
        
        return "redirect:/admin/clientInfo";
        
    }
    
    //정민
    //client Y 리스트 
    @GetMapping(value = "/clientListYPaging")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String clientListYPaging(Criteria cri, Model model) {

        log.info("clientListYPaging : " + cri);
        
        int total = adminService.getTotaleCountYC(cri);
        
        model.addAttribute("getClientListY", adminService.clientListYPaging(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "admin/admin_info_client_Y";
        
    }
    
    //정민
    //client Y  삭제
    @GetMapping("/clientDeleteY")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String clientDeleteY(@RequestParam("cid") String cid, RedirectAttributes rttr) {
    	
        log.info("clientDeleteY" + cid);

        adminService.clientDeleteY(cid);

        return "redirect:/admin/clientListYPaging";

    }

    //정민
    //client R 리스트 
    @GetMapping(value = "/clientListRPaging")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String clientListRPaging(Criteria cri, Model model) {

        log.info("clientListRPaging : " + cri);
        
        int total = adminService.getTotaleCountRC(cri);
        
        model.addAttribute("getClientListR", adminService.clientListRPaging(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "admin/admin_info_client_R";
        
    }

    //정민
    // client R  삭제
    @GetMapping("/clientDeleteR")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String clientDeleteR(@RequestParam("cid") String cid, RedirectAttributes rttr) {
    	
        log.info("clientDeleteR : " + cid);

        adminService.clientDeleteR(cid);

        return "redirect:/admin/clientListRPaging";

    }

    //정민
    //vendor 리스트 
    @GetMapping(value = "/vendorListPaging")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String vendorListPaging(Criteria cri, Model model) {

        log.info("vendorInfo : " + cri);
        
        int total = adminService.getTotaleCountV(cri);
        
        model.addAttribute("getVendorList", adminService.vendorListPaging(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));


        return "admin/admin_info_vendor";
    }

    //정민
    // vendor 삭제
    @GetMapping("/vendorDelete")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String vendorDelete(@RequestParam("vid") String vid, RedirectAttributes rttr) {
    	
        log.info("vendorDelete" + vid);

        adminService.vendorDelete(vid);

        return "redirect:/admin/vendorListPaging";

    }
    
    //정민
    //vendor업데이트
    @GetMapping("/vendorUpdate")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String vendorUpdate(String vid, RedirectAttributes rttr) {
    	
    	VendorAuthVO vendorauthVO = new VendorAuthVO();
    	
    	vendorauthVO.setVid(vid);
    	
        log.info("vendorUpdate : " + vid);

        adminService.vendorUpdate(vid);
        vendorService.RoleRegister(vendorauthVO);
        rttr.addFlashAttribute("result", "success");
            
  
        
        return "redirect:/admin/vendorListPaging";
        
    }

    //정민
    //vendor Y 리스트 
    @GetMapping(value = "/vendorListYPaging")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String vendorListYPaging(Criteria cri, Model model) {

        log.info("vendorListYPaging : " + cri);
        
        int total = adminService.getTotaleCountYV(cri);
        
        model.addAttribute("vendorListYPaging", adminService.vendorListYPaging(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "admin/admin_info_vendor_Y";
        
    }

    //정민
    // vendor Y  삭제
    @GetMapping("/vendortDeleteY")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String vendortDeleteY(@RequestParam("vid") String vid, RedirectAttributes rttr) {
    	
        log.info("vendortDeleteY" + vid);

        adminService.vendortDeleteY(vid);

        return "redirect:/admin/vendorListYPaging";

    }
    
    //정민
    //vendor R 리스트 
    @GetMapping(value = "/vendorListRPaging")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String vendorListRPaging(Model model, Criteria cri) {
    	
        log.info("vendorListRPaging" + cri);
        
        int total = adminService.getTotaleCountRV(cri);
        
        model.addAttribute("vendorListRPaging", adminService.vendorListRPaging(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "admin/admin_info_vendor_R";
        
    }
    
    //정민
    //vendor R  삭제
    @GetMapping("/vendortDeleteR")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String vendortDeleteR(@RequestParam("vid") String vid, RedirectAttributes rttr) {
    	
        log.info("vendortDeleteR : " + vid);

        adminService.vendortDeleteR(vid);

        return "redirect:/admin/vendorListRPaging";

    }
    
    //정민
    //product 리스트 
    @GetMapping(value = "/productList")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String productList(Model model, Criteria cri) {

        log.info("productList" + cri);
        
        int total = adminService.getProductCount(cri);
        
        model.addAttribute("productList", adminService.productListPaging(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "admin/product";
        
    }
    
    //정민
    //product 등록 호출
    @GetMapping(value = "/product_register")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String product_register(Model model) {
    	
        log.info("productList");

        return "admin/product_register";
        
    }

    //정민
    //product 등록
    @PostMapping("/registerProduct")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String registerProduct(ProductVO vo, RedirectAttributes rttr) {
    	
        log.info("registerProduct" + vo);
        
        adminService.registerProduct(vo);
        
        rttr.addFlashAttribute("result", vo.getPcode());
        
        return "redirect:/admin/productList";

    }
    
    //정민
    //판매 리스트 
    @GetMapping(value = "/saleList")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String saleList(Model model,Criteria cri ) {
    	
        log.info("saleList controller: " );
        
        int total = adminService.saleListCount(cri);
        
        model.addAttribute("saleList", adminService.saleList(cri));
        model.addAttribute("pageMaker", new PageDTO(cri, total));

        return "admin/saleList";
        
    }
    
    //정민
    //vendor R  삭제
    @GetMapping("/saleListDelete")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String saleListDelete(@RequestParam("sno") String sno, RedirectAttributes rttr) {
    	
        log.info("saleListDelete : " + sno);

        adminService.saleListDelete(sno);

        return "redirect:/admin/saleList";

    }

}