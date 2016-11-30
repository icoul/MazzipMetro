package com.go.mazzipmetro.vo;

import org.springframework.web.multipart.MultipartFile;

public class UserVO {
	private String userSeq; 		// 유저번호(PK)
	private String gradeSeq; 		// 유저등급(FK)
	private String userName; 		// 유저이름
	private String userEmail;		// 유저이메일
	private String userPw;			// 유저비밀번호
	private String userGender;		// 유저성별	
/*	
    private String userYear;		// 유저생일
	private String userMonth;		// 유저생일
	private String userDate;		// 유저생일
*/	
	private String userBirthDay;	// 유저생일
	private String userPhone;		// 유저핸드폰	
	private String userRegDate;		// 유저가입일	
	private String userPoint;		// 유저포인트	
	private String userRandomBox;	// 유저랜덤박스갯수	
	private String userStatus;		// 유저구분	
	private String status;			// 유저상태
	private String userProfile;		// 유저사진(이미지)
	
	private String fileName;		// WAS(톰캣)에 저장될 파일명
	private String orgFilename;		// 진짜 파일명 (사용자가 파일을 업로드 하거나 파일을 다운로드 할 때 사용되어지는 파일명)
	private String fileSize; 		// 파일크기
	
	private MultipartFile attach; 	// 진짜 파일 ==> WAS(톰캣) 디스크에 저장됨.

	public UserVO(){}
	public UserVO(String userSeq, String gradeSeq, String userName, String userEmail, String userPw, String userGender,
			/*String userYear, String userMonth, String userDate,*/ String userBirtyDay, String userPhone, String userRegDate, String userPoint, String userRandomBox,
			String userStatus, String status, String fileName, String orgFilename, String fileSize) {
		super();
		this.userSeq = userSeq;
		this.gradeSeq = gradeSeq;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPw = userPw;
		this.userGender = userGender;
		/*this.userYear = userYear;
		this.userMonth = userMonth;
		this.userDate = userDate;*/
		this.userBirthDay = userBirtyDay;
		this.userPhone = userPhone;
		this.userRegDate = userRegDate;
		this.userPoint = userPoint;
		this.userRandomBox = userRandomBox;
		this.userStatus = userStatus;
		this.status = status;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
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
	
	/*
	public String getAllBirthday() {
		return userYear + userMonth + userDate;
	} 

	public String getUserYear() {
		return userYear;
	}
	public void setUserYear(String userYear) {
		this.userYear = userYear;
	}
	public String getUserMonth() {
		return userMonth;
	}
	public void setUserMonth(String userMonth) {
		this.userMonth = userMonth;
	}
	public String getUserDate() {
		return userDate;
	}
	public void setUserDate(String userDate) {
		this.userDate = userDate;
	}*/
	
	
	public String getUserBirthDay() {
		return userBirthDay;
	}
	public void setUserBirthDay(String userBirthDay) {
		this.userBirthDay = userBirthDay;
	}
	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserRegDate() {
		return userRegDate;
	}

	public void setUserRegDate(String userRegDate) {
		this.userRegDate = userRegDate;
	}

	public String getUserPoint() {
		return userPoint;
	}

	public void setUserPoint(String userPoint) {
		this.userPoint = userPoint;
	}

	public String getUserRandomBox() {
		return userRandomBox;
	}

	public void setUserRandomBox(String userRandomBox) {
		this.userRandomBox = userRandomBox;
	}

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFilename() {
		return orgFilename;
	}

	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
}
