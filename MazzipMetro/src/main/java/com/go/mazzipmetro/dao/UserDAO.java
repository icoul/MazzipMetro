
package com.go.mazzipmetro.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.UserVO;

@Repository
public class UserDAO implements IDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int userRegister(UserVO vo) {
		int n = sqlSession.insert("user.userRegister", vo);
		return n;
	}


	public int UserLogin(HashMap<String, String> map) {
		int n = sqlSession.selectOne("user.logincheck", map);
		return n;
	}


	public UserVO getLoginUser(String userEmail) {
		UserVO loginUser = sqlSession.selectOne("user.getLoginUser", userEmail);
		return loginUser;
	}

	public int qnaRegister(HashMap<String, String> hashMap) {
		int n = sqlSession.insert("qnaRegister", hashMap);
		return n;
	}

}

