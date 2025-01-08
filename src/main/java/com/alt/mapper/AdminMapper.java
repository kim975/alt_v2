package com.alt.mapper;

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

public interface AdminMapper {
	
	
	//정민
	//client 리스트 
	public List<ClientVO> clientListPaging(Criteria cri);
	//정민
	// client 총 수
	public int getTotaleCountC(Criteria cri);
	//정민
	// client 삭제
	public int clientDelete(String cid);
	//정민
	//client 업데이트
	public boolean clientUpdate(String cid);
	//정민
	//client Y 리스트 
	public List<ClientVO> clientListYPaging(Criteria cri);
	//정민
	// client Y 총 수
	public int getTotaleCountYC(Criteria cri);
	//정민
	// client Y 삭제
	public int clientDeleteY(String cid);
	//정민
	//clientR 리스트 
	public List<ClientVO> clientListRPaging(Criteria cri);
	//정민
	// client R총 수
	public int getTotaleCountRC(Criteria cri);
	//정민
	// client R 삭제
	public int clientDeleteR(String cid);
	

	//정민
	//vendor 리스트 
	public List<VendorVO> vendorListPaging(Criteria cri);
	//정민
	// vendor 총 수
	public int getTotaleCountV(Criteria cri);
	//정민
	// vendor 삭제
	public int vendorDelete(String vid);
	//정민
	//vendor 업데이트
	public boolean vendorUpdate(String vid);
	//정민
	//vendor Y 페이징 리스트 
	public List<VendorVO> vendorListYPaging(Criteria cri);
	//정민
	// vendor Y 총 수
	public int getTotaleCountYV(Criteria cri);
	//정민
	// vendor Y 삭제
	public int vendortDeleteY(String vid);
	//정민
	//vendor R 리스트 
	public List<VendorVO> vendorListRPaging(Criteria cri);
	//정민
	// vendor R 총 수
	public int getTotaleCountRV(Criteria cri);
	//정민
	// vendor R 삭제
	public int vendortDeleteR(String vid);
	
	//정민 
	//client 총수
	public int clientCount();
	//정민 
	//vendor 총수
	public int vendorCount();
	//정민 
	//탈퇴 총수
	public int deleteSum();
	//정민 
	//신고 총수
	public int reportSum();
	//정민
	//업체 지역 비율
	public List<RtoVO> vendorRto();
	
	
	//정민
	//product 리스트
	public List<ProductVO> productListPaging(Criteria cri);
	//정민
	// vendor 총 수
	public int getProductCount(Criteria cri);
	//정민
	//product 등록
	public void registerProduct(ProductVO productVO);
	//정민
	// 주문량 차트
	public List<ChartVO> orderChart();
	//정민
	// 회원량 차트
	public List<ClientChartVO> clientChart();
	//정민
	// 회원 삭제양 차트
	public List<ClientChartVO> clientChartD();
	//정민
	// 업체량 차트
	public List<VendorChartVO> vendorChart();
	//정민
	// 업체삭제양 차트
	public List<VendorChartVO> vendorChartD();
	//정민
	// 총매출 차트
	public List<TotalPriceVO> totalPrice();
	
	//정민 
	//상품 총수
	public int totalsaleboard();
	//정민 
	//상품 총수
	public int totalOrd();
	
	//정민
	//client 리스트 
	public List<SaleBoardVO> saleList(Criteria cri);
	//정민
	// 판매게시판 삭제
	public int saleListDelete(String sno );
	//정민
	// 판매게시판 총 수
	public int saleListCount(Criteria cri);
}
