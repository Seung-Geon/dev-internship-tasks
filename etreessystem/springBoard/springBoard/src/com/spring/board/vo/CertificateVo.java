package com.spring.board.vo;

public class CertificateVo {
	
	private String certSeq;		// 복합키(자격증 번호)
	private String seq;			// 복합키(지원자 번호)
	private String qualifiName;	// 자격증 이름
	private String acquDate;	// 취득일
	private String organizeName;// 발급 기관명
	
	public String getCertSeq() {
		return certSeq;
	}
	public void setCertSeq(String certSeq) {
		this.certSeq = certSeq;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getQualifiName() {
		return qualifiName;
	}
	public void setQualifiName(String qualifiName) {
		this.qualifiName = qualifiName;
	}
	public String getAcquDate() {
		return acquDate;
	}
	public void setAcquDate(String acquDate) {
		this.acquDate = acquDate;
	}
	public String getOrganizeName() {
		return organizeName;
	}
	public void setOrganizeName(String organizeName) {
		this.organizeName = organizeName;
	}
	
	
}
