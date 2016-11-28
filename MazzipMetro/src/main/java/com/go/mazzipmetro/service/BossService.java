package com.go.mazzipmetro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.BossDAO;

@Service
public class BossService implements IService{
	
	@Autowired
	private BossDAO dao;
}
