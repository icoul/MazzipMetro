package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.UserDAO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;

@Service
public class UserService implements IService {

	@Autowired
	private UserDAO dao;

	public int userRegister(UserVO vo) {
		int n = dao.userRegister(vo);
		return n;
	}

	
	public List<String> alignTest() {
		List<String> list = dao.alignTest();
		return list;
	}
	

	public int UserLogin(HashMap<String, String> map) {
		int n = dao.UserLogin(map);
		return n;
	}

	public UserVO getLoginUser(String userEmail) {
		UserVO loginuser = dao.getLoginUser(userEmail);
		return loginuser;
	}

	public int userEdit(UserVO vo) {
		int n = dao.userEdit(vo);
		return n;
	}


	public int userPoint(String userSeq) {
		int userPoint = dao.userPoint(userSeq);
		return userPoint;
	}


	public int restCount(String userSeq) {
		int restCount = dao.restCount(userSeq);
		return restCount;
	}


	public int userContent(String userSeq) {
		int userContent = dao.userContent(userSeq);
		return userContent;
	}


	public int userCoupon(String userSeq) {
		int userCoupon = dao.userCoupon(userSeq);
		return userCoupon;
	}


	public int userReviewCount(String userSeq) {
		int reviewCount = dao.reviewCount(userSeq);
		return reviewCount;
	}


	public int userQnaCount(String userSeq) {
		int qnaCount = dao.qnaCount(userSeq);
		return qnaCount;
	}




	

}

