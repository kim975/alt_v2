package com.alt.domain;

 

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReplyImgVO {
	private String ruuid;
	private String ruploadPath;
	private String rfileName;
	private int rno;
}
