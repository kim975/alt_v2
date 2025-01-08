package com.alt.mapper;

import java.util.List;

import com.alt.domain.Criteria;
import com.alt.domain.NoticeImgVO;
import com.alt.domain.NoticeVO;

public interface NoticeMapper {

	//AdminTable 전체목록
	public List<NoticeVO> noticeAllList();
	
	//페이징쿼리
	public List<NoticeVO> noticePaging(Criteria cri);
	
	//페이징 목록 검색
	public List<NoticeVO> noticePagingSearch(Criteria cri);
	
	//페이징시 전체글 개수
	public int totalCountNotice(Criteria cri);

	//게시글 등록
	public void registerNotice(NoticeVO NoticeVO);
	
	public Integer registerSelectKey(NoticeVO NoticeVO);
	
	//게시글 조회
	public NoticeVO getNotice(Long nno);
	
	//게시글 수정
	public int modifyNotice(NoticeVO noticeVO);
	
	//게시글 삭제
	public int removeNotice(Long nno);
	
	////////AdminImg 첨부파일
	
	//게시물 등록 첨부파일 정보 DB 저장
	public void addAttachNotice(NoticeImgVO imgVO);

	//게시물 삭제
	public void removeAttachNotice(String nuuid);

	//특정게시물의 첨부파일 정보 조회
	public List<NoticeImgVO> findNno(Long nno);

	//특정게시물의 모든 첨부파일 삭제
	public void removeAllAttach(Long nno);
	
	//실행되는 시점을 기존으로 하루전 날짜까지의 모든 첨부파일 정보를 조회 
	public List<NoticeImgVO> selectAttachFilesBeforeOneDay();
}
