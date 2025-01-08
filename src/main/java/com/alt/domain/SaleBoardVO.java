package com.alt.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SaleBoardVO {

	private int sno;
	private String vid;
	private int pcode;
	private String stitle;
	private String sinfo;
	private Timestamp swriteDate;
	private Timestamp supdateDate;
	private int sprice;
	private String sdelete;
	private int scount;
	private int samount;
	
	private List<SaleImgVO> attachList;
	private SaleThumbImgVO thumbImg;
	
}
