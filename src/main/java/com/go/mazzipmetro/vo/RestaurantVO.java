package com.go.mazzipmetro.vo;

public class RestaurantVO {
	
	private String restSeq; /* 업장번호 */
	private String userSeq; /* 유저번호 */
	private String gradeSeq; /* 업장등급 */
	private String restName; /* 업장이름 */
	private String restPhone; /* 업장전화번호 */
	private String restImg; /* 업장대표이미지 */
	private String restAddr; /* 업장지번주소 */
	private String restNewAddr; /* 업장도로명주소 */
	private String restLatitude; /* 업장 위도 */
	private String restLongitude; /* 업장 경도 */
	private String restZIndex; /* 업장Z인덱스 */
	private String dongId; /* 업장동 */
	private String metroId; /* 업장소속지하철 */
	private String restRegDate; /* 업장등록일자 */
	private String restVisitor; /* 업장방문수 */
	private String restStatus; /* 업장상태 */
	private String restContent; /* 업장소개글*/
	private String restBgTag; /* 업장태그 대분류 */
	private String restMdTag; /* 업장태그 중분류 */
	
	private String gradeName; /*등급명*/
	private String guName;  /*구 명*/
	private String dongName; /* 동 명 */
	private String metroName; /* 지하철명*/
	private String guId; /*구 */
	
	public RestaurantVO(){}

	public RestaurantVO(String restSeq, String userSeq, String gradeSeq, String restName, String restPhone,
			String restImg, String restAddr, String restNewAddr, String restLatitude, String restLongitude,
			String restZIndex, String dongId, String metroId, String restRegDate, String restVisitor, String restStatus,
			String restContent, String restBgTag, String restMdTag, String gradeName, String dongName,
			String metroName, String guName, String guId) {
		this.restSeq = restSeq;
		this.userSeq = userSeq;
		this.gradeSeq = gradeSeq;
		this.restName = restName;
		this.restPhone = restPhone;
		this.restImg = restImg;
		this.restAddr = restAddr;
		this.restNewAddr = restNewAddr;
		this.restLatitude = restLatitude;
		this.restLongitude = restLongitude;
		this.restZIndex = restZIndex;
		this.dongId = dongId;
		this.metroId = metroId;
		this.restRegDate = restRegDate;
		this.restVisitor = restVisitor;
		this.restStatus = restStatus;
		this.restContent = restContent;
		this.restBgTag = restBgTag;
		this.restMdTag = restMdTag;
		this.gradeName = gradeName;
		this.guName = guName;
		this.dongName = dongName;
		this.metroName = metroName;
		this.guId = guId;
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

	public String getRestAddr() {
		return restAddr;
	}

	public void setRestAddr(String restAddr) {
		this.restAddr = restAddr;
	}

	public String getRestNewAddr() {
		return restNewAddr;
	}

	public void setRestNewAddr(String restNewAddr) {
		this.restNewAddr = restNewAddr;
	}

	public String getRestLatitude() {
		return restLatitude;
	}

	public void setRestLatitude(String restLatitude) {
		this.restLatitude = restLatitude;
	}

	public String getRestLongitude() {
		return restLongitude;
	}

	public void setRestLongitude(String restLongitude) {
		this.restLongitude = restLongitude;
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

	public String getRestContent() {
		return restContent;
	}

	public void setRestContent(String restContent) {
		this.restContent = restContent;
	}

	public String getRestBgTag() {
		return restBgTag;
	}

	public void setRestBgTag(String restBgTag) {
		this.restBgTag = restBgTag;
	}

	public String getRestMdTag() {
		return restMdTag;
	}

	public void setRestMdTag(String restMdTag) {
		this.restMdTag = restMdTag;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public String getDongName() {
		return dongName;
	}

	public void setDongName(String dongName) {
		this.dongName = dongName;
	}

	public String getMetroName() {
		return metroName;
	}

	public void setMetroName(String metroName) {
		this.metroName = metroName;
	}

	public String getGuName() {
		return guName;
	}

	public void setGuName(String guName) {
		this.guName = guName;
	}

	public String getGuId() {
		return guId;
	}

	public void setGuId(String guId) {
		this.guId = guId;
	}
}
