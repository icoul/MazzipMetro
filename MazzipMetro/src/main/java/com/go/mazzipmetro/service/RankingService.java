package com.go.mazzipmetro.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.go.mazzipmetro.dao.RankingDAO;

@Controller
public class RankingService {

	@Autowired
	private RankingDAO dao;
}
