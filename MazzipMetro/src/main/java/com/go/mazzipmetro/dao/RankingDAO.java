package com.go.mazzipmetro.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class RankingDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
}
