package com.go.mazzipmetro.service;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.BossDAO;

@Service
public class BossService implements IService{
	
	@Autowired
	private BossDAO dao;
	//코인충전하기
	public int coinUpdate(HashMap<String, Object> map) {
		int result = dao.coinUpdate(map);
		return result;
	}
	
	//파워배너 
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int bannBuyUpdate(HashMap<String, String> map) throws Throwable {
		int result = dao.bannBuyUpdate(map);
		return result;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int bannInsert(HashMap<String, String> map) throws Throwable {
		int result = dao.bannInsert(map);
		return result;
	}
	
	//파워링크
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int linkBuyUpdate(HashMap<String, String> map) throws Throwable {
		int result = dao.linkBuyUpdate(map);
		return result;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int linkInsert(HashMap<String, String> map) throws Throwable {
		int result = dao.linkInsert(map);
		return result;
	}
	
	//추천광고
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int recomBuyUpdate(HashMap<String, String> map) throws Throwable {
		int result = dao.recomBuyUpdate(map);
		return result;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int recomInsert(HashMap<String, String> map) throws Throwable {
		int result = dao.recomInsert(map);
		return result;
	}
	//컨텐츠테이블 등록하기위해 restSeq 구해오기
	public String getRestSeq(String userSeq) {
		String restSeq = dao.getRestSeq(userSeq);
		return restSeq;
	}
}

