package com.go.mazzipmetro.vo;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {

	private int    reviewSeq;   	// 리뷰번호
	private int	   userSeq;			// 유저번호
	private int	   restSeq;			// 업장번호
	private String reviewTitle; 	// 리뷰제목
	private String reviewImg;		// 리뷰이미지
	private String reviewContent;   // 리뷰내용
	private int    priceScore;		// 가격평점
	private int    moodScore;		// 분위기평점
	private int    serviceScore;	// 서비스평점
	private int    tasteScore;		// 맛평점
	private int    totalScore;		// 총합평점
	private int    reviewHit;		// 리뷰방문객
	private int	   reviewStatus;	// 리뷰 상태 스테이터스 (0:삭제 1: 존재)
	private String regDate;     	// 글쓴시간
	
	private MultipartFile[] attach;
	
		
	public ReviewVO() {
		super();
	}

	public ReviewVO(int reviewSeq, int userSeq, int restSeq, String reviewTitle, String reviewImg, String reviewContent,
			int priceScore, int moodScore, int serviceScore, int tasteScore, int totalScore, int reviewHit,
			int reviewStatus, String regDate) {
		super();
		this.reviewSeq = reviewSeq;
		this.userSeq = userSeq;
		this.restSeq = restSeq;
		this.reviewTitle = reviewTitle;
		this.reviewImg = reviewImg;
		this.reviewContent = reviewContent;
		this.priceScore = priceScore;
		this.moodScore = moodScore;
		this.serviceScore = serviceScore;
		this.tasteScore = tasteScore;
		this.totalScore = totalScore;
		this.reviewHit = reviewHit;
		this.reviewStatus = reviewStatus;
		this.regDate = regDate;
	}

	public int getReviewSeq() {
		return reviewSeq;
	}

	public void setReviewSeq(int reviewSeq) {
		this.reviewSeq = reviewSeq;
	}

	public int getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(int userSeq) {
		this.userSeq = userSeq;
	}

	public int getRestSeq() {
		return restSeq;
	}

	public void setRestSeq(int restSeq) {
		this.restSeq = restSeq;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public String getReviewImg() {
		return reviewImg;
	}

	public void setReviewImg(String reviewImg) {
		this.reviewImg = reviewImg;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public int getPriceScore() {
		return priceScore;
	}

	public void setPriceScore(int priceScore) {
		this.priceScore = priceScore;
	}

	public int getMoodScore() {
		return moodScore;
	}

	public void setMoodScore(int moodScore) {
		this.moodScore = moodScore;
	}

	public int getServiceScore() {
		return serviceScore;
	}

	public void setServiceScore(int serviceScore) {
		this.serviceScore = serviceScore;
	}

	public int getTasteScore() {
		return tasteScore;
	}

	public void setTasteScore(int tasteScore) {
		this.tasteScore = tasteScore;
	}

	public int getTotalScore() {
		return totalScore;
	}

	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}

	public int getReviewHit() {
		return reviewHit;
	}

	public void setReviewHit(int reviewHit) {
		this.reviewHit = reviewHit;
	}

	public int getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(int reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public MultipartFile[] getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile[] attach) {
		this.attach = attach;
	}

	
	
}
