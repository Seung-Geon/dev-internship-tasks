package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.MbtiDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.PageVo;

@Repository
public class MbtiDaoImpl implements MbtiDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<BoardVo> selectList(PageVo pageVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mbti.mbtiList", pageVo);
	}

	@Override
	public int selectCnt() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mbti.mbtiTotal");
	}

	@Override
	public int mbtiInsert(BoardVo boardVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mbti.mbtiInsert", boardVo);
	}

	@Override
	public List<BoardVo> mbtiTestSelect(PageVo pageVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mbti.mbtiTest", pageVo);
	}


	
}
