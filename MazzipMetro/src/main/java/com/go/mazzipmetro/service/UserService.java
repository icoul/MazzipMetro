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

}

