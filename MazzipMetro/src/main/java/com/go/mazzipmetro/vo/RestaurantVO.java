package com.go.mazzipmetro.vo;

public class RestaurantVO {

	private String restSeq;		// (PK)	업장번호(PK)	NUMBER	NOT NULL
	private String userSeq;		// (FK)	유저번호(FK)	NUMBER	NOT NULL
	private String gradeSeq;	// (FK)	업장등급(FK)	NUMBER	NOT NULL
	private String restName;	// 업장이름	VARCHAR2(30)	NOT NULL
	private String restPhone;	// 업장전화번호	VARCHAR2(12)	NOT NULL
	private String restImg;		// 업장대표이미지	VARCHAR2(100)	NULL
	private String restOldAddr;	// 업장지번주소	VARCHAR2(200)	NOT NULL
	private String restNewAddr;	// 업장도로명주소	VARCHAR2(200)	NULL
	private String restZIndex;	// 업장Z인덱스	VARCHAR2(30)	NOT NULL
	private String dongId;		// (FK) 업장동(FK)	VARCHAR2(10)	NOT NULL
	private String metroId;		// (FK)	업장소속지하철(FK)	VARCHAR2(10)	NOT NULL
	private String restRegDate;	// 업장등록일자	DATE	NOT NULL
	private String restVisitor;	// 업장방문수	NUMBER	NULL
	private String restStatus;	// 업장상태	NUMBER	NOT NULL
	
	public RestaurantVO(){}
	
	public RestaurantVO(String restSeq, String userSeq, String gradeSeq, String restName, String restPhone,
			String restImg, String restOldAddr, String restNewAddr, String restZIndex, String dongId, String metroId,
			String restRegDate, String restVisitor, String restStatus) {
		super();
		this.restSeq = restSeq;
		this.userSeq = userSeq;
		this.gradeSeq = gradeSeq;
		this.restName = restName;
		this.restPhone = restPhone;
		this.restImg = restImg;
		this.restOldAddr = restOldAddr;
		this.restNewAddr = restNewAddr;
		this.restZIndex = restZIndex;
		this.dongId = dongId;
		this.metroId = metroId;
		this.restRegDate = restRegDate;
		this.restVisitor = restVisitor;
		this.restStatus = restStatus;
	}

	public String getRestSeq() {
		return restSeq;
	}

	public void setRestSeq(String restSeq) {
		this.restSeq = restSeq;
	}

	public String getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}

	public String getGradeSeq() {
		return gradeSeq;
	}

	public void setGradeSeq(String gradeSeq) {
		this.gradeSeq = gradeSeq;
	}

	public String getRestName() {
		return restName;
	}

	public void setRestName(String restName) {
		this.restName = restName;
	}

	public String getRestPhone() {
		return restPhone;
	}

	public void setRestPhone(String restPhone) {
		this.restPhone = restPhone;
	}

	public String getRestImg() {
		return restImg;
	}

	public void setRestImg(String restImg) {
		this.restImg = restImg;
	}

	public String getRestOldAddr() {
		return restOldAddr;
	}

	public void setRestOldAddr(String restOldAddr) {
		this.restOldAddr = restOldAddr;
	}

	public String getRestNewAddr() {
		return restNewAddr;
	}

	public void setRestNewAddr(String restNewAddr) {
		this.restNewAddr = restNewAddr;
	}

	public String getRestZIndex() {
		return restZIndex;
	}

	public void setRestZIndex(String restZIndex) {
		this.restZIndex = restZIndex;
	}

	public String getDongId() {
		return dongId;
	}

	public void setDongId(String dongId) {
		this.dongId = dongId;
	}

	public String getMetroId() {
		return metroId;
	}

	public void setMetroId(String metroId) {
		this.metroId = metroId;
	}

	public String getRestRegDate() {
		return restRegDate;
	}

	public void setRestRegDate(String restRegDate) {
		this.restRegDate = restRegDate;
	}

	public String getRestVisitor() {
		return restVisitor;
	}

	public void setRestVisitor(String restVisitor) {
		this.restVisitor = restVisitor;
	}

	public String getRestStatus() {
		return restStatus;
	}

	public void setRestStatus(String restStatus) {
		this.restStatus = restStatus;
	}
	
	
}
