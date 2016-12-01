package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.MazzipMetroDAO;
import com.go.mazzipmetro.vo.QnaVO;

@Service
public class MazzipMetroService implements IService {

	@Autowired
	MazzipMetroDAO dao;
	
	
	public List<HashMap<String, String>> dbTest() {
		return dao.dbTest();
	}
	
	public List<String> alignTest() {
		
		List<String> list = dao.alignTest();
		
		return list;
	}
	
	public int qnaRegister(HashMap<String, String> hashMap) {
		int n =  dao.qnaRegister(hashMap);
		return n;
	}

	public List<HashMap<String,String>> myQnaList(HashMap<String, String> map) {
		List<HashMap<String,String>> myQnaList =  dao.myQnaList(map);
		return myQnaList;
	}

	public int getTotalMyQnaCount(HashMap<String, String> map) {
		int myQnaTotalCount = dao.getTotalMyQnaCount(map);
		return myQnaTotalCount;
	}

	public int getMyQnaProgressCount(HashMap<String, String> hashMap) {
		int myQnaCount = dao.getMyQnaProgressCount(hashMap);
		return myQnaCount;
	}

	public int getToday(HashMap<String,String> hashMap) {
		int today = dao.getToday(hashMap);
		return today;
	}
}
