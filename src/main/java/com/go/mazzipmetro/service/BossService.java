package com.go.mazzipmetro.service;
import java.util.HashMap;
import java.util.List;

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
	public List<HashMap<String, String>>  getRestSeq(String userSeq) {
		List<HashMap<String, String>>  list = dao.getRestSeq(userSeq);
		return list;
	}
	
	//컨텐츠 구매목록
	public List<HashMap<String, String>> bossConList(HashMap<String, String> map) {
		List<HashMap<String, String>> bossConList = dao.bossConList(map);
		return bossConList;
	}
	
	//컨텐츠 구매목록 - 페이징
	public int getBossConTotal(HashMap<String, String> map) {
		int count = dao.getBossConTotal(map);
		return count;
	}
}

