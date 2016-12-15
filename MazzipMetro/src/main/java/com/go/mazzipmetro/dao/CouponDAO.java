package com.go.mazzipmetro.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.vo.CouponVO;
import com.go.mazzipmetro.vo.RestaurantVO;

@Controller
public class CouponDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 유저가 보유한 쿠폰 목록
	public List<CouponVO> getUserCoupon(String userSeq) {
		
		List<CouponVO> couponList = sqlSession.selectList("coupon.getUserCoupon", userSeq);
		
		return couponList;
	}

	// 사업자가 발행한 쿠폰 목록
	public List<CouponVO> getBossCoupon(String userSeq) {
		
		List<CouponVO> couponList = sqlSession.selectList("coupon.getBossCoupon", userSeq);
		
		return couponList;
	}

	// 쿠폰 등록을 위해 해당 사업자의 업장 정보 가져오기
	public List<RestaurantVO> getRestaurant(String userSeq) {
		
		List<RestaurantVO> restList = sqlSession.selectList("restaurant.getRestrauntList", userSeq);
		
		return restList;
	}
	
	// 쿠폰 발행
	public int couponBuy(HashMap<String, String> map) {
		int result = 0;
		int couponNum = Integer.parseInt(map.get("couponNum"));
		
		for (int i = 0; i < couponNum; i++) {
			result += sqlSession.insert("coupon.couponBuy", map);
		}
		
		result += sqlSession.update("coupon.userPointUpdate", map);
		
		return result;
	}
	
	
}
