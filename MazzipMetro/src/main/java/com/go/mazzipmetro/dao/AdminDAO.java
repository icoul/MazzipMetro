package com.go.mazzipmetro.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ContentVO;
import com.go.mazzipmetro.vo.RestaurantAdVO;
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

	//관리자용 - 컨텐츠 리스트
	public List<HashMap<String, String>> conTentList(HashMap<String, String> map) {
		List<HashMap<String, String>> list = sqlSession.selectList("admin.conTentList", map); 
		return list;
	}
	//관리자용 - 컨텐츠 리스트 -페이징
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

	// 관리자용 업장 수정 요청 (AdImg 이름 요청)
	public List<String> adminRestAdImgInfo(String restSeq) {
		return sqlSession.selectList("restaurant.adminRestAdImgInfo", restSeq);
	}

	//업장 소개 이미지 삭제
	public int delRestAd(HashMap<String, String> map) {
		return sqlSession.update("restaurant.delRestAd", map);
	}

	//업장 소개 이미지 삭제
	public int insertRestAd(HashMap<String, String> map) {
		return sqlSession.insert("restaurant.insertRestAd", map);
	}
	
	// 관리자용 회원 수정 - 한명회원 정보 불러오기
	public HashMap<String, String> adminUserInfo(String userSeq) {
		return sqlSession.selectOne("admin.adminUserInfo", userSeq);
	}
	
	// 관리자용 회원 수정 - 한명회원 정보 수정하기
	public int adminUserEdit(HashMap<String, String> userinfoMap) {
		return sqlSession.update("admin.adminUserEdit", userinfoMap);
	}
	
	//컨텐츠 통계
	public List<HashMap<String, String>> adminConStatis() {
		return sqlSession.selectList("admin.adminConStatis");
	}

	

	
	
}
