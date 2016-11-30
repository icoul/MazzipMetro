package com.go.mazzipmetro.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.UserDAO;
import com.go.mazzipmetro.vo.RestaurantVO;

@Service
public class UserService implements IService {

	@Autowired
	private UserDAO dao;

	public List<RestaurantVO> getRestrauntList(String userseq) {
		List<RestaurantVO> restaurantList = dao.getRestrauntList(userseq);
		return restaurantList;
	}
}
