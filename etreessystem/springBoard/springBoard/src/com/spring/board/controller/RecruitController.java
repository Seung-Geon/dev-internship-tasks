package com.spring.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.RecruitService;

import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitMainVo;
import com.spring.board.vo.RecruitVo;
import com.spring.common.CommonUtil;


@Controller
public class RecruitController {

	@Autowired
	RecruitService recruitService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/recruit/login.do", method = RequestMethod.GET)
	public String recruitLogin(Locale locale, Model model) throws Exception {
		return "recruit/recruitLogin";
	}
	
	@RequestMapping(value = "/recruit/recruitSession.do", method = RequestMethod.POST)
	@ResponseBody
	public String recruitSave(Locale locale, Model model, 
			@RequestBody RecruitVo recruitVo, HttpSession session) throws Exception {
		
		
		Map<String, Object> result = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
	    // 필요한 검증/조회 후 세션에 저장
	    session.setAttribute("loginName", recruitVo.getName());
	    session.setAttribute("loginPhone", recruitVo.getPhone());

	    result.put("success", "Y");
	    String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
	    
	    //System.out.println("callbackMsg::"+callbackMsg);
	    //System.out.println("name: " + session.getAttribute("loginName"));
	    //System.out.println("phone: " + session.getAttribute("loginPhone"));
	    
	    
	    return callbackMsg;
	}
	
	@RequestMapping(value="/recruit/main.do", method = RequestMethod.GET)
	public String recruitMain(Locale locale, Model model, HttpSession session) throws Exception {
		
		String name = (String) session.getAttribute("loginName");
		String phone = (String) session.getAttribute("loginPhone");
		
		if(name == "" || name == null || phone == "" || phone == null) {
			return "redirect:/recruit/login.do";
		}
		return "recruit/recruitMain";
	}
	
	
	@RequestMapping(value = "/recruit/mainContent.do", method = RequestMethod.POST, produces = "application/json; charset=EUC-KR")
	@ResponseBody
	public String recruitMainContent(Locale locale, Model model, HttpSession session) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		String name = (String) session.getAttribute("loginName");
		String phone = (String) session.getAttribute("loginPhone");
		
		if(name == null || "".equals(name) || phone == null || "".equals(phone)) {
			result.put("success", "N");
			
		} else {
			RecruitVo recruitVo = new RecruitVo();
			recruitVo.setName(name);
			recruitVo.setPhone(phone);

			RecruitMainVo recruit = recruitService.selectMainPage(recruitVo);
		
			result.put("success", "Y");
	    	result.put("recruit", recruit);
		}
	    String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
	    
	    System.out.println("callbackMsg::"+callbackMsg);
	    
	    return callbackMsg;
	}
	
	@RequestMapping(value="/recruit/recruitSend.do", method = RequestMethod.POST, produces = "application/json; charset=EUC-KR")
	@ResponseBody
	public String recruitSend(Locale local, Model model, @RequestBody RecruitMainVo recruit, HttpSession session) throws Exception {
		
		Map<String, Object> result = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();
		
		String name = (String) session.getAttribute("loginName");
		String phone = (String) session.getAttribute("loginPhone");
		

		result = recruitService.saveRecruit(recruit);
		

		session.setAttribute("loginName", name);
		session.setAttribute("loginPhone", phone);
		
	    String callbackMsg = commonUtil.getJsonCallBackString(" ", result);
	    
	    System.out.println("callbackMsg::"+callbackMsg);
	    
	    return callbackMsg;
		
	}
}
