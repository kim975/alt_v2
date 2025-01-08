package com.alt.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdProductVO {
	
	private int ordProductCode;
	private String ocode;          
	private int sno;            
	private int oamount;        
	private int oprice;
	private String oppay;
	
	public OrdProductVO(String ocode, int sno, int oamount, int oprice) {
		this.ocode = ocode;
		this.sno = sno;
		this.oamount = oamount;
		this.oprice = oprice;
	} 
	
}
