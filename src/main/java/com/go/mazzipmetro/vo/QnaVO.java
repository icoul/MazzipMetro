package com.go.mazzipmetro.vo;

public class QnaVO {
	private String qnaSeq; //QnA번호
	private String userSeq; //글쓴이 번호
	private String qnaInquiry; //질문 종류
	private String qnaSubject; //제목
	private String qnaContent; //내용
	private String qnaRegDate; //질문작성일자
	private String qnaProgress; //질문 처리과정
	private String fk_seq; // 답변글 번호 질문글은 기본값으로 0
	private String qnaStatus; //질문 상태 0이 존재, 1일 삭제
	
	 QnaVO(){}

	public QnaVO(String qnaSeq, String userSeq, String qnaInquiry, String qnaSubject, String qnaContent,
			String qnaRegDate, String qnaProgress, String fk_seq, String qnaStatus) {
		this.qnaSeq = qnaSeq;
		this.userSeq = userSeq;
		this.qnaInquiry = qnaInquiry;
		this.qnaSubject = qnaSubject;
		this.qnaContent = qnaContent;
		this.qnaRegDate = qnaRegDate;
		this.qnaProgress = qnaProgress;
		this.fk_seq = fk_seq;
		this.qnaStatus = qnaStatus;
	}

	public String getQnaSeq() {
		return qnaSeq;
	}

	public void setQnaSeq(String qnaSeq) {
		this.qnaSeq = qnaSeq;
	}

	public String getUserSeq() {
		return userSeq;
	}

	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}

	public String getQnaInquiry() {
		return qnaInquiry;
	}

	public void setQnaInquiry(String qnaInquiry) {
		this.qnaInquiry = qnaInquiry;
	}

	public String getQnaSubject() {
		return qnaSubject;
	}

	public void setQnaSubject(String qnaSubject) {
		this.qnaSubject = qnaSubject;
	}

	public String getQnaContent() {
		return qnaContent;
	}

	public void setQnaContent(String qnaContent) {
		this.qnaContent = qnaContent;
	}

	public String getQnaRegDate() {
		return qnaRegDate;
	}

	public void setQnaRegDate(String qnaRegDate) {
		this.qnaRegDate = qnaRegDate;
	}

	public String getQnaProgress() {
		return qnaProgress;
	}

	public void setQnaProgress(String qnaProgress) {
		this.qnaProgress = qnaProgress;
	}

	public String getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}

	public String getQnaStatus() {
		return qnaStatus;
	}

	public void setQnaStatus(String qnaStatus) {
		this.qnaStatus = qnaStatus;
	}
	
	
	 
}
