package com.go.mazzipmetro.vo;

public class CouponVO {

	private String couponSeq;       	//쿠폰번호   
	private String restSeq;            	//업장번호
	private String userSeq;             //유저번호  
	private String metroId;           	//지하철ID
	private String couponRegDate;       //쿠폰발행일       
	private String couponUserDate;      //쿠폰 유저 등록일     
	private String couponExpiryDate;    //쿠폰 유효기간         
	private String couponStatus;     	//쿠폰 상태 0:발행했습니다 // 1:유저가 획득했습니다 // 2:사용하여 소진되었습니다
	
	public CouponVO(){}
	
	public CouponVO(String couponSeq, String restSeq, String userSeq, String metroId, String couponRegDate,
			String couponUserDate, String couponExpiryDate, String couponStatus) {
		super();
		this.couponSeq = couponSeq;
		this.restSeq = restSeq;
		this.userSeq = userSeq;
		this.metroId = metroId;
		this.couponRegDate = couponRegDate;
		this.couponUserDate = couponUserDate;
		this.couponExpiryDate = couponExpiryDate;
		this.couponStatus = couponStatus;
	}

	public String getCouponSeq() {
		return couponSeq;
	}

	public void setCouponSeq(String couponSeq) {
		this.couponSeq = couponSeq;
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

	public String getMetroId() {
		return metroId;
	}

	public void setMetroId(String metroId) {
		this.metroId = metroId;
	}

	public String getCouponRegDate() {
		return couponRegDate;
	}

	public void setCouponRegDate(String couponRegDate) {
		this.couponRegDate = couponRegDate;
	}

	public String getCouponUserDate() {
		return couponUserDate;
	}

	public void setCouponUserDate(String couponUserDate) {
		this.couponUserDate = couponUserDate;
	}

	public String getCouponExpiryDate() {
		return couponExpiryDate;
	}

	public void setCouponExpiryDate(String couponExpiryDate) {
		this.couponExpiryDate = couponExpiryDate;
	}

	public String getCouponStatus() {
		return couponStatus;
	}

	public void setCouponStatus(String couponStatus) {
		this.couponStatus = couponStatus;
	}
}
