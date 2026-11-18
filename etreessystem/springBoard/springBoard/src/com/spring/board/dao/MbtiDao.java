package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

public interface MbtiDao {

	public List<BoardVo> selectList(PageVo pageVo);
	
	public int selectCnt();

	public int mbtiInsert(BoardVo boardVo);

	public List<BoardVo> mbtiTestSelect(PageVo pageVo);
}
