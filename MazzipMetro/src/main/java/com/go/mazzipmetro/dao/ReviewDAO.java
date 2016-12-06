
package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.ReviewVO;

@Repository
public class ReviewDAO implements IDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

/*	public List<HashMap<String,String>> getReviewList(String restseq) {
		List<HashMap<String,String>> reviewList = sqlSession.selectList("review.getReviewList", restseq);
		return reviewList;
	}*/
	// 리뷰 이미지 가져오기
	public List<HashMap<String,String>> getReviewImageList() {
		List<HashMap<String,String>> reviewImageList = sqlSession.selectList("review.getReviewImageList");
		return reviewImageList;
	}
	// 리뷰시퀀스로 리뷰 이미지 가져오기
	public List<HashMap<String, String>> getReviewImageList(String reviewseq) {
		List<HashMap<String,String>> reviewImageList = sqlSession.selectList("review.getReviewImageListByReviewSeq",reviewseq);
		return reviewImageList;
	}
	// 리뷰 이미지 크게 가져오기
	public String getLargeReviewImageName(String revimgseq) {
		String reviewImageName = sqlSession.selectOne("review.getLargeReviewImageName",revimgseq);
		return reviewImageName;
	}
	// 나이 차트
	public List<HashMap<String, String>> getAgeLineChartList(String restseq) {
		List<HashMap<String,String>> agelineChartList = sqlSession.selectList("review.getAgeLineChartList", restseq);
		return agelineChartList;
	}
	// 성별 차트
	public List<HashMap<String, String>> getGenderChartList(String restseq) {
		List<HashMap<String,String>> genderChartList = sqlSession.selectList("review.getGenderChartList", restseq);
		return genderChartList;
	}
	// 리뷰 추가하기
	public int addReview(ReviewVO rvo) {
		
		int result = sqlSession.insert("review.reviewAdd", rvo);
		return result;
	}
	// 리뷰 시퀀스 가져오기
	public String getReviewSeq(ReviewVO rvo) {
		
		String Seq = sqlSession.selectOne("review.getReviewSeq", rvo);
		return Seq;
	}
	// 리뷰 이미지 추가하기 
	public int addReviewImg(HashMap<String, String> map) {
		int result = sqlSession.insert("review.addReviewImg",map);
		return result;
	}
	//리뷰 총 개수 가져오기 
	public int getTotalCount(String restSeq) {

		int result = sqlSession.selectOne("review.getTotalCount", restSeq);
		
		return result;
	}

}