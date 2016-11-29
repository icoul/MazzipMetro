package com.go.mazzipmetro.vo;

public class UserVO {
	
	private String userSeq;     
	private String gradeSeq;
	private String userName; 
	private String userEmail; 
	private String userPw;
	private String userGender;
	private String userBirthday; 
	private String userPhone;
	private String userRegdate;        
	private String userProfile; 
	private String userPoint;      
	private String userExp;     
	private String userStation;
	private String userSort;      
	private String userStatus;
	
	public UserVO(){} //기본생성자
	public UserVO(String userSeq, String gradeSeq, String userName, String userEmail, String userPw, String userGender,
			String userBirthday, String userPhone, String userRegdate, String userProfile, String userPoint,
			String userExp, String userStation, String userSort, String userStatus) {
		this.userSeq = userSeq;
		this.gradeSeq = gradeSeq;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPw = userPw;
		this.userGender = userGender;
		this.userBirthday = userBirthday;
		this.userPhone = userPhone;
		this.userRegdate = userRegdate;
		this.userProfile = userProfile;
		this.userPoint = userPoint;
		this.userExp = userExp;
		this.userStation = userStation;
		this.userSort = userSort;
		this.userStatus = userStatus;
	}
	
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getGradeSeq() {
		return gradeSeq;
	}
	public void setGradeSeq(String gradeSeq) {
		this.gradeSeq = gradeSeq;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserBirthday() {
		return userBirthday;
	}
	public void setUserBirthday(String userBirthday) {
		this.userBirthday = userBirthday;
	}
	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	public String getUserRegdate() {
		return userRegdate;
	}
	public void setUserRegdate(String userRegdate) {
		this.userRegdate = userRegdate;
	}
	public String getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(String userProfile) {
		this.userProfile = userProfile;
	}
	public String getUserPoint() {
		return userPoint;
	}
	public void setUserPoint(String userPoint) {
		this.userPoint = userPoint;
	}
	public String getUserExp() {
		return userExp;
	}
	public void setUserExp(String userExp) {
		this.userExp = userExp;
	}
	public String getUserStation() {
		return userStation;
	}
	public void setUserStation(String userStation) {
		this.userStation = userStation;
	}
	public String getUserSort() {
		return userSort;
	}
	public void setUserSort(String userSort) {
		this.userSort = userSort;
	}
	public String getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}
	
	
	
	
}
