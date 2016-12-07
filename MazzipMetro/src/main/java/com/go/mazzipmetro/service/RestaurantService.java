package com.go.mazzipmetro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.RestaurantDAO;

@Service
public class RestaurantService implements IService{

	@Autowired
	private RestaurantDAO dao;
	
}
