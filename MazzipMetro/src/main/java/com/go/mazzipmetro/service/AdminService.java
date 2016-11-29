package com.go.mazzipmetro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.AdminDAO;

@Service
public class AdminService implements IService {
 
	@Autowired
	private AdminDAO dao;
}
