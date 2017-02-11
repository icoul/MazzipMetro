package com.go.mazzipmetro.vo;

import java.util.HashMap;

import com.go.mazzipmetro.dao.UserDAO;

public class UserAliasVO {

	private String aliasSeq;         //고유번호
	private String userSeq;
	private String aliasType;       //dongId, metroId, guId, restBgTag, restMdTag
	private String aliasId ;          // 해당 id 및 tag : 1171010100, 2005, 한식,양식.../고기,물고기,채소,밥,면,분식, 
	private String aliasName;     // 입문자, 숙련자, 마스터
	private String aliasStatus; 	// 0: 사용가능, 1:삭제됨.
	
	private String aliasIdName;		// aliasType에 따라, dongName, metroName, guName, 태그(대분류/중분류)인 경우 aliasId와 같다.
	private int aliasNum; 		// 정복한 맛집 숫자.

	public UserAliasVO(){}
	public UserAliasVO(String aliasSeq, String userSeq, String aliasType, String aliasId, String aliasName,
			String aliasStatus, String aliasIdName, int aliasNum) {
		super();
		this.aliasSeq = aliasSeq;
		this.userSeq = userSeq;
		this.aliasType = aliasType;
		this.aliasId = aliasId;
		this.aliasName = aliasName;
		this.aliasStatus = aliasStatus;
		setAliasIdName(aliasType, aliasId); 
		this.aliasNum = aliasNum;
	}
	public String getAliasSeq() {
		return aliasSeq;
	}
	public void setAliasSeq(String aliasSeq) {
		this.aliasSeq = aliasSeq;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getAliasType() {
		return aliasType;
	}
	public void setAliasType(String aliasType) {
		this.aliasType = aliasType;
	}
	public String getAliasId() {
		return aliasId;
	}
	public void setAliasId(String aliasId) {
		this.aliasId = aliasId;
	}
	public String getAliasName() {
		return aliasName;
	}
	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}
	public String getAliasStatus() {
		return aliasStatus;
	}
	public void setAliasStatus(String aliasStatus) {
		this.aliasStatus = aliasStatus;
	}
	public String getAliasIdName() {
		return aliasIdName;
	}
	
	// 대분류, 중분류인 경우에는 aliasId가 aliasIdName이 된다.
	// 지하철, 동, 구 인경우에는 해당 명을 구해 온다.
	public void setAliasIdName(String aliasType, String aliasId) {
		if("restMdTag".equals(aliasType) || "restBgTag".equals(aliasType)){
			this.aliasIdName = aliasId;			
		} else {
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("aliasType", aliasType);
			map.put("aliasId", aliasId);
			
			this.aliasIdName = new UserDAO().getAliasIdName(map);
		}
		
	}
	public int getAliasNum() {
		return aliasNum;
	}
	public void setAliasNum(int aliasNum) {
		this.aliasNum = aliasNum;
	}
	
	
	
	
	
	
	
	
}
