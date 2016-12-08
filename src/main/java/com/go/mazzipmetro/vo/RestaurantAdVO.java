package com.go.mazzipmetro.vo;

public class RestaurantAdVO {

	private String restSeq;
	private String[] adImg;
	private String AdImgStatus;
	
	
	public RestaurantAdVO(){}


	public RestaurantAdVO(String restSeq, String[] adImg, String adImgStatus) {
		super();
		this.restSeq = restSeq;
		this.adImg = adImg;
		AdImgStatus = adImgStatus;
	}


	public String getRestSeq() {
		return restSeq;
	}


	public void setRestSeq(String restSeq) {
		this.restSeq = restSeq;
	}


	public String[] getAdImg() {
		return adImg;
	}


	public void setAdImg(String[] adImg) {
		this.adImg = adImg;
	}


	public String getAdImgStatus() {
		return AdImgStatus;
	}


	public void setAdImgStatus(String adImgStatus) {
		AdImgStatus = adImgStatus;
	}
	
}
