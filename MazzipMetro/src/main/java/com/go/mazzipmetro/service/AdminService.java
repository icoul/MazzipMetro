package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.mazzipmetro.dao.AdminDAO;
import com.go.mazzipmetro.vo.ContentVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;

@Service
public class AdminService implements IService {
 
	@Autowired
	private AdminDAO dao;
	
	//회원리스트
	public List<UserVO> list(HashMap<String, String> map) {
		List<UserVO> list = dao.list(map);
		
		return list;
	}//end of List<UserVO> list(HashMap<String, String> map) ---------------
	
	//회원리스트
	public int getTotalCount(HashMap<String, String> map) {
		int count = dao.getTotalCount(map);
		return count;
	}//end of int getTotalCount(HashMap<String, String> map)----------------
	
	//회원삭제
	public int userDel(HashMap<String, String> map) {
		int n = dao.userDel(map);
		return n;
	}//end of int userDel(HashMap<String, String> map)-----------------------

	// 관리자용 업장 수정 페이지
	public RestaurantVO adminRestEdit(String restSeq) {
		return dao.adminRestEdit(restSeq);
	}

	//컨텐츠리스트
	public int getConTotalCount(HashMap<String, String> map) {
		int count = dao.getConTotalCount(map);
		return count;
	}
	
	//컨텐츠 관리 리스트
	public List<HashMap<String, String>>  conTentList(HashMap<String, String> map) {
		
		List<HashMap<String, String>> adminConList = dao.conTentList(map);
		return adminConList;
	}

	
}
