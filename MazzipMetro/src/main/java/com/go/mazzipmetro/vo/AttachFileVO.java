package com.go.mazzipmetro.vo;


public class AttachFileVO {

	private int           revImgSeq;     
	private int			  reviewSeq;
	private String        reviewImg;	       
	private String        reviewThumbImg;   
	private int           reviewImageStatus; 
	
	
	
	
	public AttachFileVO() { }


	

	public AttachFileVO(int revImgSeq, int reviewSeq, String reviewImg, String reviewThumbImg, int reviewImageStatus) {
		super();
		this.revImgSeq = revImgSeq;
		this.reviewSeq = reviewSeq;
		this.reviewImg = reviewImg;
		this.reviewThumbImg = reviewThumbImg;
		this.reviewImageStatus = reviewImageStatus;
	}




	public int getRevImgSeq() {
		return revImgSeq;
	}




	public void setRevImgSeq(int revImgSeq) {
		this.revImgSeq = revImgSeq;
	}




	public int getReviewSeq() {
		return reviewSeq;
	}




	public void setReviewSeq(int reviewSeq) {
		this.reviewSeq = reviewSeq;
	}




	public String getReviewImg() {
		return reviewImg;
	}




	public void setReviewImg(String reviewImg) {
		this.reviewImg = reviewImg;
	}




	public String getReviewThumbImg() {
		return reviewThumbImg;
	}




	public void setReviewThumbImg(String reviewThumbImg) {
		this.reviewThumbImg = reviewThumbImg;
	}




	public int getReviewImageStatus() {
		return reviewImageStatus;
	}




	public void setReviewImageStatus(int reviewImageStatus) {
		this.reviewImageStatus = reviewImageStatus;
	}
	
	
	
	
}
