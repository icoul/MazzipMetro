package com.go.mazzipmetro.vo;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {
	
	private MultipartFile[] attach;

	public FileVO(){}
	
	public FileVO(MultipartFile[] attach) {
		super();
		this.attach = attach;
	}

	public MultipartFile[] getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile[] attach) {
		this.attach = attach;
	}
}
