package com.go.mazzipmetro.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;

@Repository
public class UserDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<RestaurantVO> getRestrauntList(String userseq) {
		List<RestaurantVO> restaurantList = sqlSession.selectList("getRestrauntList", userseq);
		return restaurantList;
	}
}
