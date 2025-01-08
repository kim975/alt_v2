package com.alt.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AttachFileVO {

	private String fileName;	//원본파일이름
	private String uploadPath;	//업로드 경로
	private String uuid;		//UUID값
	private boolean image;		//이미지여부
}