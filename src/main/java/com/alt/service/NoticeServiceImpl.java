package com.alt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alt.domain.Criteria;
import com.alt.domain.NoticeImgVO;
import com.alt.domain.NoticeVO;
import com.alt.mapper.NoticeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class NoticeServiceImpl implements NoticeService{
	
	@Setter(onMethod_ = {@Autowired})
	private NoticeMapper noticeMapper;
	
	//전체게시글 : 페이징 처리 X
	@Override
	public List<NoticeVO> noticeAllList(){
		log.info("NoticeAllList() : " );
		return noticeMapper.noticeAllList();
	}
	
	//전체게시물 : 페이징 처리
	public List<NoticeVO> noticePaging(Criteria cri){
		if(cri.getType()=="" || cri.getType()==null) {
			return noticeMapper.noticePaging(cri);
		}else {
			return noticeMapper.noticePagingSearch(cri);
		}
	}
	
	//REST API로 만드는 페이징
//	public PageDTO noticePagingSearch(Criteria cri) {
//		if(cri.getType()=="") {
//			return noticeMapper.noticePaging(cri);
//		} else {
//			return noticeMapper.noticePagingSearch(cri);
//		}
//	}
	
	//총 행개수 : 페이징 처리
	public int totalCountNotice(Criteria cri) {
		log.info("totalCountNotice() : " + cri);
		return noticeMapper.totalCountNotice(cri);
	}

	//특정게시물의 첨부파일 조회
	public List<NoticeImgVO> getAttachList(Long nno) {
		log.info("NoticeService getAttachList by nno : " + nno);
		return noticeMapper.findNno(nno);
	}
	
	//게시글  등록
	@Transactional
	@Override
	public void registerNotice(NoticeVO noticeVO) {
		log.info("NoticeService registerNotice : " + noticeVO);
		noticeMapper.registerSelectKey(noticeVO);
		if(noticeVO.getNoticeAllAttach()==null || noticeVO.getNoticeAllAttach().size()<=0) {
			return;
		}
		noticeVO.getNoticeAllAttach().forEach(attach -> {
			attach.setNno(noticeVO.getNno());
			
			System.out.println("attach:" + attach.toString());
			
			noticeMapper.addAttachNotice(attach);
		});
	}
	
	//게시글 상세정보
	@Override
	public NoticeVO getNotice(Long nno) {
		log.info("NoticeService get() : " + nno);
		return noticeMapper.getNotice(nno);
	}

	//게시물 수정
	@Transactional
	@Override
	public boolean modifyNotice(NoticeVO noticeVO) {
		log.info("NoticeService modifyNotice() : " + noticeVO);
		noticeMapper.removeAllAttach(noticeVO.getNno());
		boolean modifyResult = noticeMapper.modifyNotice(noticeVO) == 1;
		//게시물 수정시 첨부파일이 존재하면(DML작업)
		if(modifyResult && noticeVO.getNoticeAllAttach() != null && noticeVO.getNoticeAllAttach().size()>0) {
			//첨부파일 정보를 하나씩 첨부파일 테이블에 삽입
			noticeVO.getNoticeAllAttach().forEach(attach -> {
				attach.setNno(noticeVO.getNno());
				noticeMapper.addAttachNotice(attach);
			});
		}
		return modifyResult;
	}
	
	//게시물 삭제
	@Transactional
	@Override
	public boolean removeNotice(Long nno) {
		log.info("NoticeService delteNotice() : " + nno);
		noticeMapper.removeAllAttach(nno);
		return noticeMapper.removeNotice(nno) == 1;
	}
	
}
