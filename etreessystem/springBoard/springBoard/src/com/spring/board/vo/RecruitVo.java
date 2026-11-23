package com.spring.board.vo;

import java.util.Objects;

public class RecruitVo {
	private String seq;			// 기본키
	private String name;		// 이름
	private String birth;		// 생일
	private String gender;		// 성별
	private String phone;		// 연락처
	private String email;		// 이메일
	private String addr;		// 주소
	private String location;	// 희망근무지
	private String workType;	// 근무형태
	private String submit;		// 제출여부
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getWorkType() {
		return workType;
	}
	public void setWorkType(String workType) {
		this.workType = workType;
	}
	public String getSubmit() {
		return submit;
	}
	public void setSubmit(String submit) {
		this.submit = submit;
	}
	
	@Override
	public boolean equals(Object o) {
		
		if(this == o) return true;
		if(!(o instanceof RecruitVo)) return false;
		RecruitVo other = (RecruitVo) o;
		
		
		return Objects.equals(this.name, other.name) 
				&& Objects.equals(this.birth, other.birth) 
				&& Objects.equals(this.gender, other.gender) 
				&& Objects.equals(this.phone, other.phone) 
				&& Objects.equals(this.email, other.email) 
				&& Objects.equals(this.addr, other.addr) 
				&& Objects.equals(this.location, other.location) 
				&& Objects.equals(this.workType, other.workType) 
				&& Objects.equals(this.submit, other.submit);
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(name, birth, gender, phone, email, addr, location, workType);
	}
}
