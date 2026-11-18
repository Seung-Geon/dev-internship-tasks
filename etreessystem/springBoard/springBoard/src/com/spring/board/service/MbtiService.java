package com.spring.board.service;

import java.util.List;
import java.util.Map;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

public interface MbtiService {

	public List<BoardVo> selectList(PageVo pageVo) throws Exception;

	public int selectCnt() throws Exception;

	public int mbtiInsert(BoardVo boardVo);

	public List<BoardVo> selectTestList();

	public String calculateMbtiType(Map<String, String[]> answers);

}
