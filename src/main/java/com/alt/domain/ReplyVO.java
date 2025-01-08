package com.alt.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReplyVO {

	private int rno;
	private String rwriter;
	private String rcontent;
	private Timestamp rwriteDate;
	private Timestamp rupdateDate;
	private int rstar;
	private String rdelete;
	private int sno;
	
	private List<ReplyImgVO> attachList;
}
