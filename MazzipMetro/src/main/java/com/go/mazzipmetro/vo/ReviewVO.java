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
   
   // 동현 추가 : 사용자가 기입하는 복수개가 가능한 음식점 태그(칭호부여에 사용함)
   private String[] reviewBgTag;
   private String[] reviewMdTag;
   private String restName; // 업장 이름 추가 (검색시 뿌려줄 용도)
   
   private String reviewBTag;
   private String reviewMTag;

   public ReviewVO() {
	
   }

   public ReviewVO(String reviewSeq, String userSeq, String restSeq, String reviewTitle, String reviewContent,
		String reviewHit, String reviewMood, String reviewTaste, String reviewPrice, String reviewService,
		String reviewAvgScore, String reviewRegDate, String reviewStatus, String[] reviewBgTag, String[] reviewMdTag, String reviewBTag, String reviewMTag, String restName) {
	
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
	this.reviewBgTag = reviewBgTag;
	this.reviewMdTag = reviewMdTag;
	this.reviewBTag = reviewBTag;
	this.reviewMTag = reviewMTag;
	this.restName = restName;
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

	public String[] getReviewBgTag() {
		return reviewBgTag;
	}

	public void setReviewBgTag(String[] reviewBgTag) {
		this.reviewBgTag = reviewBgTag;
	}

	public String[] getReviewMdTag() {
		return reviewMdTag;
	}

	public void setReviewMdTag(String[] reviewMdTag) {
		this.reviewMdTag = reviewMdTag;
	}

	public String getReviewBTag() {
		return reviewBTag;
	}

	public void setReviewBTag(String reviewBTag) {
		this.reviewBTag = reviewBTag;
	}

	public String getReviewMTag() {
		return reviewMTag;
	}

	public void setReviewMTag(String reviewMTag) {
		this.reviewMTag = reviewMTag;
	}

	public String getRestName() {
		return restName;
	}

	public void setRestName(String restName) {
		this.restName = restName;
	}
   
   
   
   
   
   
}