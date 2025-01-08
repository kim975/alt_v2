package com.alt.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdVO {

	private String ocode;
//	private int sno;
//	private int oamount;
//	private int oprice;
	private String cid;
	private String oaddress;
	private String ophone;
	private Timestamp odate;
	private String opay;
	
}
