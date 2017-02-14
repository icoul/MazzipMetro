package com.go.mazzipmetro.vo;

public class GradeVO {
	private String gradeSeq;
	private String gradeName;
	private String gradeExp;
	private String gradeReviewNum;
	private String gradeScore;
	
	public GradeVO(){}

	public GradeVO(String gradeSeq, String gradeName, String gradeExp, String gradeReviewNum, String gradeScore) {
		this.gradeSeq = gradeSeq;
		this.gradeName = gradeName;
		this.gradeExp = gradeExp;
		this.gradeReviewNum = gradeReviewNum;
		this.gradeScore = gradeScore;
	}

	public String getGradeSeq() {
		return gradeSeq;
	}

	public void setGradeSeq(String gradeSeq) {
		this.gradeSeq = gradeSeq;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public String getGradeExp() {
		return gradeExp;
	}

	public void setGradeExp(String gradeExp) {
		this.gradeExp = gradeExp;
	}

	public String getGradeReviewNum() {
		return gradeReviewNum;
	}

	public void setGradeReviewNum(String gradeReviewNum) {
		this.gradeReviewNum = gradeReviewNum;
	}

	public String getGradeScore() {
		return gradeScore;
	}

	public void setGradeScore(String gradeScore) {
		this.gradeScore = gradeScore;
	}
	
	
}
