package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.MbtiService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class MbtiController {
	
	@Autowired
	MbtiService mbtiService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// 질문 리스트 가져오기
	@RequestMapping(value = "/mbti/mbtiList.do", method = RequestMethod.GET)
	public String mbtiQuestionList(Locale locale, Model model, PageVo pageVo) throws Exception {
		
		List<BoardVo> mbtiList = new ArrayList<BoardVo>();
		
		int page = 1;
		int totalCnt = 0;
		
		if(pageVo.getPageNo() == 0) {
			pageVo.setPageNo(page);
		}
		
		mbtiList = mbtiService.selectList(pageVo);
		totalCnt = mbtiService.selectCnt();
		
		model.addAttribute("mbtiList", mbtiList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", pageVo.getPageNo());
		
		return "mbti/mbtiList";
	}
	
	@RequestMapping(value = "/mbti/mbtiWrite.do", method = RequestMethod.GET)
	public String mbtiWrite(Locale locale, Model model) throws Exception {
		return "mbti/mbtiWrite";
	}
	
	@RequestMapping(value = "/mbti/mbtiWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String mbtiWriteAction(Locale locale, BoardVo boardVo) throws Exception {
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = mbtiService.mbtiInsert(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	

	@RequestMapping(value = "/mbti/mbtiTest.do", method = RequestMethod.GET)
	public String mbtiTest(Locale locale, Model model) throws Exception {
		
		List<BoardVo> mbtiTestList = new ArrayList<BoardVo>();
		
		mbtiTestList = mbtiService.selectTestList();
		
		model.addAttribute("mbtiTestList", mbtiTestList);
		
		return "mbti/mbtiTest";	
	}
	
	@RequestMapping(value="/mbti/mbtiResult.do", method = RequestMethod.POST)
	public String mbtiResult(Locale locale, Model model
							, HttpServletRequest request) throws Exception {
		
		Map<String, String[]> answers = request.getParameterMap();
		
		if (answers == null || answers.isEmpty()) {
			return "redirect:/mbti/mbtiTest.do";
		}
		
		String mbtiType = mbtiService.calculateMbtiType(answers);
		
		model.addAttribute("mbtiType", mbtiType);
		
		return "mbti/mbtiResult";
	}
	
	@RequestMapping(value="/mbti/mbtiResult.do", method = RequestMethod.GET)
	public String mbtiResultGet() {
	    return "redirect:/mbti/mbtiTest.do";
	}
	
}