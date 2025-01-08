package com.alt.service;

import java.util.List;

import com.alt.domain.Criteria;
import com.alt.domain.NoticeImgVO;
import com.alt.domain.NoticeVO;

public interface NoticeService {
	//AdminTable 

	//전체게시글 : 페이징 처리 X
	public List<NoticeVO> noticeAllList();
	
	//전체게시물 : 페이징 처리
	public List<NoticeVO> noticePaging(Criteria cri);
	
	//REST API로 만드는 페이징
//	public PageDTO noticePagingSearch(Criteria cri);
	
	//총 행개수 : 페이징 처리
	public int totalCountNotice(Criteria cri);

	//특정게시물의 첨부파일 조회
	public List<NoticeImgVO> getAttachList(Long nno);
	
	//게시글 등록
	public void registerNotice(NoticeVO NoticeVO);
	
	//게시물 상세정보
	public NoticeVO getNotice(Long nno);
	
	//게시글 수정
	public boolean modifyNotice(NoticeVO noticeVO);
	
	//게시글 삭제
	public boolean removeNotice(Long nno);
	
}