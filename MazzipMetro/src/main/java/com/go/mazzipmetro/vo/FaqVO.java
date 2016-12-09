package com.go.mazzipmetro.vo;

public class FaqVO {
	private String faqSeq;
	private String faqType; //회원, 사업주, 음식점, 기타
	private String faqQuestion;  
	private String faqAnswer;   
	private String faqStatus;
	
	public FaqVO(){}
	public FaqVO(String faqSeq, String faqType, String faqQuestion, String faqAnswer, String faqStatus) {
		this.faqSeq = faqSeq;
		this.faqType = faqType;
		this.faqQuestion = faqQuestion;
		this.faqAnswer = faqAnswer;
		this.faqStatus = faqStatus;
	}
	public String getFaqSeq() {
		return faqSeq;
	}
	public void setFaqSeq(String faqSeq) {
		this.faqSeq = faqSeq;
	}
	public String getFaqType() {
		return faqType;
	}
	public void setFaqType(String faqType) {
		this.faqType = faqType;
	}
	public String getFaqQuestion() {
		return faqQuestion;
	}
	public void setFaqQuestion(String faqQuestion) {
		this.faqQuestion = faqQuestion;
	}
	public String getFaqAnswer() {
		return faqAnswer;
	}
	public void setFaqAnswer(String faqAnswer) {
		this.faqAnswer = faqAnswer;
	}
	public String getFaqStatus() {
		return faqStatus;
	}
	public void setFaqStatus(String faqStatus) {
		this.faqStatus = faqStatus;
	}    
}
