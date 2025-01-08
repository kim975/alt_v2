package com.alt.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alt.domain.Criteria;
import com.alt.domain.ReplyImgVO;
import com.alt.domain.ReplyPageDTO;
import com.alt.domain.ReplyVO;
import com.alt.mapper.BoardAttachMapper;
import com.alt.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyService {

	@Setter(onMethod_ = {@Autowired})
	private ReplyMapper replyMapper;
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper boardAttachMapper;
	
	public int insertReplyRegister(ReplyVO replyVO) {
		
		log.info("Service의 register.......:" + replyVO);
		
		int rno = replyMapper.insertReplyRegister(replyVO);
		
		if(replyVO.getAttachList() == null || replyVO.getAttachList().size() <= 0) {
			
			return rno;
		}
		
		replyVO.getAttachList().forEach(attach ->{
			
			attach.setRno(replyVO.getRno());
			boardAttachMapper.insertReplyImage(attach);
		});
		
		return rno;
	}
	
	public void updateReply(ReplyVO replyVO) {
		
		log.info("Service의 register.......:" + replyVO);
		
		replyMapper.updateReply(replyVO);
		
		boardAttachMapper.deleteReplyImage(replyVO.getRno());
		
		if(replyVO.getAttachList() == null || replyVO.getAttachList().size() <= 0) {
			
			return;
		}
		
		replyVO.getAttachList().forEach(attach ->{
			
			attach.setRno(replyVO.getRno());
			boardAttachMapper.insertReplyImage(attach);
		});
		
	}
	
	public ReplyPageDTO getListPage(Criteria cri, int sno) {
	       
	    return new ReplyPageDTO(replyMapper.selectCountReply(sno), 
	    						replyMapper.selectSaleBoardReplyPaging(cri, sno), null);
	}
	
	public void deleteReply(int rno) {
		
		replyMapper.deleteReply(rno);
	}
	
	public List<ReplyVO> selectSaleBoardRelpy(int sno) {
		
		return replyMapper.selectSaleBoardRelpy(sno);
	}
	
	public List<ReplyImgVO> selectReplyImage(List<Integer> rnoList) {
		
		return replyMapper.selectReplyImage(rnoList);
	}
	
	public ReplyVO selectRelpy(int rno) {
		
		return replyMapper.selectRelpy(rno);
	}
	
	public List<HashMap<String, String>> selectIndexReply() {
		
		return replyMapper.selectIndexReply();
	}
}
