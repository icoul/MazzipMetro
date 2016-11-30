package com.go.mazzipmetro.vo;

public class ReviewVO {
	private String reviewSeq; 
	private String userSeq; 
	private String restSeq;   
	private String reviewTitle;
	private String reviewContent;
	private String reviewScore;
	private String reviewHit;
	private String reviewRegDate;  
	private String reviewAvgScore; 
	private String reviewStatus;
	
	public ReviewVO(){}
	public ReviewVO(String reviewSeq, String userSeq, String restSeq, String reviewTitle, String reviewContent,
			String reviewScore, String reviewHit, String reviewRegDate, String reviewAvgScore, String reviewStatus) {
		this.reviewSeq = reviewSeq;
		this.userSeq = userSeq;
		this.restSeq = restSeq;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.reviewScore = reviewScore;
		this.reviewHit = reviewHit;
		this.reviewRegDate = reviewRegDate;
		this.reviewAvgScore = reviewAvgScore;
		this.reviewStatus = reviewStatus;
	}
	public String getReviewSeq() {
		return reviewSeq;
	}
	public void setReviewSeq(String reviewSeq) {
		this.reviewSeq = reviewSeq;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getRestSeq() {
		return restSeq;
	}
	public void setRestSeq(String restSeq) {
		this.restSeq = restSeq;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public String getReviewScore() {
		return reviewScore;
	}
	public void setReviewScore(String reviewScore) {
		this.reviewScore = reviewScore;
	}
	public String getReviewHit() {
		return reviewHit;
	}
	public void setReviewHit(String reviewHit) {
		this.reviewHit = reviewHit;
	}
	public String getReviewRegDate() {
		return reviewRegDate;
	}
	public void setReviewRegDate(String reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}
	public String getReviewAvgScore() {
		return reviewAvgScore;
	}
	public void setReviewAvgScore(String reviewAvgScore) {
		this.reviewAvgScore = reviewAvgScore;
	}
	public String getReviewStatus() {
		return reviewStatus;
	}
	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}
	
	
}