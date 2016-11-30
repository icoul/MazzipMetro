package com.go.mazzipmetro.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.AttachFileVO;
import com.go.mazzipmetro.vo.ReviewVO;

@Repository
public class ReviewDAO implements IDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int add(ReviewVO vo) {
		
		int result = sqlSession.insert("review.add", vo); // 아이디 add , 파라미터값 vo
		return result;
		
		
	}

	public int add_file(AttachFileVO avo) {

		int result = sqlSession.insert("review.add_file", avo); // 아이디 add_file , 파라미터값 avo
		return result;
	}
	
	
}
