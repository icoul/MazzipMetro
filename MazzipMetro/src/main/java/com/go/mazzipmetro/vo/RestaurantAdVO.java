package com.go.mazzipmetro.vo;

public class RestaurantAdVO {

	private String restSeq;
	private String[] adImg;
	
	
	public RestaurantAdVO(){}
	
	public RestaurantAdVO(String restSeq, String[] adImg) {
		super();
		this.restSeq = restSeq;
		this.adImg = adImg;
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
	
	
}
