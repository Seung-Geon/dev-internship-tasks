package com.spring.board.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.board.dao.RecruitDao;
import com.spring.board.service.RecruitService;
import com.spring.board.vo.CareerVo;
import com.spring.board.vo.CertificateVo;
import com.spring.board.vo.EducationVo;
import com.spring.board.vo.RecruitMainVo;
import com.spring.board.vo.RecruitVo;

@Service
public class RecruitServiceImpl implements RecruitService {
	
	@Autowired
	RecruitDao recruitDao;

	@Override
	public RecruitMainVo selectMainPage(RecruitVo recruitVo) {
		
		RecruitMainVo recruit = new RecruitMainVo();
		
		RecruitVo recruitTempVo = recruitDao.selectRecruit(recruitVo);	// 있는지 체크
		if (recruitTempVo != null) {
			recruit.setRecruitVo(recruitTempVo);
			String seq = recruit.getRecruitVo().getSeq();
			
			// 이미 작성한 내용을 추가로 불러오기
			List<EducationVo> educationList = recruitDao.selectEducationList(seq);
			recruit.setEducationList(educationList);
			
			List<CareerVo> careerList = recruitDao.selectCareerList(seq);
			recruit.setCareerList(careerList);
			
			List<CertificateVo> certificateList = recruitDao.selectCertificateList(seq);
			recruit.setCertificateList(certificateList);
		}
		else {
			recruit.setRecruitVo(recruitVo);
		}
				
		return recruit;
	}

	@Override
	@Transactional
	public Map<String, Object> saveRecruit(RecruitMainVo recruit) {
		// TODO Auto-generated method stub
		Map<String, Object> results = new HashMap<>();
		
		RecruitVo recruitVo = recruit.getRecruitVo();
		List<EducationVo> educationList = recruit.getEducationList();
		List<CareerVo> careerList = recruit.getCareerList();
		List<CertificateVo> certificateList = recruit.getCertificateList();
		
		
		RecruitVo recruitTempVo = recruitDao.selectRecruit(recruitVo);	// 있는지 확인
		
		// 이미 제출 상태이면 추가 제출 X
		if (recruitTempVo != null && "Y".equals(recruitTempVo.getSubmit())) {
			results.put("success", "N");
			results.put("message", "이미 제출된 지원서입니다.");
			
			return results;
		}
		
		// 1. 값 검증
		//int validationCnt = validationRecruit(recruit, results);
		
		//if (validationCnt != 0) {
		//	results.put("success", "N");
		//	results.put("message", "입력값 검증에 실패했습니다.");
		//	return results;
		//}
		
		int queryResult;
		
		// 처음 저장/제출
		if (recruitTempVo == null) {
			queryResult = recruitDao.insertRecruit(recruitVo);
			
			if (queryResult == 0) {
				results.put("success", "N");
				results.put("message", "입사 지원서 저장에 실패했습니다.");
				
				return results;
			}
		} else {
			boolean isChanged = !recruitVo.equals(recruitTempVo);
			
			if(isChanged) {
				recruitVo.setSeq(recruitTempVo.getSeq());
				queryResult = recruitDao.updateRecruit(recruitVo);
			
				if (queryResult == 0) {
					results.put("success", "N");
					results.put("message", "입사 지원서 업데이트에 실패했습니다.");
					return results;
				}
			}
		}
		
		String seq = recruitDao.selectRecruit(recruitVo).getSeq();	// 다른 데이터 들에 Seq를 넣기 위함
		// 그냥 위에서 첫 입력인지 확인해서 delete하는 것을 모아놓을까? 근데 하나의 흐름인데 구분하는 것이...
		
		//학력
		queryResult = recruitDao.deleteEducationList(seq);			// 근데 첫 입력이면 0일 수도 있는거잔아
		if (educationList != null && educationList.size() != 0) {
			
			// 현재 프로젝트의 환경에서 람다 지원X
			//educationList.forEach(education -> education.setSeq(seq));
			
			for(EducationVo education: educationList) {
				education.setSeq(seq);
			}
			
			queryResult = recruitDao.insertEducationList(educationList);
			// 들어온 데이터가 전부 득어가지 않았다.
			if (queryResult != educationList.size()) {
				throw new RuntimeException("학력 정보 저장 중 에러가 발생했습니다.");
			}
		}

		// 경력
		queryResult = recruitDao.deleteCareerList(seq);			// 근데 첫 입력이면 0일 수도 있는거잔아
		if (careerList != null && careerList.size() != 0) {
			
			// 현재 프로젝트의 환경에서 람다 지원X
			//careerList.forEach(career -> career.setSeq(seq));
			
			for (CareerVo career: careerList) {
				career.setSeq(seq);
			}
			
			queryResult = recruitDao.insertCareerList(careerList);
			// 들어온 데이터가 전부 득어가지 않았다.
			if (queryResult != careerList.size()) {
				throw new RuntimeException("경력 정보 저장 중 에러가 발생했습니다.");
			}
		}
		
		// 자겨
		queryResult = recruitDao.deleteCertificateList(seq);			// 근데 첫 입력이면 0일 수도 있는거잔아
		if (certificateList != null && certificateList.size() != 0) {
			
			// 현재 프로젝트의 환경에서 람다 지원X
			//certificateList.forEach(certificate -> certificate.setSeq(seq));
			
			for(CertificateVo certificate: certificateList) {
				certificate.setSeq(seq);
			}
			
			queryResult = recruitDao.insertCertificateList(certificateList);
			// 들어온 데이터가 전부 득어가지 않았다.
			if (queryResult != certificateList.size()) {
				throw new RuntimeException("자격증 정보 저장 중 에러가 발생했습니다.");
			}
		}
		
		results.put("success", "Y");
		return results;
	}

	private int validationRecruit(RecruitMainVo recruit, Map<String, Object> results) {
		
		String[] errorRecruitVo = validationRecruitVo(recruit.getRecruitVo());
		String[] errorEducationList = validationEducationList(recruit.getEducationList());
		String[] errorCareerList = validationCareerList(recruit.getCareerList());
		String[] errorCertificateList = validationCertificateList(recruit.getCertificateList());
		
		
		int count = 0;
		
		if (errorRecruitVo == null || errorRecruitVo.length != 0) {
			results.put("errorRecruitVo", errorRecruitVo);
			count++;
		}
		
		if (errorEducationList == null || errorEducationList.length != 0) {
			results.put("errorEducationList", errorEducationList);
			count++;
		}
		
		if (errorCareerList == null || errorCareerList.length != 0) {
			results.put("errorCareerList", errorCareerList);
			count++;
		}
		
		if (errorCertificateList == null || errorCertificateList.length != 0) {
			results.put("errorCertificateList", errorCertificateList);
			count++;
		}
		
		return count;
	}

	
	private String[] validationRecruitVo(RecruitVo recruitVo) {
		// TODO Auto-generated method stub
		return null;
	}
	
	private String[] validationEducationList(List<EducationVo> list) {
		// TODO Auto-generated method stub
		return null;
	}

	private String[] validationCareerList(List<CareerVo> careerList) {
		// TODO Auto-generated method stub
		return null;
	}
	
	private String[] validationCertificateList(List<CertificateVo> certificateList) {
		// TODO Auto-generated method stub		
		return null;
	}
}
