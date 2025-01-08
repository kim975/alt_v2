package com.alt.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeVO {

	private Long nno;
	private String nwriter;
	private String ntitle;
	private String ncontent;
	private Timestamp nwriteDate;
	private Timestamp nupdateDate;
	
	//첨부파일을 한번에 처리할 수 있도록
	private List<NoticeImgVO> noticeAllAttach;
}
