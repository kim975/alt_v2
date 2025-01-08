package com.alt.domain;

 

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ZimVO {

	private int zimCode;
	private String cid;
	private int sno;
	private String stitle;
	private int sprice;
	
}
