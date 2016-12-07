package com.go.mazzipmetro.vo;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
   private String reviewSeq; 
   private String userSeq; 
   private String restSeq;   
   private String reviewTitle;
   private String reviewContent;
   private String reviewHit;
   private String reviewMood;
   private String reviewTaste;
   private String reviewPrice;
   private String reviewService;
   private String reviewAvgScore; 
   private String reviewRegDate;  
   private String reviewStatus;

   public ReviewVO() {
	
   }

   public ReviewVO(String reviewSeq, String userSeq, String restSeq, String reviewTitle, String reviewContent,
		String reviewHit, String reviewMood, String reviewTaste, String reviewPrice, String reviewService,
		String reviewAvgScore, String reviewRegDate, String reviewStatus) {
	
	this.reviewSeq = reviewSeq;
	this.userSeq = userSeq;
	this.restSeq = restSeq;
	this.reviewTitle = reviewTitle;
	this.reviewContent = reviewContent;
	this.reviewHit = reviewHit;
	this.reviewMood = reviewMood;
	this.reviewTaste = reviewTaste;
	this.reviewPrice = reviewPrice;
	this.reviewService = reviewService;
	this.reviewAvgScore = reviewAvgScore;
	this.reviewRegDate = reviewRegDate;
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
	
	public String getReviewHit() {
		return reviewHit;
	}
	
	public void setReviewHit(String reviewHit) {
		this.reviewHit = reviewHit;
	}
	
	public String getReviewMood() {
		return reviewMood;
	}
	
	public void setReviewMood(String reviewMood) {
		this.reviewMood = reviewMood;
	}
	
	public String getReviewTaste() {
		return reviewTaste;
	}
	
	public void setReviewTaste(String reviewTaste) {
		this.reviewTaste = reviewTaste;
	}
	
	public String getReviewPrice() {
		return reviewPrice;
	}
	
	public void setReviewPrice(String reviewPrice) {
		this.reviewPrice = reviewPrice;
	}
	
	public String getReviewService() {
		return reviewService;
	}
	
	public void setReviewService(String reviewService) {
		this.reviewService = reviewService;
	}
	
	public String getReviewAvgScore() {
		return reviewAvgScore;
	}
	
	public void setReviewAvgScore(String reviewAvgScore) {
		this.reviewAvgScore = reviewAvgScore;
	}
	
	public String getReviewRegDate() {
		return reviewRegDate;
	}
	
	public void setReviewRegDate(String reviewRegDate) {
		this.reviewRegDate = reviewRegDate;
	}
	
	public String getReviewStatus() {
		return reviewStatus;
	}
	
	public void setReviewStatus(String reviewStatus) {
		this.reviewStatus = reviewStatus;
	}
   
   
   
   
   
   
}