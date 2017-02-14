package com.go.mazzipmetro.vo;

public class RankingVO {
	
	private String parameter;
	private String value;
	
	
	public RankingVO(){}
	
	public RankingVO(String parameter, String value) {
		this.parameter = parameter;
		this.value = value;
	}

	public String getParameter() {
		return parameter;
	}

	public void setParameter(String parameter) {
		this.parameter = parameter;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
