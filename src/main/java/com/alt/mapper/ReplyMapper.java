package com.alt.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.alt.domain.Criteria;
import com.alt.domain.ReplyImgVO;
import com.alt.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insertReplyRegister(ReplyVO replyVO);
	
	public List<ReplyVO> selectSaleBoardRelpy(int sno);
	
	public List<ReplyImgVO> selectReplyImage(List<Integer> rnoList);
	
	public ReplyVO selectRelpy(int rno);
	
	public void updateReply(ReplyVO replyVO);
	
	public void deleteReply(int rno);
	
	public List<ReplyVO> selectSaleBoardReplyPaging(@Param("cri") Criteria cri, @Param("sno") int sno);
	
	public int selectCountReply(int sno);
	
	public List<HashMap<String, String>> selectIndexReply();
}
