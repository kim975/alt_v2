package com.alt.domain;

 

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RtoVO {
	
	private String 	cityCd;
	private String cityNm;
	private int nvl2;
	private int totCnt;
	private double rto;

}
