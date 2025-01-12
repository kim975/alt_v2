package com.alt.service;

import java.util.List;

import com.alt.domain.ChartVO;
import com.alt.domain.ClientChartVO;
import com.alt.domain.ClientVO;
import com.alt.domain.Criteria;
import com.alt.domain.ProductVO;
import com.alt.domain.RtoVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.TotalPriceVO;
import com.alt.domain.VendorChartVO;
import com.alt.domain.VendorVO;

public interface AdminService {

    //
    //client 리스트
    public List<ClientVO> clientListPaging(Criteria cri);

    //
    // client 총 수
    public int getTotaleCountC(Criteria cri);

    //
    // client 삭제
    public int clientDelete(String cid);

    //
    //client 업데이트
    public boolean clientUpdate(String cid);

    //
    //client  Y 리스트
    public List<ClientVO> clientListYPaging(Criteria cri);

    //
    // client Y 총 수
    public int getTotaleCountYC(Criteria cri);

    //
    // client Y 삭제
    public int clientDeleteY(String cid);

    //
    //client R 리스트
    public List<ClientVO> clientListRPaging(Criteria cri);

    //
    // client R총 수
    public int getTotaleCountRC(Criteria cri);

    //
    // client R 삭제
    public int clientDeleteR(String cid);

    //
    //vendor 페이징 리스트
    public List<VendorVO> vendorListPaging(Criteria cri);

    //
    // vendor 총 수
    public int getTotaleCountV(Criteria cri);

    //
    // vendor 삭제
    public int vendorDelete(String vid);

    //
    //vendor 업데이트
    public boolean vendorUpdate(String vid);

    //
    //vendor Y 리스트
    public List<VendorVO> vendorListYPaging(Criteria cri);

    //
    // vendor Y 총 수
    public int getTotaleCountYV(Criteria cri);

    //
    // vendor Y 삭제
    public int vendortDeleteY(String vid);

    //
    //vendor R 리스트
    public List<VendorVO> vendorListRPaging(Criteria cri);

    //
    // vendor R 총 수
    public int getTotaleCountRV(Criteria cri);

    //
    // vendor R 삭제
    public int vendortDeleteR(String vid);

    //
    //client 총수
    public int clientCount();

    //
    //vendor 총수
    public int vendorCount();

    //
    //탈퇴 총수
    public int deleteSum();

    //
    //신고 총수
    public int reportSum();

    //
    //업체 지역 비율
    public List<RtoVO> vendorRto();


    //
    //product 리스트
    public List<ProductVO> productListPaging(Criteria cri);

    //
    // vendor 총 수
    public int getProductCount(Criteria cri);

    //
    //product 등록
    public void registerProduct(ProductVO productVO);

    //
    //차트
    public List<ChartVO> orderChart();

    //
    // 주문량 차트
    public List<ClientChartVO> clientChart();

    //
    // 주문량 차트
    public List<ClientChartVO> clientChartD();

    //
    // 업체량 차트
    public List<VendorChartVO> vendorChart();

    //
    // 업체삭제양 차트
    public List<VendorChartVO> vendorChartD();

    //
    // 업체삭제양 차트
    public List<TotalPriceVO> totalPrice();

    //
    //상품 총수
    public int totalsaleboard();

    //
    //상품 총수
    public int totalOrd();

    //
    //client 리스트
    public List<SaleBoardVO> saleList(Criteria cri);

    //
    // 판매게시판 삭제
    public int saleListDelete(String sno);

    //
    // 판매게시판 총 수
    public int saleListCount(Criteria cri);
}
