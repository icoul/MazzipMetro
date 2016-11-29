package com.go.mazzipmetro.service;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.go.mazzipmetro.dao.BossDAO;

@Service
public class BossService implements IService{
	
	@Autowired
	private BossDAO dao;

	public int coinUpdate(HashMap<String, Object> map) {
		int result = dao.coinUpdate(map);
		return result;
	}
}

