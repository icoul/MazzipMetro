package com.go.mazzipmetro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.ReviewDAO;
import com.go.mazzipmetro.vo.AttachFileVO;
import com.go.mazzipmetro.vo.ReviewVO;

@Service
public class ReviewService implements IService{

	@Autowired
	private ReviewDAO dao;

	// 
	public int add(ReviewVO vo) {
		
		int result = dao.add(vo);
		
		return 0;
	}
	
	public int add_file(AttachFileVO avo) {
		
		
		int result = dao.add_file(avo);
		return result;
	}

	
	
}


