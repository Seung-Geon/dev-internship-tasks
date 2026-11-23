package com.spring.board.vo;

public class CareerVo {
	private String carSeq;		// 복합키(커리어 번호)
	private String seq;			// 복합키(지원자 번호)
	private String compName;	// 회사이름
	private String location;	// 근무지
	private String startPeriod;	// 입사일
	private String endPeriod;	// 퇴사일
	private String task;		// 직무
	private String salary;		// 연봉
	
	public String getCarSeq() {
		return carSeq;
	}
	public void setCarSeq(String carSeq) {
		this.carSeq = carSeq;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
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
	public String getTask() {
		return task;
	}
	public void setTask(String task) {
		this.task = task;
	}
	public String getSalary() {
		return salary;
	}
	public void setSalary(String salary) {
		this.salary = salary;
	}
	
	
	
}
