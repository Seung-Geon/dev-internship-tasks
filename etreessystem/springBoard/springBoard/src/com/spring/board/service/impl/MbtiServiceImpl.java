package com.spring.board.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.MbtiDao;
import com.spring.board.service.MbtiService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

@Service
public class MbtiServiceImpl implements MbtiService{
	
	@Autowired
	MbtiDao mbtiDao;

	@Override
	public List<BoardVo> selectList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub	
		return mbtiDao.selectList(pageVo);
	}

	@Override
	public int selectCnt() throws Exception {
		// TODO Auto-generated method stub
		return mbtiDao.selectCnt();
	}

	@Override
	public int mbtiInsert(BoardVo boardVo) {
		// TODO Auto-generated method stub
		boardVo.setBoardTitle("MBTI " + boardVo.getBoardType() + " 질문");
		
		return mbtiDao.mbtiInsert(boardVo);
	}

	@Override
	public List<BoardVo> selectTestList() {

		List<BoardVo> mbtiTestList = new ArrayList<>();
		PageVo pageVo = new PageVo();
		
		for(int i = 1; i <= 4; i++) {
			pageVo.setPageNo(i);	
			List<BoardVo> tempList = mbtiDao.mbtiTestSelect(pageVo);
			Collections.shuffle(tempList);
			
			mbtiTestList.addAll(tempList.subList(0, 5));
		}
		return mbtiTestList;
	}

	@Override
	public String calculateMbtiType(Map<String, String[]> answers) {

		Map<String, Integer> points = new HashMap<>();
		
		for(String key: answers.keySet()) {
			int radioValue = Integer.parseInt(answers.get(key)[0]);
			String mbtiLetter1 = String.valueOf(key.charAt(0));
			String mbtiLetter2 = String.valueOf(key.charAt(1));
			
			// 점수 계산 방법 1: switch문을 활용
			switch(radioValue) {
			
				case 1:
					points.put(mbtiLetter1, points.getOrDefault(mbtiLetter1, 0) + 3);	
					break;
				case 2:
					points.put(mbtiLetter1, points.getOrDefault(mbtiLetter1, 0) + 2);					
					break;
				case 3:
					points.put(mbtiLetter1, points.getOrDefault(mbtiLetter1, 0) + 1);
					break;
				case 4:	break;
				case 5:
					points.put(mbtiLetter2, points.getOrDefault(mbtiLetter2, 0) + 1);
					break;
				case 6:
					points.put(mbtiLetter2, points.getOrDefault(mbtiLetter2, 0) + 2);
					break;
				case 7:
					points.put(mbtiLetter2, points.getOrDefault(mbtiLetter2, 0) + 3);
					break;
			}
			
			// 점수 계산 방법 2: max 메소드를 활용한 수식
//			int letterOneScore = Math.max(0, 4 - radioValue);
//			int letterTwoScore = Math.max(0, radioValue - 4);
//			points.put(mbtiLetter1, points.getOrDefault(mbtiLetter1, 0) + letterOneScore);
//			points.put(mbtiLetter2, points.getOrDefault(mbtiLetter2, 0) + letterTwoScore);
		}
		
		StringBuilder mbtiType = new StringBuilder();

		
		final String[][] MBTI_DIMENSIONS = {
				{"E", "I"}, 
				{"N", "S"}, 
				{"F", "T"}, 
				{"J", "P"}
		};	
		
		// 사전순 정렬 방법 1: 메소드 호출을 통한 해결
//		for (String[] dim: MBTI_DIMENSIONS) {
//			mbtiType.append(selectWinningLetter(dim[0], dim[1], points));
//		}
		
		// 사전순 정렬 방법 2: 반복문 내에서 해결
		for (String[] dim: MBTI_DIMENSIONS) {
			int letterOnePoint = points.getOrDefault(dim[0], 0);
			int letterTwoPoint = points.getOrDefault(dim[1], 0);
			
			if(letterOnePoint > letterTwoPoint) mbtiType.append(dim[0]);
			else if(letterOnePoint < letterTwoPoint) mbtiType.append(dim[1]);
			else mbtiType.append(dim[0].compareTo(dim[1]) < 0 ? dim[0] : dim[1]);
		}
		
				
		return 	mbtiType.toString();
	}
	
//	private String selectWinningLetter(String letter1, String letter2, Map<String, Integer> points) {
//		int a = points.getOrDefault(letter1,  0);
//		int b = points.getOrDefault(letter2, 0);
//		
//		if(a > b) return letter1;
//		else if (a < b) return letter2;
//		else return letter1.compareTo(letter2) < 0 ? letter1 : letter2;
//	}	
}
