package com.go.mazzipmetro.vo;

public class ReviewCommentVO {
	private String commentSeq; 	// 글번호
	private String reviewSeq; 	// 댓글쓴 리뷰번호
	private String userSeq; 	// 작성자 번호
	private String content; 	// 글내용 -- clob
	private String regDate; 	// 글쓴시간
	private String status; 		// 글삭제여부 1:사용가능한글, 0:삭제된글
	private String commentCount;// 댓글수
	private String groupno; 	// 답변글쓰기에 있어서 그룹번호, 원글(부모글)과 답변글은 동일한 groupno를 가진다.
								// 댓글은 원글이 삭제되면 자동적으로 삭제되어야 한다.
								// 답변글이 아닌 원글(부모글)인 경우 groupno의 값은 groupno컬럼의 최대값(max)+1로 한다.
	
	private String fk_seq;  	// fk_seq컬럼은 절대로 foreign key가 아니다.
								// fk_seq컬럼은 자신의 글(답변글)에 있어서 원글(부모글)이 누구인지에 대한
								// 정보값이다.
								// 답변글쓰기에 있어서 답변글이라면 fk_seq컬럼의 값은 원글(부모글)의 seq컬럼의 값을
								// 가지게 되며 답변글이 아닌 원글일 경우 0을 가지도록 한다.
	
	private String depthno; 	// 답변글쓰기에 있어서 답변글 이라면 원글의 deptno + 1을 가지게 되며,
								// 답변글이 아닌 원글일 경우 0을 가지도록 한다.
	
	
	private String userName;   //조인시 글쓴이 이름
	private String userProfile;//조인시 글쓴이 프로필 사진명
	private String agoDay;    //몇 일전에 썼는지 알려주기 위해
	private String agoHour;    //몇 시간전에 썼는지 알려주기위해
	private String agoMinute;  //몇 분분전에 썼는지 알려주기위해
	public ReviewCommentVO(){}

	
	
	public ReviewCommentVO(String commentSeq, String reviewSeq, String userSeq, String content, String regDate,
			String status, String commentCount, String groupno, String fk_seq, String depthno) {
		this.commentSeq = commentSeq;
		this.reviewSeq = reviewSeq;
		this.userSeq = userSeq;
		this.content = content;
		this.regDate = regDate;
		this.status = status;
		this.commentCount = commentCount;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
	}


	public String getCommentSeq() {
		return commentSeq;
	}

	public void setCommentSeq(String commentSeq) {
		this.commentSeq = commentSeq;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getFk_seq() {
		return fk_seq;
	}

	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}

	public String getDepthno() {
		return depthno;
	}

	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}



	public String getUserName() {
		return userName;
	}



	public void setUserName(String userName) {
		this.userName = userName;
	}



	public String getUserProfile() {
		return userProfile;
	}



	public void setUserProfile(String userProfile) {
		this.userProfile = userProfile;
	}



	public String getAgoDay() {
		return agoDay;
	}



	public void setAgoDay(String agoDay) {
		this.agoDay = agoDay;
	}



	public String getAgoHour() {
		return agoHour;
	}



	public void setAgoHour(String agoHour) {
		this.agoHour = agoHour;
	}



	public String getAgoMinute() {
		return agoMinute;
	}



	public void setAgoMinute(String agoMinute) {
		this.agoMinute = agoMinute;
	}

	

	
	
	
}
