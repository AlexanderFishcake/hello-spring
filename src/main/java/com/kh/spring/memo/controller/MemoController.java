package com.kh.spring.memo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.memo.model.service.MemoService;
import com.kh.spring.memo.model.vo.Memo;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/memo")
public class MemoController {
	
	@Autowired
	private MemoService memoService;
	
	@GetMapping("/memo.do")
	public ModelAndView selectMemoList(ModelAndView mav) {
		//log.debug("memoService = {}", memoService.getClass());
		//MemoServiceImpl
		
		List<Memo> list = new ArrayList<>();
		try {
			//1. 업무로직
			list = memoService.selectMemoList();
			//2. jsp에 위임
			mav.addObject("list", list);
		} catch (Exception e) {
			log.error("메모 불러오기 오류 !",e);
			throw e;
		}
		
		mav.setViewName("memo/memo");
		return mav;
	}
	
	@PostMapping("/insertMemo.do")
	public String insertMemo(Memo memo, RedirectAttributes redirectAttr) {
		log.info("memo = {}",memo);
		
		int result=0;
		try {
			//1. 업무로직
			result=memoService.insertMemo(memo);
			//2.피드백
			redirectAttr.addFlashAttribute("msg","메모 등록 성공!");
		} catch (Exception e) {
			log.error("메모등록 오류 !",e);
			throw e;
		}
		
		return "redirect:/memo/memo.do";
	}
	
	@GetMapping("/deleteMemo.do")
	public String deleteMemo(@RequestParam int no, RedirectAttributes redirectAttr) {
		log.info("deleteNo = {}",no);
		
		int result=0;
		try {
			//1. 업무로직
			result=memoService.deleteMemo(no);
			//2.피드백
			redirectAttr.addFlashAttribute("msg","메모 삭제 성공!");
		} catch (Exception e) {
			log.error("메모삭제 오류 !",e);
			throw e;
		}
		
		return "redirect:/memo/memo.do";
	}
	
}
