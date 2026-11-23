package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.RecruitDao;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitVo;

@Repository
public class RecruitDaoImpl implements RecruitDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public RecruitVo selectRecruit(RecruitVo recruitVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("recruit.recruitOne", recruitVo);
	}

	@Override
	public List<EducationVo> selectEducationList(String seq) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("recruit.educationList", seq);
	}

	@Override
	public List<CareerVo> selectCareerList(String seq) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("recruit.careerList", seq);
	}

	@Override
	public List<CertificateVo> selectCertificateList(String seq) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("recruit.certificateList", seq);
	}

	
	@Override
	public int insertRecruit(RecruitVo recruitVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertRecruit", recruitVo);
	}

	@Override
	public int updateRecruit(RecruitVo recruitVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("recruit.updateRecruit", recruitVo);
	}

	@Override
	public int deleteEducationList(String seq) {
		// TODO Auto-generated method stub
		return sqlSession.delete("recruit.deleteEducation", seq);
	}

	@Override
	public int deleteCareerList(String seq) {
		// TODO Auto-generated method stub
		return sqlSession.delete("recruit.deleteCareer", seq);	
	}

	@Override
	public int deleteCertificateList(String seq) {
		// TODO Auto-generated method stub
		return sqlSession.delete("recruit.deleteCertificate", seq);
	}

	@Override
	public int insertEducationList(List<EducationVo> educationList) {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertEducation", educationList);
	}

	@Override
	public int insertCareerList(List<CareerVo> careerList) {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertCareer", careerList);
	}

	@Override
	public int insertCertificateList(List<CertificateVo> certificateList) {
		// TODO Auto-generated method stub
		return sqlSession.insert("recruit.insertCertificate", certificateList);
	}
}
