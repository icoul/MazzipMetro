
package com.go.mazzipmetro.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewCommentVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserAliasVO;

@Repository
public class ReviewDAO implements IDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 리뷰 이미지배열을 담은 배열 가져오기
	public List<List<String>> getReviewImageList(List<String> reviewSeq) {
				
		List<List<String>> ReviewImageListList = new ArrayList<>();
		
		for(int i=0; i<reviewSeq.size(); i++)
		{	
			String revSeq  = reviewSeq.get(i);
			
			List<String> imgList = sqlSession.selectList("review.getReviewImageList",revSeq);
			
			ReviewImageListList.add(imgList);
		}
		System.out.println("ddddddddddddddddd"+ReviewImageListList);
		
		return ReviewImageListList;
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
	public int upReviewHit(String reviewSeq) {
		int rusult =sqlSession.update("review.upReviewHit", reviewSeq);
		return rusult;
	}
	public int getReviewHit(String reviewSeq) {
		int reviewHit = sqlSession.selectOne("review.getReviewHit", reviewSeq);
		return reviewHit;
	}
	public int getReviewDownHit(String reviewSeq) {
		int reviewHit = sqlSession.update("review.getReviewDownHit", reviewSeq);
		return reviewHit;
	}
	public int insertLiker(HashMap<String, String> map) {
		int insertLiker = sqlSession.insert("review.insertLiker", map);
		return insertLiker;
	}
	public List<String> getLikers(String UserSeq) {
		List<String> likers = sqlSession.selectList("review.getLikers", UserSeq);
		return likers;
	}
	public int delLiker(String reviewSeq, String userSeq) {
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("reviewSeq", reviewSeq);
		map.put("userSeq",userSeq);
		
		int delLiker = sqlSession.delete("review.delLikers", map);
		return delLiker;
	}
	public int getMyReviewCount(String restSeq, String userSeq) {
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("restSeq", restSeq);
		map.put("userSeq", userSeq);
		
		int reviewCount = sqlSession.selectOne("review.MyReviewCount", map);
		return reviewCount;
	}
	// 실시간 리뷰 가져오기
	public List<HashMap<String, String>> getRealReview(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlSession.selectList("review.getRealReview",map);
		return list;
	}
	
	// 사용자의 칭호를 update한다.
	public int userAliasUpdate(HashMap<String, String> map) {
		return sqlSession.update("user.userAliasUpdate", map);
	}
	
	// 사용자의 칭호를 insert한다.
	public int userAliasInsert(HashMap<String, String> map) {
		return sqlSession.update("user.userAliasInsert", map);
	}
	
	// 해당 업장 정보를 가져온다.
	public RestaurantVO getRestaurant(String restSeq) {
		return sqlSession.selectOne("restaurant.adminRestEditInfo", restSeq);
	}
	
	// 칭호테이블 존재여부 검사
	public boolean isAliasExist(HashMap<String, String> map) {
		int result = sqlSession.selectOne("user.isAliasExist", map);
		return (result > 0)?true:false;
	}
	
	// 사용자 칭호 aliasId별로 해당 테이블 가져온다.
	public UserAliasVO getUserAlias(HashMap<String, String> map) {
		return sqlSession.selectOne("user.getUserAlias", map);
	}
	
	// tbl_review에 사용자가 썼던 리뷰가 있는지 확인한다.
	public int isFirstReview(HashMap<String, String> map) {
		return sqlSession.selectOne("review.isFirstReview", map);
	}
	
	// 해당 구에 동 리스트 구하기
	public List<String> getDongList(String guId) {
		return sqlSession.selectList("review.getDongList", guId);
	}
	
	//동칭호의 aliasNum을 구한다.
	public int getDongAliasNum(HashMap<String, String> dongMap) {
		return sqlSession.selectOne("review.getDongAliasNum", dongMap);
	}
	
	//테마 넣기
		public int addTheme(String[] themeArr, String reviewSeq, String restSeq) {
			HashMap<String, String> map = new HashMap<String, String>();
			int result=0;
			for(int i=0; i<themeArr.length; i++)
			{
				map.put("reviewSeq", reviewSeq);
				map.put("restSeq", restSeq);
				map.put("theme", themeArr[i]);
				result = sqlSession.insert("review.insertTheme", map);
			}
			return result;
		}
		
	// 해당 회원의 리뷰 1개를 가져온다(조건 : 지하철 Id)
	public List<HashMap<String, String>> getBestReview(List<String> userSeqList, String metroId) {
		
		List<HashMap<String, String>> bestReview = new ArrayList<HashMap<String, String>>();
		HashMap<String, String> map = new HashMap<String, String>();
		
		for (int i = 0; i < userSeqList.size(); i++) {
			map.put("userSeq", userSeqList.get(i));
			map.put("metroId", metroId);
		
			HashMap<String, String> resultMap = sqlSession.selectOne("review.getBestReview", map);
			bestReview.add(resultMap);
		}
		
		return bestReview;
	}
	// tbl_reivewVisitor에 데이터 삽입
	public void insetVisitor(HashMap<String, String> visitor) {
		sqlSession.insert("review.insertVisitor", visitor);
		
	}
	
	// 리뷰 폼에 담아줄 업장 정보 가져오기
	public HashMap<String, String> getRest(String restSeq) {
		HashMap<String, String> getRest = sqlSession.selectOne("restaurant.getRestaurant", restSeq);
		return getRest;
	}
	
	// 동칭호의 aliasNum을 구한다.
	public int checkDongAliasNum(HashMap<String, String> dongMap) {
		return sqlSession.selectOne("review.checkDongAliasNum", dongMap);
	}
	
	//한 업장의 분위기, 가격, 서비스, 맛 , 총 평점의 평점을 가져온다.
	public HashMap<String, String> getReviewAvgScore(String restSeq) {
		HashMap<String, String> reviewAvgScore = sqlSession.selectOne("getReviewAvgScore" , restSeq);
		return reviewAvgScore;
	}
	
	//리뷰 댓글쓰기
	public int insertReviewComment(HashMap<String,String> hashMap) {
		int result = sqlSession.insert("insertReviewComment", hashMap);
		return result;
	}
	public String getReviewCommentMaxGroupNo() {
		String groupNo = sqlSession.selectOne("getReviewCommentMaxGroupNo");
		return groupNo;
	}
	public List<ReviewCommentVO> getReviewCommentList(String reviewSeq) {
		List<ReviewCommentVO> reviewCommentList = sqlSession.selectList("getReviewCommentList", reviewSeq);
		return reviewCommentList;
	}
	public int updateReviewComment(HashMap<String, String> hashMap) {
		int result = sqlSession.update("updateReviewComment", hashMap);
		return result;
	}	


}