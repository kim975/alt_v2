package com.alt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
import com.alt.mapper.AdminMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	private AdminMapper adminMapper;
	
	//
	//client 페이징 리스트 
		@Override
		public List<ClientVO> clientListPaging(Criteria cri){
			log.info("getList whit criteria : " + cri );
			if(cri.getKeyword()=="") {
				return adminMapper.clientListPaging(cri);
			}else {
				return adminMapper.clientListPaging(cri);
			}
		}
	//
	// client 총 수
		@Override
		public int getTotaleCountC(Criteria cri) {
			log.info("getTotaleCountC : " + cri );
			return adminMapper.getTotaleCountC(cri);
		}
	
	//
	// client 삭제
		@Override
		public int clientDelete(String cid) {
			log.info("clientDelete : " + cid);
			
			return adminMapper.clientDelete(cid);
		}
	//
	//client업데이트
		@Override
		public boolean clientUpdate(String cid) {
			log.info("clientUpdate :" + cid);
			return adminMapper.clientUpdate(cid);
		}
	//
	//client Y 리스트 
		@Override
		public List<ClientVO> clientListYPaging(Criteria cri){
			log.info("getList whit criteria : " + cri );
			if(cri.getKeyword()=="") {
				return adminMapper.clientListYPaging(cri);
			}else {
				return adminMapper.clientListYPaging(cri);
			}
		}
	//
	// clientY 총 수
		@Override
		public int getTotaleCountYC(Criteria cri) {
			log.info("getTotaleCountYC : " + cri );
			return adminMapper.getTotaleCountYC(cri);
		}
	//
	//client Y 삭제 
		@Override
		public int clientDeleteY(String cid){
			log.info("clientDeleteY"+ cid);
			return adminMapper.clientDeleteY(cid);
		}
		
		//
		//clientR 리스트 
			@Override
			public List<ClientVO> clientListRPaging(Criteria cri){
				log.info("clientListRPaging: " + cri );
				if(cri.getKeyword()=="") {
					return adminMapper.clientListRPaging(cri);
				}else {
					return adminMapper.clientListRPaging(cri);
				}
			}
		//
		// client R총 수
			@Override
			public int getTotaleCountRC(Criteria cri) {
				log.info("getTotaleCountRC : " + cri );
				return adminMapper.getTotaleCountRC(cri);
			}
		 
	//
	//client R 삭제 
		@Override
		public int clientDeleteR(String cid){
			log.info("clientDeleteR : "+ cid);
			return adminMapper.clientDeleteR(cid);
		}	
 
	//
	//vendor R 리스트 
		@Override
		public List<VendorVO> vendorListPaging(Criteria cri){
			log.info("vendorListPaging : " + cri );
			if(cri.getKeyword()=="") {
				return adminMapper.vendorListPaging(cri);
			}else {
				return adminMapper.vendorListPaging(cri);
			}
		}
	//
	//vendor R 총 수
		@Override
		public int getTotaleCountV(Criteria cri) {
			log.info("getTotaleCountV : " + cri );
			return adminMapper.getTotaleCountV(cri);
		}
	
	
	//
	// vendor 삭제
	    @Override
		public int vendorDelete(String vid) {
			log.info("vendorDelete : " + vid);
			return adminMapper.vendorDelete(vid);
			
		}
	//
	//vendor업데이트
		@Override
		public boolean vendorUpdate(String vid) {
			log.info("vendorUpdate :" + vid);
			return adminMapper.vendorUpdate(vid);
		}
		
		//
		//vendor Y 리스트 
			@Override
			public List<VendorVO> vendorListYPaging(Criteria cri){
				log.info("vendorListYPaging : " + cri );
				if(cri.getKeyword()=="") {
					return adminMapper.vendorListYPaging(cri);
				}else {
					return adminMapper.vendorListYPaging(cri);
				}
			}
		//
		// clientY 총 수
			@Override
			public int getTotaleCountYV(Criteria cri) {
				log.info("getTotaleCountYV : " + cri );
				return adminMapper.getTotaleCountYV(cri);
			}
		
		
		//	
		//vendor Y 삭제 
			@Override
			public int vendortDeleteY(String vid){
				log.info("vendortDeleteY"+ vid);
				return adminMapper.vendortDeleteY(vid);
			}
 
		//
		//vendor Y 리스트 
			@Override
			public List<VendorVO> vendorListRPaging(Criteria cri){
				log.info("vendorListRPaging : " + cri );
				if(cri.getKeyword()=="") {
					return adminMapper.vendorListRPaging(cri);
				}else {
					return adminMapper.vendorListRPaging(cri);
				}
			}
		//
		// clientY 총 수
			@Override
			public int getTotaleCountRV(Criteria cri) {
				log.info("getTotaleCountRV : " + cri );
				return adminMapper.getTotaleCountRV(cri);
			}

		//	
		//vendor R 삭제 
			@Override
			public int vendortDeleteR(String vid){
				log.info("vendortDeleteR : "+ vid);
				return adminMapper.vendortDeleteR(vid);
			}
			
			//
			// client 총 수
			@Override
				public int clientCount() {
					log.info("clientCount Service : ");
					return adminMapper.clientCount();
				}
			
			//
			// vendor 총 수
			@Override
				public int vendorCount() {
					log.info("vendorCount Service : " );
					return adminMapper.vendorCount();
				}
			//
			// 탈퇴 총 수
			@Override
				public int deleteSum() {
					log.info("deleteSum Service : " );
					return adminMapper.deleteSum();
			}
			//
			// 신고 총 수
			@Override
				public int reportSum() {
					log.info("reportSum Service : " );
					return adminMapper.reportSum();
			}
			//
			//업체 지역 비율
			@Override
			public List<RtoVO> vendorRto(){
				log.info("vendorRto" );
				return adminMapper.vendorRto();
				
			}
			
			//
			//product 리스트
			@Override
			public List<ProductVO> productListPaging(Criteria cri){
				log.info("productList"+ cri );
				return adminMapper.productListPaging(cri);
			}
			//
			//product 등록
			@Override
			public void registerProduct(ProductVO productVO) {
				log.info("registerProduct" + productVO );
				adminMapper.registerProduct(productVO);
			}
			
			//
			// vendor 총 수
			@Override
				public int getProductCount(Criteria cri) {
					log.info("getProductCount Service : " + cri);
					return adminMapper.getProductCount( cri);
				}	
		 
				//
				//product 리스트 chart
				@Override
				public List<ChartVO> orderChart(){
					log.info("orderChart" );
					return adminMapper.orderChart();
				}

				//
				//회원 추가 리스트 chart
				@Override
				public List<ClientChartVO> clientChart(){
					log.info("clientChart" );
					return adminMapper.clientChart();
				}
				//
				// 회원 삭제 차트
				@Override
				public List<ClientChartVO> clientChartD(){
					log.info("clientChartD" );
					return adminMapper.clientChartD();
				}
				//
				// 업체량 차트
				public List<VendorChartVO> vendorChart(){
					log.info("vendorChart" );
					return adminMapper.vendorChart();
				}
				//
				// 업체삭제양 차트
				public List<VendorChartVO> vendorChartD(){
					log.info("vendorChartD" );
					return adminMapper.vendorChartD();
				}
				//
				// 업체삭제양 차트
				public List<TotalPriceVO> totalPrice(){
					log.info("totalPrice" );
					return adminMapper.totalPrice();
				}
				
				

				//
				// vendor 총 수
				@Override
				public int totalsaleboard() {
					log.info("totalsaleboard Service : " );
					return adminMapper.totalsaleboard();
				}
				//
				// vendor 총 수
				@Override
				public int totalOrd() {
					log.info("totalOrd Service : " );
					return adminMapper.totalOrd();
				}
				
				//
				//판매게시판 리스트 
				public List<SaleBoardVO> saleList(Criteria cri){
					log.info("saleList Service : " );
					return adminMapper.saleList(cri);
				}
				
				//	
				//판매게시판 삭제 
					@Override
					public int saleListDelete(String sno){
						log.info("saleListDelete"+ sno);
						return adminMapper.saleListDelete(sno);
					}
					
					//
					// 판매게시판총 수
						@Override
						public int saleListCount(Criteria cri) {
							log.info("saleListCount : " + cri );
							return adminMapper.saleListCount(cri);
						}
					
}
