
package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;
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



}
