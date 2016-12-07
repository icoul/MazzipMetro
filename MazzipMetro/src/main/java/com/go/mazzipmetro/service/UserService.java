package com.go.mazzipmetro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.UserDAO;

@Service
public class UserService implements IService {

	@Autowired
	private UserDAO dao;
}
