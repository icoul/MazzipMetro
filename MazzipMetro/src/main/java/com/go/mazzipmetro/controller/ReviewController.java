package com.go.mazzipmetro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	
	@RequestMapping(value="add.eat", method={RequestMethod.GET} ) 
	public String reviewAdd() {
		
		return "/review/reviewAdd";  
		// /DoubleFileAttachTest/src/main/webapp/WEB-INF/views/add.jsp 파일을 생성한다.
	}
}
