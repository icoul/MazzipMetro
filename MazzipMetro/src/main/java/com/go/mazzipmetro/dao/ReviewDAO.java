
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

	public List<HashMap<String,String>> getReviewList(String restseq) {
		List<HashMap<String,String>> reviewList = sqlSession.selectList("review.getReviewList", restseq);
		return reviewList;
	}

	public List<HashMap<String,String>> getReviewImageList() {
		List<HashMap<String,String>> reviewImageList = sqlSession.selectList("review.getReviewImageList");
		return reviewImageList;
	}

	public List<HashMap<String, String>> getReviewImageList(String reviewseq) {
		List<HashMap<String,String>> reviewImageList = sqlSession.selectList("review.getReviewImageListByReviewSeq",reviewseq);
		return reviewImageList;
	}

	public String getLargeReviewImageName(String revimgseq) {
		String reviewImageName = sqlSession.selectOne("review.getLargeReviewImageName",revimgseq);
		return reviewImageName;
	}

	public List<HashMap<String, String>> getAgeLineChartList(String restseq) {
		List<HashMap<String,String>> agelineChartList = sqlSession.selectList("review.getAgeLineChartList", restseq);
		return agelineChartList;
	}

	public List<HashMap<String, String>> getGenderChartList(String restseq) {
		List<HashMap<String,String>> genderChartList = sqlSession.selectList("review.getGenderChartList", restseq);
		return genderChartList;
	}

	public int addReview(ReviewVO rvo) {
		
		int result = sqlSession.insert("review.reviewAdd", rvo);
		return result;
	}

	public String getReviewSeq(ReviewVO rvo) {
		
		String Seq = sqlSession.selectOne("review.getReviewSeq", rvo);
		return Seq;
	}

	public int addReviewImg(HashMap<String, String> map) {
		int result = sqlSession.insert("review.addReviewImg",map);
		return result;
	}
}