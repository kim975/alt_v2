package com.alt.mapper;

import java.util.HashMap;
import java.util.List;

import com.alt.domain.BasketVO;
import com.alt.domain.Criteria;
import com.alt.domain.OrdProductVO;
import com.alt.domain.OrdVO;
import com.alt.domain.ProductVO;
import com.alt.domain.SaleBoardVO;
import com.alt.domain.SaleImgVO;
import com.alt.domain.SaleThumbImgVO;
import com.alt.domain.ZimVO;

public interface BoardMapper {
	
	//용민
	public List<SaleBoardVO> getListPaging(Criteria cri);
	
	//용민
	public List<SaleThumbImgVO> selectSaleBoardThumbImage(List<Integer> snoList);
	
	//용민
	public SaleBoardVO getSaleDetail(int sno);
	
	//용민
	public int insertBasket(BasketVO basketVO);
	
	//용민
	public List<BasketVO> selectBasketList(String cid);
	
	public List<HashMap<String, String>> selectBasketListSaleBoard(String cid);
	
	//용민
	public int deleteBasket(String bcode);
	
	//용민
	public Integer selectBasketTotalPrice(String cid);
	
	//용민
	public int insertZim(ZimVO zimVO);
	
	//용민
	public int insertSaleProductRegister(SaleBoardVO saleBoardVO);
	
	//용민
	public int selecTotalCount();
	
	//용민
	public List<SaleImgVO> selectSaleBoardImamge(int sno);
	
	//용민
	public void updateSaleProduct(SaleBoardVO saleBoardVO);
	
	public void updateRemoveProduct(int sno);
	
	public Integer selectZim(ZimVO zimVO);
	
	public int deleteZim(ZimVO zimVO);
	
	//용민
	public int insertOrd(OrdVO ordVO);
	
	//용민
	public void insertOrdProduct(OrdProductVO ordProductVO);
	
	public void deleteBasketAll(String cid);
	
	public List<HashMap<String, String>> selectCountStar(int sno);
	
	public List<HashMap<String, String>> selectSaleBoardStar(List<Integer> snoList);
	
	public List<ProductVO> selectPcode();
	
	public int insertOrdConfer(OrdVO ordVO);
	
	public int insertOrdProductConfer(OrdProductVO ordProductVO);
	
	public HashMap<String, String> selectProduct(String ocode);
	
	public int updateOrdConfer(OrdVO ordVO);
}
