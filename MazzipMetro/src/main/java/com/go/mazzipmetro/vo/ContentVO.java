package com.go.mazzipmetro.vo;

public class ContentVO {
	String restSeq;  // 업장번호
	String userSeq;  // 유저번호
	String contentSeq;  // 컨텐츠번호
	String contentBuyDate;  // 컨텐츠구매일자
	String contentLimit;  // 컨텐츠기한
	String contentStatus;   // 컨텐츠상태
	
	String contentName; //컨텐츠명
	String contentPrice; //컨텐츠가격
	
	private RestaurantVO item; //레스토랑 VO쓰기위해 써줌 
	
	public ContentVO(){} //기본생성자
	
	public ContentVO(String restSeq, String userSeq, String contentSeq, String contentBuyDate, String contentLimit,
			String contentStatus, String contentName, RestaurantVO item, String contentPrice) {
		this.restSeq = restSeq;
		this.userSeq = userSeq;
		this.contentSeq = contentSeq;
		this.contentBuyDate = contentBuyDate;
		this.contentLimit = contentLimit;
		this.contentStatus = contentStatus;
		this.contentName = contentName;
		this.item = item;
		this.contentPrice = contentPrice;
		
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

	public String getContentSeq() {
		return contentSeq;
	}

	public void setContentSeq(String contentSeq) {
		this.contentSeq = contentSeq;
	}

	public String getContentBuyDate() {
		return contentBuyDate;
	}

	public void setContentBuyDate(String contentBuyDate) {
		this.contentBuyDate = contentBuyDate;
	}

	public String getContentLimit() {
		return contentLimit;
	}

	public void setContentLimit(String contentLimit) {
		this.contentLimit = contentLimit;
	}

	public String getContentStatus() {
		return contentStatus;
	}

	public void setContentStatus(String contentStatus) {
		this.contentStatus = contentStatus;
	}

	public String getContentName() {
		return contentName;
	}

	public void setContentName(String contentName) {
		this.contentName = contentName;
	}

	public RestaurantVO getItem() {
		return item;
	}

	public void setItem(RestaurantVO item) {
		this.item = item;
	}

	public String getContentPrice() {
		return contentPrice;
	}

	public void setContentPrice(String contentPrice) {
		this.contentPrice = contentPrice;
	}

	
}
