package com.alt.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClientVO  {

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
	
}
