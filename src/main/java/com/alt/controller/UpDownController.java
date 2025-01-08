package com.alt.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alt.domain.AttachFileVO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UpDownController {
	
	String uploadFolder = "C:\\upload";
	
	//-----------------------------파일업로드-----------------------------	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("uploadAjax()");
	}

	//이미지 날짜 폴더생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("/", File.separator);
	}
	
	//섬네일 이미지파일 생성
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch(IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	@PostMapping(value="/uploadAjaxAction", produces= {"application/json; charset=UTF-8"})
//	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public ResponseEntity<List<AttachFileVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("update Ajax post()");
		
		List<AttachFileVO> list = new ArrayList<>();
		
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);	
		
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileVO attachFileVO = new AttachFileVO();
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("경로가 제거된 업로드 파일이름 : " + uploadFileName);
			attachFileVO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachFileVO.setUuid(uuid.toString());
				attachFileVO.setUploadPath(uploadFolderPath);
				
				if(checkImageType(saveFile)) {
					attachFileVO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);
					thumbnail.close();
				}
				list.add(attachFileVO);
			} catch(Exception e) {
				log.error(e.getMessage());
			}//END try-catch
		}//END for
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}//END uploadAjaxPost	

//이미지파일 표시
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("전달된 이미지 파일이름 fileName : " + fileName);
		
		File file = new File("C:\\upload\\" + fileName);
		log.info("전체경로가 포함된 file객체의 이미지파일이름  : " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch(IOException e) {
			e.printStackTrace();
		}//END try-catch
		return result;
		}//END getFile
		
	//---------------------------------------다운로드-------------------------------------
	@GetMapping(value="/download", produces= {"application/octet-stream;"})
	@ResponseBody	
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		log.info("download file : " + fileName);
		log.info("@RequestHeader(User-Agent) : " + userAgent);
		
		Resource resource = new FileSystemResource("C:\\upload\\" + fileName);
		log.info("resource" + resource);
		
		if(resource.exists()==false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		
		HttpHeaders headers = new HttpHeaders();

		try { 																		
			String downloadName = null;
			if(userAgent.contains("Trident")|| userAgent.contains("MSIE")) { 
				log.info("IE browser(IE 한글 : url로나옴)");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replace("\\+",  " ");
			} else if(userAgent.contains("Edge") || userAgent.contains("Edg")) {
				log.info("Edge browser(Edge 한글 : url로나옴)");
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				log.info("Chrome browser(Chrome 한글 : 깨짐)");
				downloadName =  new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			log.info("downloadName : " + downloadName);
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			log.info("headers" + headers.toString());
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
//	@PreAuthorize("isAuthenticated()")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName + ", type : " + type);

		File file;
		
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			if (type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName: " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
}
