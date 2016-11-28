package com.go.mazzipmetro.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RestaurantDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<RestaurantVO> getRestName(String name){
		
		List<RestaurantVO> nameList = sqlSession.selectList("restaurant.getRestName", name);
		
		return nameList;
	}
}
