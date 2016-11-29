package com.go.mazzipmetro.dao;
import java.util.HashMap;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BossDAO implements IDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int coinUpdate(HashMap<String, Object> map) {
		int n = sqlSession.update("boss.coinUpdate", map);
		return n;
	}
	
}

