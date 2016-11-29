package com.go.mazzipmetro.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.RestaurantDAO;
import com.go.mazzipmetro.vo.RestaurantVO;

@Service
public class RestaurantService implements IService{

	@Autowired
	private RestaurantDAO dao;
	
	public List<RestaurantVO> getRestName(String name){
		
		List<RestaurantVO> nameList = dao.getRestName(name);
		
		return nameList;
	}
}
