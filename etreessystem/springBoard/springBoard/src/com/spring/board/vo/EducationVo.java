package com.spring.board.vo;

public class EducationVo {
	private String eduSeq;			// 복합키(학교 번호)
	private String seq;				// 복합키(지원서 번호)
	private String schoolName;		// 학교명
	private String division;		// 구분
	private String startPeriod;		// 시작일
	private String endPeriod;		// 종료일
	private String major;			// 전공
	private String grade;			// 학점
	private String location;		// 소재지
	
	public String getEduSeq() {
		return eduSeq;
	}
	public void setEduSeq(String eduSeq) {
		this.eduSeq = eduSeq;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getStartPeriod() {
		return startPeriod;
	}
	public void setStartPeriod(String startPeriod) {
		this.startPeriod = startPeriod;
	}
	public String getEndPeriod() {
		return endPeriod;
	}
	public void setEndPeriod(String endPeriod) {
		this.endPeriod = endPeriod;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
}
