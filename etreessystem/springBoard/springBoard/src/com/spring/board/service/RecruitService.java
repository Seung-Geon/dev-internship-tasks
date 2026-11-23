package com.spring.board.service;

import java.util.Map;

import com.spring.board.vo.RecruitMainVo;
import com.spring.board.vo.RecruitVo;

public interface RecruitService {

	RecruitMainVo selectMainPage(RecruitVo recruitVo);

	Map<String, Object> saveRecruit(RecruitMainVo recruit);

}
