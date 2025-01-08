package com.alt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alt.domain.BasketVO;
import com.alt.domain.Criteria;
import com.alt.domain.OrdProductVO;
import com.alt.domain.OrdVO;
import com.alt.domain.ProductVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.SaleImgVO;
import com.alt.domain.SaleThumbImgVO;
import com.alt.domain.ZimVO;
import com.alt.mapper.BoardAttachMapper;
import com.alt.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardService {

	@Setter(onMethod_ = {@Autowired})
	private BoardMapper boardMapper;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper boardAttachMapper;
	
	//용민
	public List<SaleBoardVO> getList(Criteria cri) {

		return boardMapper.getListPaging(cri);
	}
	
	//용민
	public List<SaleThumbImgVO> selectSaleBoardThumbImage(List<Integer> snoList) {
		
		return boardMapper.selectSaleBoardThumbImage(snoList);
	}
	
	//용민
	public List<SaleImgVO> selectSaleBoardImamge(int sno) {
		
		return boardMapper.selectSaleBoardImamge(sno);
	}
	
	//용민
	public int getTotalCount() {
		
		return boardMapper.selecTotalCount();
	}
	
	//용민
	public SaleBoardVO getSaleDetail(int sno) {
		
		return boardMapper.getSaleDetail(sno);
	}
	
	//용민
	public int insertBasket(BasketVO basketVO) {
		
		return boardMapper.insertBasket(basketVO);
	}
	
	//용민
	public List<BasketVO> selectBasketList(String cid) {
		
		return boardMapper.selectBasketList(cid);
	}
	
	//용민
	public List<HashMap<String, String>> selectBasketListSaleBoard(String cid) {
		
		return boardMapper.selectBasketListSaleBoard(cid);
	}
	
	//용민
	public int deleteBasket(String bcode) {
		
		return boardMapper.deleteBasket(bcode);
	}
	
	//용민
	public int selectBasketTotalPrice(String cid) {
		
		Integer totalPrice = boardMapper.selectBasketTotalPrice(cid); 
		
		if(totalPrice == null) {
			
			return 0;
		}
		
		return totalPrice;
	}
	
	//용민
	public int insertZim(ZimVO zimVO) {
		
		Integer result = 0;
		
		if (boardMapper.selectZim(zimVO) == 1) {
			
			boardMapper.deleteZim(zimVO);
		} else {
			
			result = boardMapper.insertZim(zimVO);
		}
		
		return result;
	}
	
	//용민
	public String selectZim(ZimVO zimVO) {
		
		if (boardMapper.selectZim(zimVO) == 1) {
			
			return "1";
		} else {
			
			return "0";
		}
		
	}
	
	//용민
	public void register(SaleBoardVO saleBoardVO) {
		
		log.info("Service의 register.......:" + saleBoardVO);
		
		boardMapper.insertSaleProductRegister(saleBoardVO);
		
		if(!(saleBoardVO.getAttachList() == null || saleBoardVO.getAttachList().size() <= 0)) {
			
			saleBoardVO.getAttachList().forEach(attach ->{
				
				attach.setSno(saleBoardVO.getSno());
				boardAttachMapper.insert(attach);
			});
		}
		
		if(saleBoardVO.getThumbImg() != null) {
			
			saleBoardVO.getThumbImg().setSno(saleBoardVO.getSno());
			boardAttachMapper.insertThumb(saleBoardVO.getThumbImg()); 
		}
		
	}
	
	//용민
	//상품 수정
	public void modifyProduct(SaleBoardVO saleBoardVO) {
		
		log.info("saleBoardVO: " + saleBoardVO);
		
		boardMapper.updateSaleProduct(saleBoardVO);
		
		int sno = saleBoardVO.getSno();
		
		boardAttachMapper.deleteInfoImage(sno);
		boardAttachMapper.deleteThumbImage(sno);
		
		
		if(!(saleBoardVO.getAttachList() == null || saleBoardVO.getAttachList().size() <= 0)) {
			
			saleBoardVO.getAttachList().forEach(attach ->{
				
				attach.setSno(sno);
				boardAttachMapper.insert(attach);
			});
		}
		
		if(saleBoardVO.getThumbImg() != null) {
			
			saleBoardVO.getThumbImg().setSno(sno);
			boardAttachMapper.insertThumb(saleBoardVO.getThumbImg()); 
		}
		
	}
	
	//용민
	//상품 삭제 sdelete = Y로
	public void removeProduct(int sno) {
		
		boardMapper.updateRemoveProduct(sno);
	}
	
	//용민
	//결제 물품 등록
	public void insertProductPay(OrdVO ordVO) {
		
		boardMapper.insertOrd(ordVO);
		
		String ocode = ordVO.getOcode();

		log.info("ocode: " + ocode);
		
		List<BasketVO> basketList = boardMapper.selectBasketList(ordVO.getCid());
		
		for (int i = 0; i < basketList.size(); i++) {
			
			OrdProductVO ordProductVO = new OrdProductVO(ocode.toString(), basketList.get(i).getSno(), basketList.get(i).getBamount(), basketList.get(i).getBprice());
			
			boardMapper.insertOrdProduct(ordProductVO);
		}
		
		boardMapper.deleteBasketAll(ordVO.getCid());
	}
	
	//용민
	//별 개수
	public List<HashMap<String, String>> selectCountStar(int sno) {
		
		return boardMapper.selectCountStar(sno);
	}
	
	//용민
	//게시판 별 개수
	public List<HashMap<String, String>> selectSaleBoardStar(List<Integer> snoList) {
		
		return boardMapper.selectSaleBoardStar(snoList);
	}
	
	//용민
	//product code 가져오기
	public List<ProductVO> selectPcode() {
		
		return boardMapper.selectPcode();
	}
	
	//용민
	//상의서 insert
	public void insertConfer(OrdVO ordVO, OrdProductVO ordProductVO) {
		
		boardMapper.insertOrdConfer(ordVO);
		
		String ocode = ordVO.getOcode();
		
		ordProductVO.setOcode(ocode);
		
		boardMapper.insertOrdProductConfer(ordProductVO);
	}
	
	public HashMap<String, String> selectProduct(String ocode) {
		
		return boardMapper.selectProduct(ocode);
	}
	
	public int updateOrdConfer(OrdVO ordVO) {
		
		return boardMapper.updateOrdConfer(ordVO);
	}
}
