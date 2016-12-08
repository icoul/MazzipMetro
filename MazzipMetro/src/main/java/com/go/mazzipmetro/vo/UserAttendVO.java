package com.go.mazzipmetro.vo;

public class UserAttendVO {
	private String attendSeq;
	private String userSeq;
	private String allAttendDay;
	private String continueAttendDay;
	private String contiueStatus; //연속출석중인지 체크 0이 연속출석중, 1이 연속출석X
	private String attendLastDay;
	private String userRandomBox ;
	
	public UserAttendVO(){}
	public UserAttendVO(String attendSeq, String userSeq, String allAttendDay, String continueAttendDay,
			String contiueStatus, String attendLastDay, String userRandomBox) {
		this.attendSeq = attendSeq;
		this.userSeq = userSeq;
		this.allAttendDay = allAttendDay;
		this.continueAttendDay = continueAttendDay;
		this.contiueStatus = contiueStatus;
		this.attendLastDay = attendLastDay;
		this.userRandomBox = userRandomBox;
	}
	public String getAttendSeq() {
		return attendSeq;
	}
	public void setAttendSeq(String attendSeq) {
		this.attendSeq = attendSeq;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getAllAttendDay() {
		return allAttendDay;
	}
	public void setAllAttendDay(String allAttendDay) {
		this.allAttendDay = allAttendDay;
	}
	public String getContinueAttendDay() {
		return continueAttendDay;
	}
	public void setContinueAttendDay(String continueAttendDay) {
		this.continueAttendDay = continueAttendDay;
	}
	public String getContiueStatus() {
		return contiueStatus;
	}
	public void setContiueStatus(String contiueStatus) {
		this.contiueStatus = contiueStatus;
	}
	public String getAttendLastDay() {
		return attendLastDay;
	}
	public void setAttendLastDay(String attendLastDay) {
		this.attendLastDay = attendLastDay;
	}
	public String getUserRandomBox() {
		return userRandomBox;
	}
	public void setUserRandomBox(String userRandomBox) {
		this.userRandomBox = userRandomBox;
	}
	
	
	
}
