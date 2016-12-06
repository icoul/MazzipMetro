package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ContentVO;
import com.go.mazzipmetro.vo.UserVO;

@Repository
public class AdminDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	public List<UserVO> list(HashMap<String, String> map) {
		List<UserVO> list = sqlSession.selectList("admin.list", map); 
		
		return list;
	}

	public int getTotalCount(HashMap<String, String> map) {
		int count = sqlSession.selectOne("admin.getTotalCount", map); 
		return count;
	}// end of getTotalCount(HashMap<String, String> map)-------------

	public int userDel(HashMap<String, String> map) {
		int n = sqlSession.update("admin.userDel", map);
		return n;
	}

	// 관리자용 업장 수정 페이지 요청을 위한 하나의 업장정보 알아오기
	public RestaurantVO adminRestEditInfo(String restSeq) {
		return sqlSession.selectOne("restaurant.adminRestEditInfo", restSeq);
	}


	public List<HashMap<String, String>> conTentList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlSession.selectList("admin.conTentList", map); 
		return list;
	}

	public int getConTotalCount(HashMap<String, String> map) {
		int count = sqlSession.selectOne("admin.getConTotalCount", map); 
		return count;
	}

	// 관리자용 업장 수정 페이지 (업장 등급 리스트)
	public List<HashMap<String, String>> restGradeList() {
		return sqlSession.selectList("restaurant.restGradeList");
	}

	// 관리자용 업장 수정 요청 
	public int adminRestEdit(RestaurantVO vo) {
		return sqlSession.insert("restaurant.adminRestEditEnd", vo);
	}

	
	
}
