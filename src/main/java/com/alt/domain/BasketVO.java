package com.alt.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BasketVO {
	
	private String bcode;     
	private String cid;      
	private int sno;       
	private Timestamp bdate;     
	private int bamount;  
	private int bprice;
	
}
