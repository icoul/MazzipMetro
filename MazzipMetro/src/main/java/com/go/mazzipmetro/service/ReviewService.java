package com.go.mazzipmetro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.ReviewDAO;

@Service
public class ReviewService implements IService{

	@Autowired
	private ReviewDAO dao;
	
}
