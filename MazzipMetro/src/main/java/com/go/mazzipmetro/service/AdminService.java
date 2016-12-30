package com.go.mazzipmetro.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.go.mazzipmetro.dao.AdminDAO;
import com.go.mazzipmetro.vo.RestaurantAdVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
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
	public RestaurantVO adminRestEditInfo(String restSeq) {
		return dao.adminRestEditInfo(restSeq);
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

	// 관리자용 업장 수정 페이지 (업장 등급 리스트)
	public List<HashMap<String, String>> restGradeList() {
		return dao.restGradeList();
	}

	// 관리자용 업장 수정 요청 
	@Transactional(propagation=Propagation.REQUIRED, isolation= Isolation.READ_COMMITTED, rollbackFor={Throwable.class})
	public int adminRestEdit(String[] delAdImgArr, List<String> adImgList, RestaurantVO vo) {
		int result = 0, cnt = 0;
		HashMap<String, String> map = new HashMap<String, String>();
		
		// 삭제할 소개 이미지가 존재하면, 삭제 실행!
		if (delAdImgArr != null) {
			for (String adImg : delAdImgArr) {
				map.put("restSeq", vo.getRestSeq());
				map.put("adImg", adImg);
				
				result = dao.delRestAd(map);
				cnt += result;
			}
		}
		
		// 추가할 소개 이미지가 있으면, tbl_restaurant_ad 테이블에 insert
		if (adImgList.size() > 0) {
			for (String adImg : adImgList) {
				map.put("restSeq", vo.getRestSeq());
				map.put("adImg", adImg);
				
				result = dao.insertRestAd(map);
				cnt += result;
			}
		}
		
		cnt += dao.adminRestEdit(vo);
		
		System.out.println(">>>>>>>>>> cnt = "+cnt+", 데이터 실행 개수 = "+((delAdImgArr == null)?0:delAdImgArr.length) + adImgList.size()+1); 
		System.out.println(">>>>>>>>>> delAdImgArr.length="+((delAdImgArr == null)?0:delAdImgArr.length)+", adImgList.size()= "+adImgList.size()); 
		
		// cnt 총합과 작업할 데이터의 크기비교후 성공, 실패 여부를 리턴한다.
		
		
		if(cnt == ((delAdImgArr == null)?0:delAdImgArr.length) + adImgList.size()+1){
			result = 1;
		} else {
			result = 0;
		}
		return result;
	}

	// 관리자용 업장 수정 요청 (AdImg 이름 요청)
	public RestaurantAdVO adminRestAdImgInfo(String restSeq) {
		RestaurantAdVO ravo = new  RestaurantAdVO();
		ravo.setRestSeq(restSeq);
		ravo.setAdImg(dao.adminRestAdImgInfo(restSeq).toArray(new String[dao.adminRestAdImgInfo(restSeq).size()]));
		
		return ravo;
	}
	
	// 관리자용 회원 수정 - 한명회원 정보 불러오기
	public HashMap<String, String> adminUserInfo(String userSeq) {
		HashMap<String, String> adminUserInfo = dao.adminUserInfo(userSeq);
		return adminUserInfo;
	}
	
	// 관리자용 회원 수정 - 한명회원 정보 수정하기(tbl_user 업데이트)
	public int adminUserEdit(HashMap<String, String> userinfoMap) {
		int result = dao.adminUserEdit(userinfoMap);
		return result;
	}
	
	//컨텐츠 통계
	public List<HashMap<String, String>> adminConStatis() {
		List<HashMap<String, String>>  list = dao.adminConStatis();
		return list;
	}

	//한별_전체리뷰목록
	public List<HashMap<String, String>> adminReviewList(HashMap<String, String> map) {
		List<HashMap<String, String>> adminReviewList = dao.adminReviewList(map);
		return adminReviewList;
	}

	public int getTotalReviewCount(HashMap<String, String> map) {
		int count = dao.getTotalReviewCount(map);
		return count;
	}

	public int adminReviewDelete(String reviewSeq) {
		int del = dao.adminReviewDelete(reviewSeq);
		return del;
	}


	
	
}
