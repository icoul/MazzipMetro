package com.go.mazzipmetro.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.ReviewDAO;
import com.go.mazzipmetro.vo.AttachFileVO;
import com.go.mazzipmetro.vo.ReviewVO;


@Service
public class ReviewService implements IService{

	@Autowired
	private ReviewDAO dao;
	
	/*public List<HashMap<String,String>> getReviewList(String restseq) {
		List<HashMap<String,String>> reviewList = dao.getReviewList(restseq);
		return reviewList;
	}*/

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
			String reviewSeq = dao.getReviewSeq(rvo);
			
			if(reviewSeq != null)
			{
				map.put("reviewSeq", reviewSeq);
				
				for(int i =0; i<imageList.size(); i++)
				{
					System.out.println(imageList.get(i));
					map.put("reviewImg", imageList.get(i));
					
					result = dao.addReviewImg(map); 
				}
			}
			else
			{
				System.out.println("reviewSeq를 받아오지 못했습니다.");
			}
			
		}
		
		return result;
	}// end of addReview
	
	// 총리뷰수 알아오기 
	public int getTotalCount(String restSeq) {

		int result = dao.getTotalCount(restSeq);
		
		return result;
	}

	public int plusHit(String reviewSeq) {
		int result = dao.upReviewHit(reviewSeq);
		return result;
	}

	public int getHitScore(String reviewSeq) {
		int HitScore = dao.getReviewHit(reviewSeq);
		return HitScore;
	}

	public int insertLiker(HashMap<String, String> map) {
		int insertLiker =dao.insertLiker(map);
		return insertLiker;
	}

	public List<String> getLikers(String UserSeq) {
		List<String> likers = dao.getLikers(UserSeq);
		return likers;
	}

	public List<HashMap<String, String>> getRealReview(HashMap<String, String> map) {
		List<HashMap<String, String>> list = dao.getRealReview(map);
		return list;
	}

	public int getMyReviewCount(String restSeq, String userSeq) {
		int reviewCount = dao.getMyReviewCount(restSeq, userSeq);
		return reviewCount;
	}
	@Transactional
	public int delLiker(String reviewSeq, String userSeq) {
		
		int n = dao.getReviewDownHit(reviewSeq);
		int m = dao.delLiker(reviewSeq, userSeq);
		return (n+m);
	}

}
