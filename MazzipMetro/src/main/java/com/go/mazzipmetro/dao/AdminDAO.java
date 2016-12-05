package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;
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
	public RestaurantVO adminRestEdit(String restSeq) {
		return sqlSession.selectOne("restaurant.adminRestEdit", restSeq);
	}

	
	
}
