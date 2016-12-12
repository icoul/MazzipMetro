package com.go.mazzipmetro.vo;

public class RankingRestVO {
	
	private String parameter;
	private String value;
	
	
	public RankingRestVO(){}
	
	public RankingRestVO(String parameter, String value) {
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
