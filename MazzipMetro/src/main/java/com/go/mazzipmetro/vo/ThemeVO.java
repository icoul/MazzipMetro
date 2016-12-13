package com.go.mazzipmetro.vo;

public class ThemeVO {

	private String themeSeq;
	private String reviewSeq;
	private String restSeq;
	private String theme;
	
	public ThemeVO() {}

	public ThemeVO(String themeSeq, String reviewSeq, String restSeq, String theme) {
		this.themeSeq = themeSeq;
		this.reviewSeq = reviewSeq;
		this.restSeq = restSeq;
		this.theme = theme;
	}

	public String getThemeSeq() {
		return themeSeq;
	}

	public void setThemeSeq(String themeSeq) {
		this.themeSeq = themeSeq;
	}

	public String getReviewSeq() {
		return reviewSeq;
	}

	public void setReviewSeq(String reviewSeq) {
		this.reviewSeq = reviewSeq;
	}

	public String getRestSeq() {
		return restSeq;
	}

	public void setRestSeq(String restSeq) {
		this.restSeq = restSeq;
	}

	public String getTheme() {
		return theme;
	}

	public void setTheme(String theme) {
		this.theme = theme;
	}
	
	
	
}
