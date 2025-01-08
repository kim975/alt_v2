package com.alt.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
	
	private String cid;
	private String cpassword;
	private String cname;
	private String cnick;
	private String cphone;
	private String caddress;
	private Timestamp cjoinDate;
	private int creport;
	private String cdelete;
	private String cgrade;
	private String enable;
	
	private List<ClientAuthVO> ClientAuthList;
	
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
	
	private List<VendorAuthVO> vendorAuthList;
}
