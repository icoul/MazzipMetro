
package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO implements IDAO{
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	public HashMap<String,String> getRestaurant(String restseq) {
		HashMap<String,String> restvo = sqlsession.selectOne("review.getRestaurant", restseq);
		return restvo;
	}

	public List<HashMap<String,String>> getReviewList(String restseq) {
		List<HashMap<String,String>> reviewList = sqlsession.selectList("review.getReviewList", restseq);
		return reviewList;
	}

	public List<HashMap<String,String>> getReviewImageList() {
		List<HashMap<String,String>> reviewImageList = sqlsession.selectList("review.getReviewImageList");
		return reviewImageList;
	}

	public List<HashMap<String, String>> getReviewImageList(String reviewseq) {
		List<HashMap<String,String>> reviewImageList = sqlsession.selectList("review.getReviewImageListByReviewSeq",reviewseq);
		return reviewImageList;
	}

	public String getLargeReviewImageName(String revimgseq) {
		String reviewImageName = sqlsession.selectOne("review.getLargeReviewImageName",revimgseq);
		return reviewImageName;
	}

	public List<HashMap<String, String>> getAgeLineChartList(String restseq) {
		List<HashMap<String,String>> agelineChartList = sqlsession.selectList("review.getAgeLineChartList", restseq);
		return agelineChartList;
	}

	public List<HashMap<String, String>> getGenderChartList(String restseq) {
		List<HashMap<String,String>> genderChartList = sqlsession.selectList("review.getGenderChartList", restseq);
		return genderChartList;
	}
}
=======
package com.go.mazzipmetro.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.AttachFileVO;
import com.go.mazzipmetro.vo.ReviewVO;

@Repository
public class ReviewDAO implements IDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int add(ReviewVO vo) {
		
		int result = sqlSession.insert("review.add", vo); // 아이디 add , 파라미터값 vo
		return result;
		
		
	}
}

