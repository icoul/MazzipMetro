package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.CouponDAO;
import com.go.mazzipmetro.dao.RestaurantDAO;
import com.go.mazzipmetro.vo.CouponVO;
import com.go.mazzipmetro.vo.RestaurantVO;

@Controller
public class CouponService {
	
	@Autowired
	private CouponDAO dao;

	// 유저가 보유한 쿠폰 목록
	public List<CouponVO> getUserCoupon(String userSeq) {
		
		List<CouponVO> couponList = dao.getUserCoupon(userSeq);
		
		return couponList;
	}

	// 사업자가 발행한 쿠폰 목록
	public List<CouponVO> getBossCoupon(String userSeq) {
		List<CouponVO> couponList = dao.getBossCoupon(userSeq);
		
		return couponList;
	}

	// 쿠폰 등록을 위해 해당 사업자의 업장 정보 가져오기
	public List<RestaurantVO> getRestaurant(String userSeq) {
		
		List<RestaurantVO> restList = dao.getRestaurant(userSeq);
		
		return restList;
	}
	
	
	// 쿠폰 발행
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int couponBuy(HashMap<String, String> map) {
		
		int result = dao.couponBuy(map);
		
		return result;
	}
}
