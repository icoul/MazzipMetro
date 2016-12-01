package com.go.mazzipmetro.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.ReviewDAO;
import com.go.mazzipmetro.vo.AttachFileVO;
import com.go.mazzipmetro.vo.ReviewVO;


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
	
	public int add_file(AttachFileVO avo) {
		
		
		//int result = dao.add_file(avo);
		int result = 0;
		return result;
	}

	public int addReview(ReviewVO rvo, ArrayList<String> imageList) {
		
		HashMap<String, String> map = new HashMap<String, String>(); 
		
		int result = dao.addReview(rvo);
		if(result == 1)
		{
			String Seq = dao.getReviewSeq(rvo);
			
			if(Seq != null)
			{
				map.put("Seq", Seq);
				
				for(int i =0; i<imageList.size(); i++)
				{
					map.put("ReviewImg", imageList.get(i));
					
					result = dao.addReviewImg(map); 
				}
			}
			else
			{
				System.out.println("Seq를 받아오지 못했습니다.");
			}
			
		}
		
		return result;
	}// end of addReview

}
