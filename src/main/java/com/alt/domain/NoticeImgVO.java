package com.alt.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeImgVO {

	private String nuuid;
	private String nuploadPath;
	private String nfileName;
	private String nfileType;		//default I
	private Long nno;
}
