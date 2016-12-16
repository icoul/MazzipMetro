
package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.CouponVO;
import com.go.mazzipmetro.vo.GradeVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserAliasVO;
import com.go.mazzipmetro.vo.UserAttendVO;
import com.go.mazzipmetro.vo.UserVO;

@Repository
public class UserDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int userRegister(UserVO vo) {
		int n = sqlSession.insert("user.userRegister", vo);
		return n;
	}



	public int UserLogin(HashMap<String, String> map) {
		int n = sqlSession.selectOne("user.logincheck", map);
		return n;
	}


	public UserVO getLoginUser(String userEmail) {
		UserVO loginUser = sqlSession.selectOne("user.getLoginUser", userEmail);
		return loginUser;
	}
	
	public List<String> alignTest() {
		List<String> list = sqlSession.selectList("mazzipMetro.alignTest");
		return list;
	}


	public int userEdit(UserVO vo) {
		int n = sqlSession.update("user.userEdit", vo);
		return n;
	}

	public int userDelete(String userSeq) {
		int result = sqlSession.update("user.userDelete", userSeq);
		return result;
	}

	public int userPoint(String userSeq) {
		int userPoint = sqlSession.selectOne("user.userPoint", userSeq);
		return userPoint;
	}

	public int restCount(String userSeq) {
		int restCount = sqlSession.selectOne("user.restCount", userSeq);
		return restCount;
	}

	public int userContent(String userSeq) {
		int userContent = sqlSession.selectOne("user.userContent", userSeq);
		return userContent;
	}
	
	public int userCoupon(String userSeq) {
		int userCoupon = sqlSession.selectOne("user.userCoupon", userSeq);
		return userCoupon;
	}

	public int reviewCount(String userSeq) {
		int reviewCount = sqlSession.selectOne("user.reviewCount", userSeq);
		return reviewCount;
	}

	public int qnaCount(String userSeq) {
		int qnaCount = sqlSession.selectOne("user.qnaCount", userSeq);
		return qnaCount;
	}
	
	public List<HashMap<String,String>> myReviewList(HashMap<String, String> map) {
		List<HashMap<String,String>> myReviewList = sqlSession.selectList("user.myReviewList", map);
		return myReviewList;
	}


	public int userExist(String userSeq) {
		int isUserExist = sqlSession.selectOne("userExist", userSeq);
		return isUserExist;
	}


	public int reviewDelete(String reviewSeq) {
		int del = sqlSession.update("user.reviewDelete", reviewSeq);
		return del;
	}

	public int userReviewCount(HashMap<String, String> map) {
		int count = sqlSession.selectOne("user.userReviewCount", map);
		return count;
	}

	public int emailDuplicatecheck(String userEmail) {
		// TODO Auto-generated method stub
		return 0;
	}
	

	// 동현_칭호 동이름, 지하철이름, 구이름을 구하기
	public String getAliasIdName(HashMap<String, String> map) {
		return sqlSession.selectOne("user.getAliasIdName", map);
	}


	public int userWithdrawal(String userSeq) {
		int result = sqlSession.update("user.userWithdrawal", userSeq);
		return result;
	}

	public String getUserEmail(HashMap<String, String> map) {
		String userEmail = sqlSession.selectOne("user.getUserEmail", map);
		return userEmail;
	}



	public int getUserExists(HashMap<String, String> map) {
		int pwCount = sqlSession.selectOne("user.getUserExists", map);
		return pwCount;
	}



	public int updatePwdUser(HashMap<String, String> map) {
		int pwNewCount = sqlSession.update("user.updatePwdUser", map);
		return pwNewCount;
	}

////////////////////////////////////////////////////////은석22 //////////////////////////////////////////////////////////////	
	//1
	public int insertAttend(String userSeq) {
		int n =  sqlSession.insert("insertAttend", userSeq);
		return n;
	}


	//2
	public int updateUserPointandExp(HashMap<String, String> hashMap) {
		int m =  sqlSession.update("updateUserPointandExp", hashMap);
		return m;
	}

	//3
	public int userLoginToday(String userSeq) {
		int n = sqlSession.selectOne("userLoginToday", userSeq);
		return n;
	}
	//4
	public UserAttendVO getUserAttend(String userSeq) {
		UserAttendVO vo = sqlSession.selectOne("getUserAttend", userSeq);
		return vo;
	}

	//5
	public int updateUserAttend(HashMap<String, String> hashMap) {
		int n = sqlSession.update("updateUserAttend", hashMap);
		return n;
	}

	//6
	public int updateUserPoint2(HashMap<String, String> hashMap) {
		int n = sqlSession.update("updateUserPoint2", hashMap);
		return n;
	}


	//7
	public int updateRandomBox(HashMap<String, String> hashMap) {
		int f = sqlSession.update("updateRandomBox", hashMap);
		return f;
	}


	//8
	public int userLoginContinueCheck(HashMap<String, String> hashMap) {
		int isLoginContinue = sqlSession.selectOne("userLoginContinueCheck", hashMap);
		return isLoginContinue;
	}

	//9
	public int updateUserGrade(HashMap<String, String> hashMap) {
		int n = sqlSession.update("updateUserGrade", hashMap);
		return n;
	}


	//10
	public String getUserGradeName(String gradeSeq) {
		String userGradeName = sqlSession.selectOne("getUserGradeName", gradeSeq);
		return userGradeName;
	}


	//11
	public List<GradeVO> getUserGradeList() {
		List<GradeVO> userGradeList = sqlSession.selectList("getUserGradeList");
		return userGradeList;
	}
	//12
	public List<UserAliasVO> getUserGuAliasList(String userSeq) {
		List<UserAliasVO> userGuAliasList = sqlSession.selectList("getUserGuAliasList", userSeq);
		return userGuAliasList;
	}


	//13
	public List<UserAliasVO> getUserDongAliasList(String userSeq) {
		List<UserAliasVO> userDongAliasList = sqlSession.selectList("getUserDongAliasList", userSeq);
		return userDongAliasList;
	}


	//14
	public List<UserAliasVO> getUserMetroAliasList(String userSeq) {
		List<UserAliasVO> userMetroAliasList = sqlSession.selectList("getUserMetroAliasList", userSeq);
		return userMetroAliasList;
	}


	//15
	public List<UserAliasVO> getUserRestTagAliasList(String userSeq) {
		List<UserAliasVO> userRestTagAliasList = sqlSession.selectList("getUserRestTagAliasList", userSeq);
		return userRestTagAliasList;
	}


	//16
	public int getUserAliasCount(HashMap<String,String> hashMap) {
		int userDongAliasCount = sqlSession.selectOne("getUserAliasCount", hashMap);
		return userDongAliasCount;
	}


	//17
	public int updateUserPoint(HashMap<String,String> hashMap) {
		int n = sqlSession.update("updateUserPoint",hashMap);
		return n;
	}
	//18
	public int updateAlertUpgradeStatus(HashMap<String,String> hashMap) {
		int n = sqlSession.update("updateAlertUpgradeStatus", hashMap);
		return n;
	}


	//19
	public int updateAlertRandomBoxStatus(String userSeq) {
		int n = sqlSession.update("updateAlertRandomBoxStatus", userSeq);
		return n;
	}
	//20
	public int minusRandomBox(HashMap<String, String> hashMap) {
		int n = sqlSession.update("minusRandomBox", hashMap);
		return n;
	}

////////////////////////////////////////////////////////은석 //////////////////////////////////////////////////////////////	

	
	//21
	public UserVO getLoginUserByUserSeq(String userSeq) {
		UserVO loginUser = sqlSession.selectOne("getLoginUserByUserSeq", userSeq);
		return loginUser;
	}
	//22
	public int minusUserPoint(HashMap<String, String> hashMap) {
		int m = sqlSession.update("minusUserPoint", hashMap);
		return m;
	}
	
////////////////////////////////////////////////////////은석22//////////////////////////////////////////////////////////////	

	// 사용자가 추천 받은 맛집이 있는지 확인해서, 있다면, restSeq를 반환한다.
	public String haveMazzipRecom(String userSeq) {
		return sqlSession.selectOne("mazzipMetro.haveMazzipRecom", userSeq);
	}







}

