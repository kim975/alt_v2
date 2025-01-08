package com.alt.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alt.domain.Criteria;
import com.alt.domain.NoticeImgVO;
import com.alt.domain.NoticeVO;
import com.alt.domain.PageDTO;
import com.alt.service.AdminService;
import com.alt.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/notice")
@AllArgsConstructor
public class NoticeController {

	@Setter(onMethod_ = {@Autowired})
	private NoticeService noticeService;
	
	@Autowired
	private AdminService adminService;
	
	//전체게시글 : 페이징 처리 X
//	@GetMapping("/list")
//	public void noticeList(Model model) {
//		log.info("noticeList");
//		model.addAttribute("noticeList", noticeService.noticeAllList());
//	}
	
	//전체게시글 : 페이징 처리 
	@GetMapping("/list")
	public void noticeList(Model model, Criteria cri) {
		log.info("noticeList 페이징===================");
		model.addAttribute("noticeList", noticeService.noticePaging(cri));
		
		int total = noticeService.totalCountNotice(cri);
		log.info("total================= : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		int clientCount = adminService.clientCount();
		model.addAttribute("clientCount", clientCount);
		
		int vendorCount = adminService.vendorCount();
		model.addAttribute("vendorCount", vendorCount);
		
		int totalsaleboard = adminService.totalsaleboard();
		model.addAttribute("totalsaleboard", totalsaleboard);
		
		int totalOrd = adminService.totalOrd();
		model.addAttribute("totalOrd", totalOrd);
	}
	
	//게시글 등록 get
	@GetMapping("/register")
	public void getNoticeRegister() {
		log.info("getNoticeRegister");
	}
	
	//게시글 등록 post
	@PostMapping("/register")
	public String postNoticeRegister(NoticeVO noticeVO, RedirectAttributes redirectAttr) {
		log.info("postNoticeRegister : " +  noticeVO);
		if(noticeVO.getNoticeAllAttach()!=null) {
			noticeVO.getNoticeAllAttach().forEach(attach ->log.info(attach));
		}
		noticeService.registerNotice(noticeVO);
		redirectAttr.addFlashAttribute("result", noticeVO.getNno());
		return "redirect:/notice/list";
	}
	
	//게시글 상세
	@GetMapping({"/get","/modify"})
	public void getNotice(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get /modify");
		model.addAttribute("notice", noticeService.getNotice(nno));
	}
	
	//게시글 수정
	@PostMapping("/modify")
	public String modifyNotice(NoticeVO noticeVO, @ModelAttribute("cri") Criteria cri, RedirectAttributes redirectAttr) {
		log.info("modifyNotice : " + noticeVO);
		if(noticeService.modifyNotice(noticeVO)) {
			redirectAttr.addAttribute("result", "success");
		} 
		return "redirect:/notice/list" + cri.getListLink();
	}

	//게시글 삭제
	@PostMapping("/remove")
	public String removeNotice(@RequestParam("nno") Long nno, @ModelAttribute("cri") Criteria cri, RedirectAttributes redirectAttr) {
		log.info("removeNotice() : "+ nno);
		List<NoticeImgVO> attachList = noticeService.getAttachList(nno);
		
		if(noticeService.removeNotice(nno)) {
			deleteFiles(attachList);
			redirectAttr.addFlashAttribute("result", "success");
		}
		return "redirect:/notice/list" + cri.getListLink();
	}
	
	//모든첨부파일 서버삭제
	private void deleteFiles(List<NoticeImgVO> attachList) {
		if(attachList ==null || attachList.size()==0) {
			return;
		}
		log.info("attachList : " + attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\upload\\" + attach.getNuploadPath() + "\\" + attach.getNuuid() + "_" + attach.getNfileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\upload\\" + attach.getNuploadPath() + "\\s_" + attach.getNuuid() + "_" + attach.getNfileName());
					Files.delete(thumbNail);
				}
			} catch(Exception e) {
				log.error("DELETE File Error : " + e.getMessage());
			}//END try-catch
		});//END 익명블록 attachList
	}//END deleteFiles
	
	//특정게시물 첨부파일 조회
	@GetMapping(value="/getAttachList", produces= {"application/json; charset=UTF-8"})
	@ResponseBody
	public ResponseEntity<List<NoticeImgVO>> getAttachList(Long nno) {
		log.info("getAttachList : " + nno);
		return new ResponseEntity<>(noticeService.getAttachList(nno), HttpStatus.OK);
	}
	
}