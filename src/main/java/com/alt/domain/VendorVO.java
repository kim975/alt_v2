package com.alt.domain;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VendorVO {

	private String vid;
	private String vpassword;
	private String vname;
	private String vregisterNo;
	private String vphone;
	private String vaddress;
	private Timestamp vjoinDate;
	private String vinfo;
	private int vreport;
	private String vdelete;
	private String vgrade;
	private int enable;

	
}
