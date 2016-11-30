<<<<<<< HEAD
package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.ReviewDAO;


@Service
public class ReviewService implements IService{

	@Autowired
	private ReviewDAO dao;

	public HashMap<String,String> getRestaurant(String restseq) {
		HashMap<String,String> restvo = dao.getRestaurant(restseq);
		return restvo;
	}

	public List<HashMap<String,String>> getReviewList(String restseq) {
		List<HashMap<String,String>> reviewList = dao.getReviewList(restseq);
		return reviewList;
	}

	public List<HashMap<String,String>> getReviewImageList() {
		List<HashMap<String,String>> reviewImageList = dao.getReviewImageList();
		return reviewImageList;
	}

	public List<HashMap<String, String>> getReviewImageList(String reviewseq) {
		List<HashMap<String,String>> reviewImageList = dao.getReviewImageList(reviewseq);
		return reviewImageList;
	}

	public String getLargeReviewImageName(String revimgseq) {
		String reviewImageName = dao.getLargeReviewImageName(revimgseq);
		return reviewImageName;
	}

	public List<HashMap<String, String>> getAgeLineChartList(String restseq) {
		List<HashMap<String,String>> agelineChartList = dao.getAgeLineChartList(restseq);
		return agelineChartList;
	}

	public List<HashMap<String, String>> getGenderChartList(String restseq) {
		List<HashMap<String,String>> genderChartList = dao.getGenderChartList(restseq);
		return genderChartList;
	}
}
=======
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


>>>>>>> c866be3402640d50fe4dc5d3445c043b32ab569c
