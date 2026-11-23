package com.spring.board.dao;

import java.util.List;

import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitVo;

public interface RecruitDao {

	RecruitVo selectRecruit(RecruitVo recruitVo);

	List<EducationVo> selectEducationList(String seq);

	List<CareerVo> selectCareerList(String seq);

	List<CertificateVo> selectCertificateList(String seq);

	int insertRecruit(RecruitVo recruitVo);

	int updateRecruit(RecruitVo recruitVo);

	int deleteEducationList(String seq);

	int deleteCareerList(String seq);

	int deleteCertificateList(String seq);

	int insertEducationList(List<EducationVo> educationList);

	int insertCareerList(List<CareerVo> careerList);

	int insertCertificateList(List<CertificateVo> certificateList);
}
