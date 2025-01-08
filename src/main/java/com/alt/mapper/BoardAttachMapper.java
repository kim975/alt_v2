package com.alt.mapper;

import java.util.List;

import com.alt.domain.ReplyImgVO;
import com.alt.domain.SaleImgVO;
import com.alt.domain.SaleThumbImgVO;

public interface BoardAttachMapper {

	public void insert(SaleImgVO vo);
	
	public void insertReplyImage(ReplyImgVO replyImgVO);
	
	//용민
	public void insertThumb(SaleThumbImgVO vo);
	
	public void delete(String uuid);
	
	public List<SaleImgVO> findByBno(Long bno);
	
	public void deleteAll(Long bno);
	
	//실행되는 시점 기준으로 하루전 날짜까지의 모든 첨부파일 조회
	public List<SaleImgVO> selectAttachFilesBeforeOneDay();
	
	public void deleteInfoImage(int sno);
	
	public void deleteThumbImage(int sno);
	
	public void deleteReplyImage(int rno);
}
