package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.UserDAO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserAttendVO;
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

	public int userExist(String userSeq) {
		int isUserExist = dao.userExist(userSeq);
		return isUserExist;
	}

	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int insertAttend(String userSeq) {
		int n =  dao.insertAttend(userSeq);
		int m = dao.updateUserPoint1(userSeq);
		
		return (n+m);
	}


	public int userLoginToday(String userSeq) {
		int n = dao.userLoginToday(userSeq);
		return n;
	}


	public UserAttendVO getUserAttend(String userSeq) {
		UserAttendVO vo = dao.getUserAttend(userSeq);
		return vo;
	}

	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int updateUserPoint_RandomBox(HashMap<String, String> hashMap) {
		int n = dao.updateUserPoint2(hashMap);
		int m = dao.updateRandomBox(hashMap);
		return n+m;
	}


	public int updateUserAttend(HashMap<String, String> hashMap) {
		int n = dao.updateUserAttend(hashMap);
		return n;
	}


	public int userLoginContinueCheck(HashMap<String, String> hashMap) {
		int isLoginContinue = dao.userLoginContinueCheck(hashMap);
		return isLoginContinue;
	}


	public List<String> myReviewList(String userSeq) {
		List<String> myReviewList = dao.myReviewList(userSeq);
		return myReviewList;
	}


	

}

