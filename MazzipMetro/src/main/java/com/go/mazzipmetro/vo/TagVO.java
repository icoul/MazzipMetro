package com.go.mazzipmetro.vo;

import java.util.List;

public class TagVO {
	
	private String restSeq;
	private String bgCat;
	private List<String> mdCat;
	private String tagStatus;
	

	public TagVO(){}
	
	public TagVO(String restSeq, String bgCat, List<String> mdCat, String tagStatus) {
		this.restSeq = restSeq;
		this.bgCat = bgCat;
		this.mdCat = mdCat;
		this.tagStatus = tagStatus;
	}

	public String getBgCat() {
		return bgCat;
	}
	public void setBgCat(String bgCat) {
		this.bgCat = bgCat;
	}
	public List<String> getMdCat() {
		return mdCat;
	}
	public void setMdCat(List<String> list) {
		this.mdCat = list;
	}
	public String getRestSeq() {
		return restSeq;
	}
	
	public void setRestSeq(String restSeq) {
		this.restSeq = restSeq;
	}
	
	public String getTagStatus() {
		return tagStatus;
	}
	
	public void setTagStatus(String tagStatus) {
		this.tagStatus = tagStatus;
	}
	
	
	
}
