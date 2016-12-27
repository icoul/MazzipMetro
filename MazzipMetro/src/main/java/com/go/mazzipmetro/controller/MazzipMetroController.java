package com.go.mazzipmetro.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.go.mazzipmetro.common.FileManager;
import com.go.mazzipmetro.common.ThumbnailManager;
import com.go.mazzipmetro.service.MazzipMetroService;
import com.go.mazzipmetro.service.ReviewService;
import com.go.mazzipmetro.vo.FaqVO;
import com.go.mazzipmetro.vo.RestaurantVO;
import com.go.mazzipmetro.vo.ReviewVO;
import com.go.mazzipmetro.vo.UserVO;

@Controller
public class MazzipMetroController {

	@Autowired
	MazzipMetroService service;
	@Autowired
	private FileManager fileManager;
	@Autowired
	private ThumbnailManager thumbnailManager;
	@Autowired
	private ReviewService reviewService;

	@RequestMapping(value = "/index.eat", method = { RequestMethod.GET })
	public String index() {
		return "index";
	}

	// 테마페이지 요청
	@RequestMapping(value = "/theme.eat", method = { RequestMethod.GET })
	public String theme(HttpServletRequest req) {
		String theme = req.getParameter("theme");

		req.setAttribute("theme", theme);
		return "theme";
	}

	// 동현_테마 선택 페이지 ajax 요청
	@RequestMapping(value = "/themeSearch.eat", method = { RequestMethod.GET })
	public String themeSearch(HttpServletRequest req) {
		String[] themeChkArr = req.getParameterValues("themeChk");
		String dongId = req.getParameter("selMenu_dongName");
		String guId = req.getParameter("selMenu_guName");
		String metroId = req.getParameter("selMenu_metroName");

		String pageNo = req.getParameter("pageNo");

		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>" + pageNo);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>" + themeChkArr);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>" + dongId);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>" + guId);
		System.out.println(">>>>>>>>>>>>>>>>>>>>>>>" + metroId);

		List<RestaurantVO> restList = null;

		int totalRest = 0; // 총 음식점 건수
		int totalPage = 0; // 전체 페이지수
		int sizePerPage = 5; // 한페이지당 보여줄 음식점수
		int currPage = 0; // 요청 페이지 req객체 파라미터에 담긴 요청페이지 pageNo

		int start = 0; // 시작행번호
		int end = 0; // 끝 행번호

		// 페이지바용 변수
		int sPage = 0; // 페이지바에서 시작될 페이지 번호
		int loop = 0; // sPage값이 증가할 때마다 1씩 증가
		int blockSize = 5; // 페이지바에 표시될 pageNo의 개수

		// value값이 다르므로, 두번째 인자값은 Object로 한다.
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("themeChkArr", themeChkArr);
		map.put("guId", guId);
		map.put("dongId", dongId);
		map.put("metroId", metroId);

		// 페이징 작업 (총 게시물 수, 총 페이지수)
		// 테마별 총 음식점 수를 구하기
		totalRest = service.getThemeSearch_totalCnt(map);

		// 페이지바 작업 시작!
		totalPage = (int) Math.ceil((double) totalRest / sizePerPage);
		// (double)totalCount/sizePerPage 값이 1.1 이면 Math.ceil()은 2.0
		// Math.ceil()은 double이라서 형변환을 해야한다.
		// 63/5 = 12.xx -> 13.0 이 값이 totalPage 가 된다.

		if (pageNo == null) {
			// 게시판 최초로딩시 pageNo은 null이다.
			currPage = 1;
			// 초기화면은 /list.action?pageNo = 1 과 같다.
		} else {
			try {
				currPage = Integer.parseInt(pageNo);
				// get방식으로 넘어온 pageNo을 currPage에 int 캐스팅후 대입한다.

				if (currPage < 1 || currPage > totalPage) {
					currPage = 1;
				}

			} catch (NumberFormatException exeption) {
				currPage = 1;
			}
		}

		start = ((currPage - 1) * sizePerPage) + 1; // sRowNum
		end = start + sizePerPage - 1;// sRowNum : currPage*sizePerPage

		// 페이징처리를 위해 start , end 를 map에 담는다.
		map.put("start", String.valueOf(start)); // HashMap 데이터타입에 맞게 int start를
													// String으로 변경해서 담는다.
		map.put("end", String.valueOf(end)); // HashMap 데이터타입에 맞게 int end를
												// String으로 변경해서 담는다.

		// 테마 검색 시작
		restList = service.getThemeSearch(map);

		String pageBar = "";

		if (totalRest > 5) {
			pageBar += "<ul class='pagination'>";
			loop = 1;

			// ## 페이지바의 시작 페이지 번호(sPage)값 만들기(공식)
			sPage = ((currPage - 1) / blockSize) * blockSize + 1;

			// 이전 5페이지 만들기
			if (!(sPage == 1)) {
				pageBar += String.format("<li><a href='javascript:goThemeSearch(%d)''>«</a></li>", sPage - blockSize);
			}

			while (!(loop > blockSize || sPage > totalPage)) {

				if (sPage == currPage) { // 시작페이지 중에 현재페이지 하나만 <span>
					pageBar += String.format("<li><a class='active' href='#'>%s</a></li>", sPage);
				} else {

					pageBar += String.format("<li><a href='javascript:goThemeSearch(%d)'>%s</a></li>", sPage, sPage);
				}
				loop++;
				sPage++;
			}

			// 다음 5페이지 만들기
			if (!(sPage > totalPage)) {
				pageBar += String.format("<li><a href='javascript:goThemeSearch(%d)''>»</a></li>", sPage);
			}

			pageBar += "" + "</ul>";

			req.setAttribute("pageBar", pageBar);
		}

		req.setAttribute("restList", restList);
		return "/ajax/themeSearch";
	}

	// 사용자 가고싶다 list 중 체크된 체크박스를 세션 저장 요청
	@RequestMapping(value = "/userWantToGoChk.eat", method = { RequestMethod.GET })
	public void login_userWantToGoChk(HttpServletRequest req, HttpServletResponse res) {
		String[] userWantToGoChk = req.getParameterValues("userWantToGoChk");

		System.out.println(">>>>>>>>>>>>>>>>" + userWantToGoChk[0]);
		/* String, int배열인데, 찍으면 객체로 찍힌다. */
		// String[] testArr = new String[]{"헬","로","우"};
		// int[] intTestArr = new int[]{1,2,3};
		// System.out.println(">>>>>>>>>>>>>>>>"+intTestArr);
		// >>>>>>>>>>>>>>>>[I@4d695f9e
		// System.out.println(">>>>>>>>>>>>>>>>"+userWantToGoChk);
		// >>>>>>>>>>>>>>>>[Ljava.lang.String;@4495fddc
		// System.out.println(">>>>>>>>>>>>>>>>"+testArr);
		// >>>>>>>>>>>>>>>>[Ljava.lang.String;@74641b3c

		req.getSession().setAttribute("userWantToGoChk", userWantToGoChk);

	}

	// 사용자 가고싶다 list 요청
	@RequestMapping(value = "/getUserWantToGo.eat", method = { RequestMethod.GET })
	public String login_getUserWantToGo(HttpServletRequest req, HttpServletResponse res) {
		UserVO loginUser = (UserVO) req.getSession().getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();

		List<RestaurantVO> list = service.getUserWantToGo(userSeq);

		System.out.println(">>>>>>>>>>>>>>>>" + (list == null));
		// false
		// 로그인 하지 않으면 실행되지 않는 메소드이다. 가고싶다 행이 없다면, 껍데기뿐인 list가 담긴다.

		req.setAttribute("list", list);
		return "/ajax/userWantToGo";
	}

	// 가고싶다에 담기 요청
	@RequestMapping(value = "/addWantToGo.eat", method = { RequestMethod.POST })
	public String addFoodCart(HttpServletRequest req, HttpServletResponse res) {
		String restSeq = req.getParameter("restSeq");
		UserVO loginUser = (UserVO) req.getSession().getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();
		String msg = "";

		HashMap<String, String> map = new HashMap<>();
		map.put("restSeq", restSeq);
		map.put("userSeq", userSeq);

		// 가고싶다 테이블에 담겨있는지 검사
		if (service.checkWantToGo(map) > 0) {
			msg = "이미 가고싶다에 담은 음식점입니다.";
		} else if (service.checkNumWantToGo(map) >= 15) {// 가고 싶다 테이블에는 사용자가 최고
															// 15개까지 담을 수 있다.
			msg = "가고싶다에 15개까지만 담을 수 있습니다. (현재15개)";
		} else {

			int result = service.addWantToGo(map);
			msg = "[ " + loginUser.getUserName() + " 님의 ";
			msg += (result > 0) ? "가고싶다]에 성공적으로 담았습니다." : "가고싶다]에 담기 실패했습니다. 다시 시도해주세요.";

		}

		System.out.println(">>>>>>>>>>>>>>>> msg = " + msg);
		JSONObject jObj = new JSONObject();
		jObj.put("msg", msg);

		req.setAttribute("jObj", jObj);
		return "/ajax/jsonData";
	}

	// 가고싶다 삭제 요청
	@RequestMapping(value = "/delWantToGo.eat", method = { RequestMethod.POST })
	public String lonin_delWantToGo(HttpServletRequest req, HttpServletResponse res) {
		String[] wantToGoChkArr = req.getParameterValues("wantToGoChk");// 가고싶다
																		// restSeq를
																		// 담은 배열
		UserVO loginUser = (UserVO) req.getSession().getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();
		String msg = "";

		int result = service.delWantToGo(userSeq, wantToGoChkArr);

		// 추천맛집 (wantToGoStatus = 2)인 경우 대비 세션의 restRecom값 삭제.
		if (result > 0) {
			req.getSession().removeAttribute("restRecom");
		}

		msg += (result > 0) ? "성공적으로 삭제했습니다." : "삭제되지 않았습니다. 다시 시도해주세요.";

		JSONObject jObj = new JSONObject();
		jObj.put("msg", msg);
		req.setAttribute("jObj", jObj);
		return "/ajax/jsonData";
	}

	// 맛집메트로 추천을 사용자가 선택한다.
	@RequestMapping(value = "/mazzipMetroPick.eat", method = { RequestMethod.POST })
	public String lonin_mazzipMetroPick(HttpServletRequest req, HttpServletResponse res) {
		String restSeq = req.getParameter("restSeq");
		UserVO loginUser = (UserVO) req.getSession().getAttribute("loginUser");
		String userSeq = loginUser.getUserSeq();
		String msg = "";

		HashMap<String, String> map = new HashMap<>();
		map.put("restSeq", restSeq);
		map.put("userSeq", userSeq);

		int result = service.mazzipMetroPick(map);

		msg += (result > 0) ? "맛있게 드시고 맛집정복 후기를 작성해 보세요." : "추천맛집 선택이 올바르게 진행되지 않았습니다. 다시 선택해주세요.";

		System.out.println(">>>>>>>>>>>>>>>> msg = " + msg);
		JSONObject jObj = new JSONObject();
		jObj.put("msg", msg);
		req.setAttribute("jObj", jObj);
		return "/ajax/jsonData";
	}

	// 검색 페이지 요청
	@RequestMapping(value = "/search.eat", method = { RequestMethod.GET })
	public String search(HttpServletRequest req) {
		String keyword = req.getParameter("keyword");
		req.setAttribute("keyword", keyword);
		return "search";
	}

	// 업장 검색 ajax 요청
	@RequestMapping(value = "/restSearch.eat", method = { RequestMethod.GET })
	public String restSearch(HttpServletRequest req) {
		String keyword = req.getParameter("keyword");
		String pageNo = req.getParameter("pageNo");

		int totalRest = 0; // 총 음식점 건수
		int totalPage = 0; // 전체 페이지수
		int sizePerPage = 5; // 한페이지당 보여줄 음식점수
		int currPage = 0; // 요청 페이지 req객체 파라미터에 담긴 요청페이지 pageNo

		int start = 0; // 시작행번호
		int end = 0; // 끝 행번호

		// 페이지바용 변수
		int sPage = 0; // 페이지바에서 시작될 페이지 번호
		int loop = 0; // sPage값이 증가할 때마다 1씩 증가
		int blockSize = 5; // 페이지바에 표시될 pageNo의 개수

		// 특정 문자열은 제거한다.
		// 맛집,
		String keyword2 = keyword.replaceAll("맛집", "").trim();

		String[] kwArr = keyword2.trim().split(" ");
		String srchType = "";
		String locStr = "";
		String kw = "";

		List<RestaurantVO> restList = null;

		HashMap<String, String> map = new HashMap<>();

		if (kwArr.length > 1) {
			System.out.println(">>>>>>>>>>>>>>>>>>> restSearch.eat 복합검색어");

			// 위치정보를 가지고 있는 경우
			for (int i = 0; i < kwArr.length; i++) {

				String result = service.getLocationInfo(kwArr[i]);
				System.out.println(">>>>>>>>>>>>>> result = " + result);

				if (!"".equals(result)) {
					srchType = result;
					locStr = kwArr[i];
					map.put("srchType", srchType);
					map.put("locStr", locStr);
					break;
				}
			}

			// 위치정보를 제외한 나머지 문자열을 하나의 문자열로 묶는다.
			if (!"".equals(srchType)) {
				for (String str : kwArr) {
					if (!str.equals(locStr)) {
						kw += str;
					}
				}
				kw = kw.trim();
			} else {
				System.out.println(">>>>>>>>>> kw = " + keyword2);
				kw = keyword2;
			}

			map.put("kw", kw);

			// 검색횟수 제안
			int n = 0;

			do {

				if (n == 1) {
					map.remove("srchType");
					map.remove("locStr");
					map.put("kw", keyword2);
				}

				// 페이징 작업 (총 게시물 수, 총 페이지수)
				// 먼저 총 음식점 수를 구하기
				totalRest = service.getRestSearchResult_totalCnt(map);

				// 페이지바 작업 시작!
				totalPage = (int) Math.ceil((double) totalRest / sizePerPage);
				// (double)totalCount/sizePerPage 값이 1.1 이면 Math.ceil()은 2.0
				// Math.ceil()은 double이라서 형변환을 해야한다.
				// 63/5 = 12.xx -> 13.0 이 값이 totalPage 가 된다.

				if (pageNo == null) {
					// 게시판 최초로딩시 pageNo은 null이다.
					currPage = 1;
					// 초기화면은 /list.action?pageNo = 1 과 같다.
				} else {
					try {
						currPage = Integer.parseInt(pageNo);
						// get방식으로 넘어온 pageNo을 currPage에 int 캐스팅후 대입한다.

						if (currPage < 1 || currPage > totalPage) {
							currPage = 1;
						}

					} catch (NumberFormatException exeption) {
						currPage = 1;
					}
				}

				start = ((currPage - 1) * sizePerPage) + 1; // sRowNum
				end = start + sizePerPage - 1;// sRowNum : currPage*sizePerPage

				String pageBar = "";

				if (totalRest > 5) {
					pageBar += "<ul class='pagination'>";
					loop = 1;

					// ## 페이지바의 시작 페이지 번호(sPage)값 만들기(공식)
					sPage = ((currPage - 1) / blockSize) * blockSize + 1;

					// 이전 5페이지 만들기
					if (!(sPage == 1)) {
						pageBar += String.format("<li><a href='javascript:goRestSearch(%d)''>«</a></li>",
								sPage - blockSize);
					}

					while (!(loop > blockSize || sPage > totalPage)) {

						if (sPage == currPage) { // 시작페이지 중에 현재페이지 하나만 <span>
							pageBar += String.format("<li><a class='active' href='#'>%s</a></li>", sPage);
						} else {

							pageBar += String.format("<li><a href='javascript:goRestSearch(%d)'>%s</a></li>", sPage,
									sPage);
						}
						loop++;
						sPage++;
					}

					// 다음 5페이지 만들기
					if (!(sPage > totalPage)) {
						pageBar += String.format("<li><a href='javascript:goRestSearch(%d)''>»</a></li>", sPage);
					}

					pageBar += "" + "</ul>";

					req.setAttribute("pageBar", pageBar);
				}

				// 페이징처리를 위해 start , end 를 map에 담는다.
				map.put("start", String.valueOf(start)); // HashMap 데이터타입에 맞게
															// int start를
															// String으로 변경해서
															// 담는다.
				map.put("end", String.valueOf(end)); // HashMap 데이터타입에 맞게 int
														// end를 String으로 변경해서
														// 담는다.

				restList = service.getRestSearchResult(map);

				if (totalRest > 0) {
					break;
				}
				n++;
			} while (n < 2);

		} else {
			// 단일 검색어인경우
			System.out.println(">>>>>>>>>>>>>>>>>>> restSearch.eat  단일검색어");

			// 단일 검색어가 위치정보인 경우
			String result = service.getLocationInfo(keyword2);
			if (!"".equals(result)) {
				srchType = result;
				map.put("srchType", srchType);
			}

			map.put("kw", keyword2);
			// 페이징 작업 (총 게시물 수, 총 페이지수)
			// 먼저 총 음식점 수를 구하기
			totalRest = service.getRestIntergratedSearch_totalCnt(map);

			// 페이지바 작업 시작!
			totalPage = (int) Math.ceil((double) totalRest / sizePerPage);
			// (double)totalCount/sizePerPage 값이 1.1 이면 Math.ceil()은 2.0
			// Math.ceil()은 double이라서 형변환을 해야한다.
			// 63/5 = 12.xx -> 13.0 이 값이 totalPage 가 된다.

			if (pageNo == null) {
				// 게시판 최초로딩시 pageNo은 null이다.
				currPage = 1;
				// 초기화면은 /list.action?pageNo = 1 과 같다.
			} else {
				try {
					currPage = Integer.parseInt(pageNo);
					// get방식으로 넘어온 pageNo을 currPage에 int 캐스팅후 대입한다.

					if (currPage < 1 || currPage > totalPage) {
						currPage = 1;
					}

				} catch (NumberFormatException exeption) {
					currPage = 1;
				}
			}

			start = ((currPage - 1) * sizePerPage) + 1; // sRowNum
			end = start + sizePerPage - 1;// sRowNum : currPage*sizePerPage

			String pageBar = "";

			if (totalRest > 5) {
				pageBar += "<ul class='pagination'>";
				loop = 1;

				// ## 페이지바의 시작 페이지 번호(sPage)값 만들기(공식)
				sPage = ((currPage - 1) / blockSize) * blockSize + 1;

				// 이전 5페이지 만들기
				if (!(sPage == 1)) {
					pageBar += String.format("<li><a href='javascript:goRestSearch(%d)''>«</a></li>",
							sPage - blockSize);
				}

				while (!(loop > blockSize || sPage > totalPage)) {

					if (sPage == currPage) { // 시작페이지 중에 현재페이지 하나만 <span>
						pageBar += String.format("<li><a class='active' href='#'>%s</a></li>", sPage);
					} else {

						pageBar += String.format("<li><a href='javascript:goRestSearch(%d)'>%s</a></li>", sPage, sPage);
					}
					loop++;
					sPage++;
				}

				// 다음 5페이지 만들기
				if(!(sPage > totalPage)) {
					pageBar += String.format("<li><a href='javascript:goRestSearch(%d)''>»</a></li>", sPage);		


				pageBar += "" + "</ul>";

				req.setAttribute("pageBar", pageBar);
			}

			// 페이징처리를 위해 start , end 를 map에 담는다.
			map.put("start", String.valueOf(start)); // HashMap 데이터타입에 맞게 int
														// start를 String으로 변경해서
														// 담는다.
			map.put("end", String.valueOf(end)); // HashMap 데이터타입에 맞게 int end를
													// String으로 변경해서 담는다.

			System.out.println(">>>>>>>>>> start=" + start);
			System.out.println(">>>>>>>>>> end=" + end);

			restList = service.getRestIntergratedSearch(map);
			}
			
		}

		req.setAttribute("keyword", keyword);
		req.setAttribute("restList", restList);
		return "/ajax/restSearch";
		}
	
	

	// 리뷰 검색 ajax 요청
	@RequestMapping(value = "/reviewSearch.eat", method = { RequestMethod.GET })
	public String reviewSearch(HttpServletRequest req) {
		String keyword = req.getParameter("keyword");
		String pageNo = req.getParameter("pageNo");

		int totalReview = 0; // 총 음식점 건수
		int totalPage = 0; // 전체 페이지수
		int sizePerPage = 5; // 한페이지당 보여줄 음식점수
		int currPage = 0; // 요청 페이지 req객체 파라미터에 담긴 요청페이지 pageNo

		int start = 0; // 시작행번호
		int end = 0; // 끝 행번호

		// 페이지바용 변수
		int sPage = 0; // 페이지바에서 시작될 페이지 번호
		int loop = 0; // sPage값이 증가할 때마다 1씩 증가
		int blockSize = 5; // 페이지바에 표시될 pageNo의 개수

		// 특정 문자열은 제거한다.
		// 맛집,
		String keyword2 = keyword.replaceAll("맛집", "").trim();

		String[] kwArr = keyword2.trim().split(" ");
		String srchType = "";
		String locStr = "";
		String kw = "";

		List<ReviewVO> reviewList = null;
		List<HashMap<String, String>> reviewImageList = null;

		HashMap<String, String> map = new HashMap<>();

		if (kwArr.length > 1) {
			System.out.println(">>>>>>>>>>>>>>>>>>> reviewSearch.eat 복합검색어");

			// 위치정보를 가지고 있는 경우
			for (int i = 0; i < kwArr.length; i++) {

				String result = service.getLocationInfo(kwArr[i]);
				if (!"".equals(result)) {
					srchType = result;
					locStr = kwArr[i];
					map.put("srchType", srchType);
					map.put("locStr", locStr);
					break;
				}
			}

			// 위치정보를 제외한 나머지 문자열을 하나의 문자열로 묶는다.
			if (!"".equals(srchType)) {
				for (String str : kwArr) {
					if (!str.equals(locStr)) {
						kw += str;
					}
				}
				kw = kw.trim();
			} else {
				System.out.println(">>>>>>>>>> kw = " + keyword2);
				kw = keyword2;
			}

			map.put("kw", kw);

			// 페이징 작업 (총 게시물 수, 총 페이지수)
			// 먼저 총 음식점 수를 구하기
			totalReview = service.getReviewSearchResult_totalCnt(map);

			// 페이지바 작업 시작!
			totalPage = (int) Math.ceil((double) totalReview / sizePerPage);
			// (double)totalCount/sizePerPage 값이 1.1 이면 Math.ceil()은 2.0
			// Math.ceil()은 double이라서 형변환을 해야한다.
			// 63/5 = 12.xx -> 13.0 이 값이 totalPage 가 된다.

			if (pageNo == null) {
				// 게시판 최초로딩시 pageNo은 null이다.
				currPage = 1;
				// 초기화면은 /list.action?pageNo = 1 과 같다.
			} else {
				try {
					currPage = Integer.parseInt(pageNo);
					// get방식으로 넘어온 pageNo을 currPage에 int 캐스팅후 대입한다.

					if (currPage < 1 || currPage > totalPage) {
						currPage = 1;
					}

				} catch (NumberFormatException exeption) {
					currPage = 1;
				}
			}

			start = ((currPage - 1) * sizePerPage) + 1; // sRowNum
			end = start + sizePerPage - 1;// sRowNum : currPage*sizePerPage

			String pageBar = "";

			if (totalReview > 5) {
				pageBar += "<ul class='pagination'>";
				loop = 1;

				// ## 페이지바의 시작 페이지 번호(sPage)값 만들기(공식)
				sPage = ((currPage - 1) / blockSize) * blockSize + 1;

				// 이전 5페이지 만들기
				if (!(sPage == 1)) {
					pageBar += String.format("<li><a href='javascript:goReviewSearch(%d)''>«</a></li>",
							sPage - blockSize);
				}

				while (!(loop > blockSize || sPage > totalPage)) {

					if (sPage == currPage) { // 시작페이지 중에 현재페이지 하나만 <span>
						pageBar += String.format("<li><a class='active' href='#'>%s</a></li>", sPage);
					} else {

						pageBar += String.format("<li><a href='javascript:goReviewSearch(%d)'>%s</a></li>", sPage,
								sPage);
					}
					loop++;
					sPage++;
				}

				// 다음 5페이지 만들기
				if (!(sPage > totalPage)) {
					pageBar += String.format("<li><a href='javascript:goReviewSearch(%d)''>»</a></li>", sPage);
				}

				pageBar += "" + "</ul>";

				req.setAttribute("pageBar", pageBar);
			}

			// 페이징처리를 위해 start , end 를 map에 담는다.
			map.put("start", String.valueOf(start)); // HashMap 데이터타입에 맞게 int
														// start를 String으로 변경해서
														// 담는다.
			map.put("end", String.valueOf(end)); // HashMap 데이터타입에 맞게 int end를
													// String으로 변경해서 담는다.

			reviewList = service.getReviewSearchResult(map);

		} else {
			// 단일 검색어인경우
			System.out.println(">>>>>>>>>>>>>>>>>>> reviewSearch.eat 단일검색어");

			// 단일 검색어가 위치정보인 경우
			String result = service.getLocationInfo(keyword2);
			if (!"".equals(result)) {
				srchType = result;
				locStr = keyword2;
				map.put("srchType", srchType);
			}

			map.put("kw", keyword2);

			// 페이징 작업 (총 게시물 수, 총 페이지수)
			// 먼저 총 음식점 수를 구하기
			totalReview = service.getReviewIntergratedSearch_totalCnt(map);

			// 페이지바 작업 시작!
			totalPage = (int) Math.ceil((double) totalReview / sizePerPage);
			// (double)totalCount/sizePerPage 값이 1.1 이면 Math.ceil()은 2.0
			// Math.ceil()은 double이라서 형변환을 해야한다.
			// 63/5 = 12.xx -> 13.0 이 값이 totalPage 가 된다.

			if (pageNo == null) {
				// 게시판 최초로딩시 pageNo은 null이다.
				currPage = 1;
				// 초기화면은 /list.action?pageNo = 1 과 같다.
			} else {
				try {
					currPage = Integer.parseInt(pageNo);
					// get방식으로 넘어온 pageNo을 currPage에 int 캐스팅후 대입한다.

					if (currPage < 1 || currPage > totalPage) {
						currPage = 1;
					}

				} catch (NumberFormatException exeption) {
					currPage = 1;
				}
			}

			start = ((currPage - 1) * sizePerPage) + 1; // sRowNum
			end = start + sizePerPage - 1;// sRowNum : currPage*sizePerPage

			String pageBar = "";

			if (totalReview > 5) {
				pageBar += "<ul class='pagination'>";
				loop = 1;

				// ## 페이지바의 시작 페이지 번호(sPage)값 만들기(공식)
				sPage = ((currPage - 1) / blockSize) * blockSize + 1;

				// 이전 5페이지 만들기
				if (!(sPage == 1)) {
					pageBar += String.format("<li><a href='javascript:goReviewSearch(%d)''>«</a></li>",
							sPage - blockSize);
				}

				while (!(loop > blockSize || sPage > totalPage)) {

					if (sPage == currPage) { // 시작페이지 중에 현재페이지 하나만 <span>
						pageBar += String.format("<li><a class='active' href='#'>%s</a></li>", sPage);
					} else {

						pageBar += String.format("<li><a href='javascript:goReviewSearch(%d)'>%s</a></li>", sPage,
								sPage);
					}
					loop++;
					sPage++;
				}

				// 다음 5페이지 만들기
				if (!(sPage > totalPage)) {
					pageBar += String.format("<li><a href='javascript:goReviewSearch(%d)''>»</a></li>", sPage);
				}

				pageBar += "" + "</ul>";

				req.setAttribute("pageBar", pageBar);
			}

			// 페이징처리를 위해 start , end 를 map에 담는다.
			map.put("start", String.valueOf(start)); // HashMap 데이터타입에 맞게 int
														// start를 String으로 변경해서
														// 담는다.
			map.put("end", String.valueOf(end)); // HashMap 데이터타입에 맞게 int end를
													// String으로 변경해서 담는다.

			// 맵 키값 확인
			Iterator<String> iterator = map.keySet().iterator();
			while (iterator.hasNext()) {
				String key = (String) iterator.next();
				System.out.print(">>>>>>>> key=" + key);
				System.out.println(">>>>>>>>value=" + map.get(key));
			}

			reviewList = service.getReviewIntergratedSearch(map);

			// 리뷰이미지 가져오기
			// System.out.println(">>>>>>>>>>>>>>>>>>"+reviewList.size());
			if (reviewList.size() > 0) {
				List<String> seqList = new ArrayList<>();
				for (ReviewVO vo : reviewList) {
					seqList.add(vo.getReviewSeq());
				}
				HashMap<String, List<String>> seqMap = new HashMap<>();
				seqMap.put("seqList", seqList);
				reviewImageList = service.getReviewImageListByReviewSeq(seqMap);
			}
		}

		req.setAttribute("keyword", keyword);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("reviewImageList", reviewImageList);
		return "/ajax/reviewSearch";
	}

	// 동현_image crop test중
	@RequestMapping(value = "/imgCropTest.eat", method = { RequestMethod.GET })
	public String imgCropTest() {
		return "/img/imgCrop";
	}

	@RequestMapping(value = "/alignTest.eat", method = { RequestMethod.GET })
	public String alignTest(HttpServletRequest req) {

		List<String> list = service.alignTest();
		String[] array = list.toArray(new String[list.size()]);

		List<String> gaList = new ArrayList<String>();
		List<String> naList = new ArrayList<String>();
		List<String> daList = new ArrayList<String>();
		List<String> raList = new ArrayList<String>();
		List<String> maList = new ArrayList<String>();
		List<String> baList = new ArrayList<String>();
		List<String> saList = new ArrayList<String>();
		List<String> aaList = new ArrayList<String>();
		List<String> jaList = new ArrayList<String>();
		List<String> chaList = new ArrayList<String>();
		List<String> kaList = new ArrayList<String>();
		List<String> taList = new ArrayList<String>();
		List<String> paList = new ArrayList<String>();
		List<String> haList = new ArrayList<String>();

		Arrays.sort(array, String.CASE_INSENSITIVE_ORDER);

		for (int i = 0; i < array.length; i++) {
			int metroInt = (int) array[i].charAt(0);

			if (metroInt < 45208) {
				gaList.add(array[i]);
			}

			if (45208 < metroInt && metroInt < 45796) {
				naList.add(array[i]);
			}

			if (45796 <= metroInt && metroInt < 46972) {
				daList.add(array[i]);
			}

			if (46972 <= metroInt && metroInt < 47560) {
				raList.add(array[i]);
			}

			if (47560 <= metroInt && metroInt < 48148) {
				maList.add(array[i]);
			}

			if (48148 <= metroInt && metroInt < 49324) {
				baList.add(array[i]);
			}

			if (49324 <= metroInt && metroInt < 50500) {
				saList.add(array[i]);
			}

			if (50500 <= metroInt && metroInt < 51088) {
				aaList.add(array[i]);
			}

			if (51088 <= metroInt && metroInt < 52264) {
				jaList.add(array[i]);
			}

			if (52264 <= metroInt && metroInt < 52852) {
				chaList.add(array[i]);
			}

			if (52852 <= metroInt && metroInt < 53440) {
				kaList.add(array[i]);
			}

			if (53440 <= metroInt && metroInt < 54028) {
				taList.add(array[i]);
			}

			if (54028 <= metroInt && metroInt < 54616) {
				paList.add(array[i]);
			}

			if (54616 <= metroInt) {
				haList.add(array[i]);
			}
		}

		req.setAttribute("gaList", gaList);
		req.setAttribute("naList", naList);
		req.setAttribute("daList", daList);
		req.setAttribute("raList", raList);
		req.setAttribute("maList", maList);
		req.setAttribute("baList", baList);
		req.setAttribute("saList", saList);
		req.setAttribute("aaList", aaList);
		req.setAttribute("jaList", jaList);
		req.setAttribute("chaList", chaList);
		req.setAttribute("kaList", kaList);
		req.setAttribute("taList", taList);
		req.setAttribute("paList", paList);
		req.setAttribute("haList", haList);

		return "alignTest";
	}

	@RequestMapping(value = "/MainReviewAjax.eat", method = { RequestMethod.GET })
	public String MainReviewAjax(HttpServletRequest req, HttpServletResponse res, HttpSession session) {

		String start = "1";
		String len = "20";

		int startRno = Integer.parseInt(start); // 공식!! 시작 행번호 1 3 5
		int endRno = startRno + Integer.parseInt(len) - 1; // 공식!! 끝 행번호
															// 1+2-1(==2)
															// 3+2-1(==4)
															// 5+2-1(==6)

		String StartRno = String.valueOf(startRno);
		String EndRno = String.valueOf(endRno);

		HashMap<String, String> map = new HashMap<String, String>();

		map.put("StartRno", StartRno);
		map.put("EndRno", EndRno);

		List<HashMap<String, String>> reviewList = reviewService.getRealReview(map);
		// int TotalReviewCount = service.getTotalReview(restSeq);

		req.setAttribute("reviewList", reviewList);
		return "review/realTimeReview";
	}

	//////////////////////////////////////////////////////// 은석17
	//////////////////////////////////////////////////////// //////////////////////////////////////////////////////////////
	// 1
	// 문의하기페이지로 이동하는 컨트롤러
	@RequestMapping(value = "/myQna.eat", method = { RequestMethod.GET })
	public String myQnA(HttpServletRequest req, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "로그인 후 이용해주세요");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		req.setAttribute("userSeq", loginUser.getUserSeq());
		return "QnA/myQna";
	}

	// 2
	// QnA/myQna.jsp페이지에서 등록하기를 누르면 등록해주는 컨트롤러
	@RequestMapping(value = "/myQnaRegister.eat", method = { RequestMethod.POST })
	public String myQnaRegister(HttpServletRequest req) {
		String userSeq = req.getParameter("userSeq");
		String qnaQuiry = req.getParameter("qnaQuiry");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaComment = req.getParameter("qnaComment");

		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("userSeq", userSeq);
		hashMap.put("qnaQuiry", qnaQuiry);
		hashMap.put("qnaSubject", qnaSubject);
		hashMap.put("qnaComment", qnaComment);

		int n = service.qnaRegister(hashMap);

		if (n == 0) {
			req.setAttribute("msg", "등록 실패하였습니다.");
			req.setAttribute("loc", "javascript:history.back();");
		} else if (n == 1) {
			req.setAttribute("msg", "등록 성공하였습니다.");
			req.setAttribute("loc", "myQnaList.eat?userSeq=" + userSeq);
		}

		return "QnA/msg";
	}

	// 3
	// 유저 한사람이 문의한 내역을 보여주는 컨트롤러
	@RequestMapping(value = "/myQnaList.eat", method = { RequestMethod.GET })
	public String login_myQnaList(HttpServletRequest req, HttpServletResponse res, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		String userSeq = loginUser.getUserSeq();

		/*
		 * 페이징 처리하기 글목록 보기 페이지 요청은 URL형태의 페이징 처리를 띄는 것으로 만들어 주어야 한다. 즉, 예를 들면
		 * 3페이지의 내용을 보고자 한다라면 /board/list.action?pageNo=3 같이한다.
		 */
		String pageNo = req.getParameter("startPageNo");
		
		System.out.println(">>>>>>>>>>>startPageNo= "+ pageNo);
		int totalCount = 0; // 총게시물 건수
		int sizePerPage = 5; // 한 페이지당 게시물 수
		int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다.

		int totalPage = 0; // 총 페이지수 (웹브라우저상에 보여줄 총 페이지 갯수)

		int start = 0; // 시작 행 번호
		int end = 0; // 끝 행 번호
		int startPageNo = 0; // 페이지바에서 시작될 페이지 번호
		/*
		 * 페이지바란 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지
		 * 와같이 페이지바라고 부른다. statrtPageNo는 1또는 6이 된다.
		 */
		int loop = 0; // statrtPageNo이 값이 증가할때마다 1씩 증가하는 용도
		int blockSize = 5; // 페이지바에 보여줄 페이지 갯수

		if (pageNo == null) {
			currentShowPageNo = 1;// 즉, 초기화면은 /board/list.action?pageNo=1
		} else {
			currentShowPageNo = Integer.parseInt(pageNo); // GET방식으로 파라미터
															// pageNo에 넘어온 값을 현재
															// 보여주고자 하는 페이지로 한다.
		}

		// 가져올 게시글의 범위를 구한다.(공식)
		/*
		 * currentShowPageNo start end 1page 1 5 2page 6 10 3page 11 15 4page 16
		 * 20 5page 21 25 6page 26 30 7page 31 35
		 */
		start = ((currentShowPageNo - 1) * sizePerPage) + 1;
		end = start + sizePerPage - 1;

		/*
		 * #.글조회수(readCount) 증가(DML문 update)는 반드시 해당 글제목을 클릭했을 경우에만 증가되고 웹브라우저에서
		 * 새로고침(F5)을 했을 경우에는 증가가 안되도록 하겠다. 이것을 하기위해서 우리는 session을 사용하여 처리한다.
		 */

		/*
		 * session에 readCountCheck라는 키값으로 저장된 밸류값은 no이다. session에
		 * readCountCheck라는 키값에 해당하는 밸류값이 "no"라고 얻으려면 반드시 웹브라우저 주소창에
		 * /list.action이라고 입력해야만 얻어올수 있다.
		 */

		// 검색어가 포함되어 이것을 주석처리
		/* List<BoardVO> list = service.list(); */

		String qnaColName = req.getParameter("qnaColName"); // 검색하고자하는 컬럼명 이름,
															// 제목
		String qnaSearch = req.getParameter("qnaSearch"); // 검색어
		String qnaInquiry = req.getParameter("qnaInquiry"); // 문의 유형 - 회원, 음식점,
															// 사업주, 기타
		String qnaProgress = req.getParameter("qnaProgress"); // 처리과정 접수완료, 답변완료

		if (qnaColName == null) {
			qnaColName = "userName";
		}

		if (qnaInquiry == null) {
			qnaInquiry = "전체";
		}

		if (qnaProgress == null) {
			qnaProgress = "전체";
		}

		// 검색기간 셀렉트
		String qnaRegYearStart = req.getParameter("qnaRegYearStart"); // 검색하고자
																		// 하는
																		// 기간의
																		// 시작 년
		String qnaRegMonthStart = req.getParameter("qnaRegMonthStart"); // 검색하고자
																		// 하는
																		// 기간의
																		// 시작 월
		String qnaRegDayStart = req.getParameter("qnaRegDayStart"); // 검색하고자 하는
																	// 기간의 시작 일

		String qnaRegYearEnd = req.getParameter("qnaRegYearEnd"); // 검색하고자 하는
																	// 기간의 끝 년
		String qnaRegMonthEnd = req.getParameter("qnaRegMonthEnd"); // 검색하고자 하는
																	// 기간의 끝 월
		String qnaRegDayEnd = req.getParameter("qnaRegDayEnd"); // 검색하고자 하는 기간의
																// 끝 일

		System.out.println(">>>>>>>>>>>> qnaRegDayStart == null :"+(qnaRegDayStart==null));
		System.out.println(">>>>>>>>>>>> qnaRegDayStart ="+qnaRegDayStart);
		System.out.println((qnaRegYearStart == null)+ ","+(qnaRegMonthStart == null)+ ","+(qnaRegDayStart == null)+ ","+(qnaRegYearEnd == null)+ ","+(qnaRegMonthEnd == null)+ ","+(qnaRegDayEnd == null));
		// myQnaList.jsp에 날짜 년월일 오늘 날짜로 설정하기위한 코드
		HashMap<String, String> hashMap3 = new HashMap<String, String>();
		hashMap3.put("str", "year");

		HashMap<String, String> hashMap4 = new HashMap<String, String>();
		hashMap4.put("str", "month");

		HashMap<String, String> hashMap5 = new HashMap<String, String>();
		hashMap5.put("str", "day");

		String todayYear = String.valueOf(service.getToday(hashMap3));
		String todayMonth = String.valueOf(service.getToday(hashMap4));
		String todayDay = String.valueOf(service.getToday(hashMap5));

		// myQnaList를 처음 실행했을떄 검색기간의 기본값을 설정하기위한 코드
		if (qnaRegYearStart == null && qnaRegMonthStart == null && qnaRegDayStart == null && qnaRegYearEnd == null
				&& qnaRegMonthEnd == null && qnaRegDayEnd == null) {
			qnaRegYearStart = todayYear;
			qnaRegMonthStart = "12";
			qnaRegDayStart = "01";
			qnaRegYearEnd = todayYear;
			qnaRegMonthEnd = todayMonth;

			if (Integer.parseInt(todayDay) < 10) {
				qnaRegDayEnd = "0" + todayDay;
			} else {

				qnaRegDayEnd = todayDay;
			}
		}

		// 검색기간 select의 option을 문자열로 보내준다.
		String strRegDateYearSelect = "";
		String strRegDateMonthSelect = "";
		String strRegDateDaySelect = "";

		for (int i = 2016; i <= 2026; ++i) {
			String year = String.valueOf(i);
			strRegDateYearSelect += "<option value='" + year + "'>" + year + "</option>";
		}

		for (int i = 1; i <= 12; ++i) {
			String month = String.valueOf(i);
			strRegDateMonthSelect += "<option value='" + month + "'>" + month + "</option>";
		}

		for (int i = 1; i <= 31; ++i) {
			String day = String.valueOf(i);
			if (i <= 9) {
				strRegDateDaySelect += "<option value='0" + day + "'>" + day + "</option>";
			} else {
				strRegDateDaySelect += "<option value='" + day + "'>" + day + "</option>";
			}

		}

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("qnaColName", qnaColName);
		map.put("qnaSearch", qnaSearch);
		map.put("qnaInquiry", qnaInquiry);
		map.put("userSeq", userSeq);
		map.put("qnaProgress", qnaProgress);
		// 날짜를 정해서 검색하기 위해
		map.put("searchStartDay", qnaRegYearStart + "-" + qnaRegMonthStart + "-" + qnaRegDayStart);
		map.put("searchEndDay", qnaRegYearEnd + "-" + qnaRegMonthEnd + "-" + qnaRegDayEnd);

		// 페이징처리를 위해 start end를 map에 추가하여 파라미터로 넘겨서 select되도록 한다.
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		map.put("userType", "회원");

		List<HashMap<String, String>> myQnaList = service.qnaList(map);

		// 페이징 작업의 계속(페이지바에 나타낼 총 페이지 갯수 구하기)
		/*
		 * 검색조건이 없을때의 총페이지 수와 검색조건이 있을때의 총페이지수를 구해야 한다. 검색조건이 없을때의 총페이지수 -->
		 * colname과 search값이 null인경우 검색조건이 있을때의 총페이지수 --> colname과 search값이
		 * null이 아닌 경우
		 */

		// 총 게시물건수를 구한다.
		totalCount = service.getTotalQnaCount(map);
		/* System.out.println("게시물 총갯수 : " + totalCount); */
		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

		// 이제부터 페이지바 작업을 한다.
		String pageBar = "";
		pageBar += "<ul class='pagination'>";

		/*
		 * 우리는 위에서 blocksize를 5로 설정했으므로 이전5페이지 [1][2][3][4][5] 다음5페이지 로 나와야 한다.
		 * 페이지 번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다. 위에서 선언한 loop를 사용한다. 이때
		 * loop는 blocksize의 크기보다 크면 안된다.
		 */
		loop = 1;
		/*************************
		 * 페이지바의 시작 페이지 번호(startPageNo)값 만들기
		 **************************/
		startPageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
		/*
		 * 현재 우리는 blockSize를 위에서 5로 설정했다. 만약에 조회하고자 하는 currentShowPageNo가
		 * 3페이지이라면((3 - 1)/5) * 5 + 1 ==>1 만약에 조회하고자 하는 currentShowPageNo가
		 * 7페이지이라면((7 - 1)/5) * 5 + 1 ==>6
		 */

		// ***** 이전 5페이지 만들기 *****

		if (startPageNo == 1) {// 첫 페이지바인 경우
			pageBar += String.format("<li><a>[이전%d페이지]</a></li>", blockSize);
		} else {// 첫 페이지바가 아닌경우
			if (qnaSearch == null) {//페이지 첫 로딩인 경우
				pageBar += String.format(
						"<li><a href='javascript:getMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,\"%s\")>[이전%d페이지]</a></li>",
						qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd, qnaRegDayEnd,
						qnaInquiry, startPageNo - 1, userSeq, qnaProgress, blockSize);
			}else if(!(qnaSearch.trim().length() == 0)){// 검색어가 있는 경우
				pageBar += String.format(
						"<li><a href='SgetMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,%s,%s,\"%s\");'>[이전%d페이지]</a></li>",
						qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd, qnaRegDayEnd,
						qnaInquiry, startPageNo - 1, userSeq, qnaColName, qnaSearch, qnaProgress, blockSize);
			}else {// 검색어가 있지만 비어있는 경우
				pageBar += String.format(
						"<li><a href='javascript:getMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,\"%s\")>[이전%d페이지]</a></li>",
						qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd, qnaRegDayEnd,
						qnaInquiry, startPageNo - 1, userSeq, qnaProgress, blockSize);
			}
		}

		while (!(loop > blockSize || startPageNo > totalPage)) {

			if (startPageNo == currentShowPageNo) {
				pageBar += String.format(
						"<li><span style='color:red; font-weight:bold; text-decoration:underline; '> %d </span></li>",
						startPageNo);
			} else {
				if (qnaSearch == null) {//페이지 첫 로딩인 경우
					System.out.println(">>>>>>>>>>"+qnaRegDayStart+"<<<<<<<<<<<");
					pageBar += String.format(
							"<li><a href='javascript:getMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,\"%s\");'>%d</a></li>",
							qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd,
							qnaRegDayEnd, qnaInquiry, startPageNo, userSeq, qnaProgress, startPageNo);
				}else if(!(qnaSearch.trim().length() == 0)){ //검색어가 있는 경우
					System.out.println(">>>>>>>>>>"+qnaColName+"<<<<<<<<<<<");
					pageBar += String.format(
							"<li><a href='javascript:SgetMyQnAList(\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%d\",\"%s\",\"%s\",\"%s\",\"%s\");'>%d</a></li>",
							qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd,
							qnaRegDayEnd, qnaInquiry, startPageNo, userSeq, qnaColName, qnaSearch, qnaProgress,
							startPageNo);
				}else {//검색어가 없는경우 
					pageBar += String.format(
							"<li><a href='javascript:getMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,\"%s\");'>%d</a></li>",
							qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd,
							qnaRegDayEnd, qnaInquiry, startPageNo, userSeq, qnaProgress, startPageNo);
				}// end of if else()----

			}

			loop++;
			startPageNo++;
		} // end of while

		// ***** 다음 5페이지 만들기 *****

		if (startPageNo > totalPage) {// 마지막 페이지바인 경우
			pageBar += String.format("<li><a>[다음%d페이지]</a></li>", blockSize);
		} else {// 마지막 페이지바가 아닌경우
			if (qnaSearch == null) {// 처음 접속시
				pageBar += String.format(
						"<li><a href='javascript:getMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,\"%s\");'>[다음%d페이지]</a></li>",
						qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd, qnaRegDayEnd,
						qnaInquiry, startPageNo, blockSize, userSeq, qnaProgress, blockSize);
			} else if(!(qnaSearch.trim().length() == 0)) {// 검색어가 있는 경우
				pageBar += String.format(
						"<li><a href='SgetMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,%s,%s,\"%s\");'>[다음%d페이지]</a></li>",
						qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd, qnaRegDayEnd,
						qnaInquiry, startPageNo, userSeq, qnaColName, qnaSearch, qnaProgress, blockSize);
			}
			else{
				pageBar += String.format(
						"<li><a href='javascript:getMyQnAList(%s,%s,%s,%s,%s,%s,\"%s\",%d,%s,\"%s\");'>[다음%d페이지]</a></li>",
						qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd, qnaRegDayEnd,
						qnaInquiry, startPageNo, blockSize, userSeq, qnaProgress, blockSize);
			}
		}

		pageBar += "</ul>";

		// myQnaList.jsp에 상단에 나의 문의내역중 접수/답변완료 갯수 알려주는 코드
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("userSeq", userSeq);
		hashMap.put("qnaColName", qnaColName);
		hashMap.put("qnaSearch", qnaSearch);
		hashMap.put("qnaInquiry", qnaInquiry);
		hashMap.put("userSeq", userSeq);
		hashMap.put("qnaProgress", qnaProgress);

		// 날짜를 정해서 검색하기 위해
		hashMap.put("searchStartDay", qnaRegYearStart + "-" + qnaRegMonthStart + "-" + qnaRegDayStart);
		hashMap.put("searchEndDay", qnaRegYearEnd + "-" + qnaRegMonthEnd + "-" + qnaRegDayEnd);

		hashMap.put("userType", "회원");

		if (qnaProgress.equals("전체")) {
			hashMap.put("qnaProgress", "접수완료");
		} else if (qnaProgress.equals("접수완료")) {
			hashMap.put("qnaProgress", qnaProgress);
		}

		// 만약 검색시 처리과정을 답변완료로 하면 접수완료의 수는 0이 되어야하므로 삼항연산자를 이용
		int registerQnaCount = (qnaProgress.equals("답변완료")) ? 0 : service.getQnaProgressCount(hashMap);

		HashMap<String, String> hashMap2 = new HashMap<String, String>();
		hashMap2.put("userSeq", userSeq);
		hashMap2.put("qnaColName", qnaColName);
		hashMap2.put("qnaSearch", qnaSearch);
		hashMap2.put("qnaInquiry", qnaInquiry);
		hashMap2.put("userSeq", userSeq);
		hashMap2.put("searchStartDay", qnaRegYearStart + "-" + qnaRegMonthStart + "-" + qnaRegDayStart);
		hashMap2.put("searchEndDay", qnaRegYearEnd + "-" + qnaRegMonthEnd + "-" + qnaRegDayEnd);
		hashMap2.put("userType", "회원");

		if (qnaProgress.equals("전체")) {
			hashMap2.put("qnaProgress", "답변완료");
		} else {
			hashMap2.put("qnaProgress", qnaProgress);
		}

		int answerQnaCount = (qnaProgress.equals("접수완료")) ? 0 : service.getQnaProgressCount(hashMap2);

		req.setAttribute("myQnaList", myQnaList);
		req.setAttribute("totalCount", totalCount);

		req.setAttribute("qnaColName", qnaColName);
		req.setAttribute("qnaSearch", qnaSearch);
		req.setAttribute("qnaInquiry", qnaInquiry);
		req.setAttribute("qnaProgress", qnaProgress);
		req.setAttribute("pageBar", pageBar);

		req.setAttribute("registerQnaCount", registerQnaCount);
		req.setAttribute("answerQnaCount", answerQnaCount);

		req.setAttribute("qnaRegYearStart", qnaRegYearStart);
		req.setAttribute("qnaRegMonthStart", qnaRegMonthStart);
		req.setAttribute("qnaRegDayStart", qnaRegDayStart);
		req.setAttribute("qnaRegYearEnd", qnaRegYearEnd);
		req.setAttribute("qnaRegMonthEnd", qnaRegMonthEnd);
		req.setAttribute("qnaRegDayEnd", qnaRegDayEnd);

		req.setAttribute("strRegDateYearSelect", strRegDateYearSelect);
		req.setAttribute("strRegDateMonthSelect", strRegDateMonthSelect);
		req.setAttribute("strRegDateDaySelect", strRegDateDaySelect);

		return "QnA/myQnaList";
	}

	// 4
	@RequestMapping(value = "/adminQnaList.eat", method = { RequestMethod.GET })
	public String login_adminQnaList(HttpServletRequest req, HttpServletResponse res, HttpSession session) {

		/*
		 * 페이징 처리하기 글목록 보기 페이지 요청은 URL형태의 페이징 처리를 띄는 것으로 만들어 주어야 한다. 즉, 예를 들면
		 * 3페이지의 내용을 보고자 한다라면 /board/list.action?pageNo=3 같이한다.
		 */
		String pageNo = req.getParameter("pageNo");
		int totalCount = 0; // 총게시물 건수
		int sizePerPage = 5; // 한 페이지당 게시물 수
		int currentShowPageNo = 1; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정한다.

		int totalPage = 0; // 총 페이지수 (웹브라우저상에 보여줄 총 페이지 갯수)

		int start = 0; // 시작 행 번호
		int end = 0; // 끝 행 번호
		int startPageNo = 0; // 페이지바에서 시작될 페이지 번호
		/*
		 * 페이지바란 이전5페이지 [1][2][3][4][5] 다음5페이지 이전5페이지 [6][7][8][9][10] 다음5페이지
		 * 와같이 페이지바라고 부른다. statrtPageNo는 1또는 6이 된다.
		 */
		int loop = 0; // statrtPageNo이 값이 증가할때마다 1씩 증가하는 용도
		int blockSize = 5; // 페이지바에 보여줄 페이지 갯수

		if (pageNo == null) {
			currentShowPageNo = 1;// 즉, 초기화면은 /board/list.action?pageNo=1
		} else {
			currentShowPageNo = Integer.parseInt(pageNo); // GET방식으로 파라미터
															// pageNo에 넘어온 값을 현재
															// 보여주고자 하는 페이지로 한다.
		}

		// 가져올 게시글의 범위를 구한다.(공식)
		/*
		 * currentShowPageNo start end 1page 1 5 2page 6 10 3page 11 15 4page 16
		 * 20 5page 21 25 6page 26 30 7page 31 35
		 */
		start = ((currentShowPageNo - 1) * sizePerPage) + 1;
		end = start + sizePerPage - 1;

		String qnaColName = req.getParameter("qnaColName");
		String qnaSearch = req.getParameter("qnaSearch");
		String qnaInquiry = req.getParameter("qnaInquiry");
		String qnaProgress = req.getParameter("qnaProgress");

		if (qnaColName == null) {
			qnaColName = "userName";
		}

		if (qnaInquiry == null) {
			qnaInquiry = "전체";
		}

		if (qnaProgress == null) {
			qnaProgress = "전체";
		}

		// 검색기간 셀렉트
		String qnaRegYearStart = req.getParameter("qnaRegYearStart");
		String qnaRegMonthStart = req.getParameter("qnaRegMonthStart");
		String qnaRegDayStart = req.getParameter("qnaRegDayStart");

		String qnaRegYearEnd = req.getParameter("qnaRegYearEnd");
		String qnaRegMonthEnd = req.getParameter("qnaRegMonthEnd");
		String qnaRegDayEnd = req.getParameter("qnaRegDayEnd");

		// myQnaList.jsp에 날짜 년월일 오늘 날짜로 설정하기위한 코드
		HashMap<String, String> hashMap3 = new HashMap<String, String>();
		hashMap3.put("str", "year");

		HashMap<String, String> hashMap4 = new HashMap<String, String>();
		hashMap4.put("str", "month");

		HashMap<String, String> hashMap5 = new HashMap<String, String>();
		hashMap5.put("str", "day");

		String todayYear = String.valueOf(service.getToday(hashMap3));
		String todayMonth = String.valueOf(service.getToday(hashMap4));
		String todayDay = String.valueOf(service.getToday(hashMap5));

		if (qnaRegYearStart == null && qnaRegMonthStart == null && qnaRegDayStart == null && qnaRegYearEnd == null
				&& qnaRegMonthEnd == null && qnaRegDayEnd == null) {
			qnaRegYearStart = todayYear;
			qnaRegMonthStart = "12";
			qnaRegDayStart = "01";

			qnaRegYearEnd = todayYear;
			qnaRegMonthEnd = todayMonth;

			if (Integer.parseInt(todayDay) < 10) {
				qnaRegDayEnd = "0" + todayDay;
			} else {

				qnaRegDayEnd = todayDay;
			}
		}

		String strRegDateYearSelect = "";
		String strRegDateMonthSelect = "";
		String strRegDateDaySelect = "";

		for (int i = 2016; i <= 2026; ++i) {
			String year = String.valueOf(i);
			strRegDateYearSelect += "<option value='" + year + "'>" + year + "</option>";
		}

		for (int i = 1; i <= 12; ++i) {
			String month = String.valueOf(i);
			strRegDateMonthSelect += "<option value='" + month + "'>" + month + "</option>";
		}

		for (int i = 1; i <= 31; ++i) {
			String day = String.valueOf(i);
			if (i <= 9) {
				strRegDateDaySelect += "<option value='0" + day + "'>" + day + "</option>";
			} else {
				strRegDateDaySelect += "<option value='" + day + "'>" + day + "</option>";
			}

		}

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("qnaColName", qnaColName);
		map.put("qnaSearch", qnaSearch);
		map.put("qnaInquiry", qnaInquiry);
		map.put("qnaProgress", qnaProgress);

		// 날짜를 정해서 검색하기 위해
		map.put("searchStartDay", qnaRegYearStart + "-" + qnaRegMonthStart + "-" + qnaRegDayStart);
		map.put("searchEndDay", qnaRegYearEnd + "-" + qnaRegMonthEnd + "-" + qnaRegDayEnd);

		// 페이징처리를 위해 start end를 map에 추가하여 파라미터로 넘겨서 select되도록 한다.
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		map.put("userType", "관리자");
		List<HashMap<String, String>> adminQnaList = service.qnaList(map);

		// 페이징 작업의 계속(페이지바에 나타낼 총 페이지 갯수 구하기)
		/*
		 * 검색조건이 없을때의 총페이지 수와 검색조건이 있을때의 총페이지수를 구해야 한다. 검색조건이 없을때의 총페이지수 -->
		 * colname과 search값이 null인경우 검색조건이 있을때의 총페이지수 --> colname과 search값이
		 * null이 아닌 경우
		 */

		// 총 게시물건수를 구한다.
		totalCount = service.getTotalQnaCount(map);
		/* System.out.println("게시물 총갯수 : " + totalCount); */
		totalPage = (int) Math.ceil((double) totalCount / sizePerPage);

		// 이제부터 페이지바 작업을 한다.
		String pageBar = "";
		pageBar += "<ul class='pagination'>";

		/*
		 * 우리는 위에서 blocksize를 5로 설정했으므로 이전5페이지 [1][2][3][4][5] 다음5페이지 로 나와야 한다.
		 * 페이지 번호는 1씩 증가하므로 페이지번호를 증가시켜주는 반복변수가 필요하다. 위에서 선언한 loop를 사용한다. 이때
		 * loop는 blocksize의 크기보다 크면 안된다.
		 */
		loop = 1;
		/*************************
		 * 페이지바의 시작 페이지 번호(startPageNo)값 만들기
		 **************************/
		startPageNo = ((currentShowPageNo - 1) / blockSize) * blockSize + 1;
		/*
		 * 현재 우리는 blockSize를 위에서 5로 설정했다. 만약에 조회하고자 하는 currentShowPageNo가
		 * 3페이지이라면((3 - 1)/5) * 5 + 1 ==>1 만약에 조회하고자 하는 currentShowPageNo가
		 * 7페이지이라면((7 - 1)/5) * 5 + 1 ==>6
		 */

		// ***** 이전 5페이지 만들기 *****

		if (startPageNo == 1) {// 첫 페이지바인 경우
			pageBar += String.format("<li><a>[이전%d페이지]</a></li>", blockSize);
		} else {// 첫 페이지바가 아닌경우
			if (qnaSearch == null) {// 검색어가 없는경우
				pageBar += String.format(
						"<li><a href='%s/adminQnaList.eat?qnaRegYearStart=%s&qnaRegMonthStart=%s&qnaRegDayStart=%s&qnaRegYearEnd=%s&qnaRegMonthEnd=%s&qnaRegDayEnd=%s&qnaInquiry=%s&pageNo=%d&qnaProgress=%s'>[이전%d페이지]</a></li>",
						req.getContextPath(), qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd,
						qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo - 1, qnaProgress, blockSize);
			} else {// 검색어가 있는 경우
				pageBar += String.format(
						"<li><a href='%s/adminQnaList.eat?qnaRegYearStart=%s&qnaRegMonthStart=%s&qnaRegDayStart=%s&qnaRegYearEnd=%s&qnaRegMonthEnd=%s&qnaRegDayEnd=%s&qnaInquiry=%s&pageNo=%d&qnaColName=%s&qnaSearch=%s&qnaProgress=%s'>[이전%d페이지]</a></li>",
						req.getContextPath(), qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd,
						qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo - 1, qnaColName, qnaSearch, qnaProgress,
						blockSize);
			}
		}

		while (!(loop > blockSize || startPageNo > totalPage)) {

			if (startPageNo == currentShowPageNo) {
				pageBar += String.format(
						"<li><span style='color:red; font-weight:bold; text-decoration:underline; '> %d </span></li>",
						startPageNo);
			} else {
				if (qnaSearch == null) {// 처음 접속시
					System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<"+qnaSearch+"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<1");
					pageBar += String.format(
							"<li>" + "<a href='%s/adminQnaList.eat?qnaRegYearStart=%s&qnaRegMonthStart=%s&qnaRegDayStart=%s&qnaRegYearEnd=%s&qnaRegMonthEnd=%s&qnaRegDayEnd=%s&qnaInquiry=%s&pageNo=%d&qnaProgress=%s'>%d</a></li>",
							req.getContextPath(), qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd,
							qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo, qnaProgress, startPageNo);
				} else {// 검색어가 있는 경우
					System.out.println("<<<<<<<<<<<<<<<<<<<<<<<<<<<"+qnaSearch+"<<<<<<<<<<<<<<<<<<<<<<<<<<<<2");
					pageBar += String.format(
							"<li><a href='%s/adminQnaList.eat?qnaRegYearStart=%s&qnaRegMonthStart=%s&qnaRegDayStart=%s&qnaRegYearEnd=%s&qnaRegMonthEnd=%s&qnaRegDayEnd=%s&qnaInquiry=%s&pageNo=%d&qnaColName=%s&qnaSearch=%s&qnaProgress=%s'>%d</a></li>",
							req.getContextPath(), qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd,
							qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo, qnaColName, qnaSearch, qnaProgress,
							startPageNo);
				}

			}

			loop++;
			startPageNo++;
		} // end of while

		// ***** 다음 5페이지 만들기 *****

		if (startPageNo > totalPage) {// 마지막 페이지바인 경우
			pageBar += String.format("<li><a>[다음%d페이지]</a></li>", blockSize);
		} else {// 마지막 페이지바가 아닌경우
			if (qnaSearch == null) {// 검색어가 없는경우
				pageBar += String.format(
						"<li><a href='%s/adminQnaList.eat?qnaRegYearStart=%s&qnaRegMonthStart=%s&qnaRegDayStart=%s&qnaRegYearEnd=%s&qnaRegMonthEnd=%s&qnaRegDayEnd=%s&qnaInquiry=%s&pageNo=%d&qnaProgress=%s'>[다음%d페이지]</a></li>",
						req.getContextPath(), qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd,
						qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo, qnaProgress, blockSize);
			} else {// 검색어가 있는 경우
				pageBar += String.format(
						"<li><a href='%s/adminQnaList.eat?qnaRegYearStart=%s&qnaRegMonthStart=%s&qnaRegDayStart=%s&qnaRegYearEnd=%s&qnaRegMonthEnd=%s&qnaRegDayEnd=%s&qnaInquiry=%s&pageNo=%d&qnaColName=%s&qnaSearch=%s&qnaProgress=%s'>[다음%d페이지]</a></li>",
						req.getContextPath(), qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd,
						qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo, qnaColName, qnaSearch, qnaProgress,
						blockSize);
			}
		}

		pageBar += "</ul>";

		// myQnaList.jsp에 상단에 나의 문의내역중 접수/답변완료 갯수 알려주는 코드
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("qnaProgress", "접수완료");
		hashMap.put("qnaColName", qnaColName);
		hashMap.put("qnaSearch", qnaSearch);
		hashMap.put("qnaInquiry", qnaInquiry);

		// 날짜를 정해서 검색하기 위해
		hashMap.put("searchStartDay", qnaRegYearStart + "-" + qnaRegMonthStart + "-" + qnaRegDayStart);
		hashMap.put("searchEndDay", qnaRegYearEnd + "-" + qnaRegMonthEnd + "-" + qnaRegDayEnd);
		hashMap.put("userType", "관리자");

		if (qnaProgress.equals("전체")) {
			hashMap.put("qnaProgress", "접수완료");
		} else if (qnaProgress.equals("접수완료")) {
			hashMap.put("qnaProgress", qnaProgress);
		}

		int registerQnaCount = (qnaProgress.equals("답변완료")) ? 0 : service.getQnaProgressCount(hashMap);

		HashMap<String, String> hashMap2 = new HashMap<String, String>();
		hashMap2.put("qnaProgress", "답변완료");
		hashMap2.put("qnaColName", qnaColName);
		hashMap2.put("qnaSearch", qnaSearch);
		hashMap2.put("qnaInquiry", qnaInquiry);
		hashMap2.put("searchStartDay", qnaRegYearStart + "-" + qnaRegMonthStart + "-" + qnaRegDayStart);
		hashMap2.put("searchEndDay", qnaRegYearEnd + "-" + qnaRegMonthEnd + "-" + qnaRegDayEnd);
		hashMap2.put("userType", "관리자");

		if (qnaProgress.equals("전체")) {
			hashMap2.put("qnaProgress", "답변완료");
		} else {
			hashMap2.put("qnaProgress", qnaProgress);
		}

		int answerQnaCount = (qnaProgress.equals("접수완료")) ? 0 : service.getQnaProgressCount(hashMap2);

		req.setAttribute("adminQnaList", adminQnaList);
		req.setAttribute("totalCount", totalCount);

		req.setAttribute("qnaColName", qnaColName);
		req.setAttribute("qnaSearch", qnaSearch);
		req.setAttribute("qnaInquiry", qnaInquiry);
		req.setAttribute("qnaProgress", qnaProgress);
		req.setAttribute("pageBar", pageBar);

		req.setAttribute("registerQnaCount", registerQnaCount);
		req.setAttribute("answerQnaCount", answerQnaCount);

		req.setAttribute("qnaRegYearStart", qnaRegYearStart);
		req.setAttribute("qnaRegMonthStart", qnaRegMonthStart);
		req.setAttribute("qnaRegDayStart", qnaRegDayStart);
		req.setAttribute("qnaRegYearEnd", qnaRegYearEnd);
		req.setAttribute("qnaRegMonthEnd", qnaRegMonthEnd);
		req.setAttribute("qnaRegDayEnd", qnaRegDayEnd);

		req.setAttribute("strRegDateYearSelect", strRegDateYearSelect);
		req.setAttribute("strRegDateMonthSelect", strRegDateMonthSelect);
		req.setAttribute("strRegDateDaySelect", strRegDateDaySelect);

		return "QnA/adminQnaList";
	}

	// 5
	// 관리자가 adminQnaList에서 문의제목을 클릭하면 회원의 질문사항을 보여주는 컨트롤러
	@RequestMapping(value = "/adminSeeUserQuestion.eat", method = { RequestMethod.GET })
	public String adminSeeUserQuestion(HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");
		String userName = req.getParameter("userName");
		String qnaInquiry = req.getParameter("qnaInquiry");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaRegDate = req.getParameter("qnaRegDate");
		String qnaContent = req.getParameter("qnaContent");
		String qnaProgress = req.getParameter("qnaProgress");

		req.setAttribute("userName", userName);
		req.setAttribute("qnaInquiry", qnaInquiry);
		req.setAttribute("qnaSubject", qnaSubject);
		req.setAttribute("qnaRegDate", qnaRegDate);
		req.setAttribute("qnaContent", qnaContent);
		req.setAttribute("qnaProgress", qnaProgress);
		req.setAttribute("qnaSeq", qnaSeq);

		return "QnA/adminSeeUserQuestion";
	}

	// 6
	// myQnaList에서 제목을 클릭하면 사용자의 질문을 보는 컨트롤러
	@RequestMapping(value = "/userSeeUserQuestion.eat", method = { RequestMethod.GET })
	public String userSeeUserQuestion(HttpServletRequest req) {
		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");
		String userName = req.getParameter("userName");

		HashMap<String, String> userQuestion = service.getUserQuestion(qnaSeq);
		req.setAttribute("userQuestion", userQuestion);
		req.setAttribute("userName", userName);
		req.setAttribute("qnaSeq", qnaSeq);
		return "QnA/userSeeUserQuestion";
	}

	// 7
	// 관리자가 adminQnaList에서 답변완료를 클릭하면 관리자의 답변을 보여주는 컨트롤러
	@RequestMapping(value = "/adminSeeAdminAnswer.eat", method = { RequestMethod.GET })
	public String adminSeeAdminAnswer(HttpServletRequest req) {

		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");

		HashMap<String, String> andminAnswer = service.getAdminAnswer(qnaSeq);
		req.setAttribute("andminAnswer", andminAnswer);
		req.setAttribute("qnaSeq", qnaSeq);
		return "QnA/adminSeeAdminAnswer";
	}

	// 8
	// myQnaList에서 답변완료를 클릭하면 사용자가 관리자의 답변을 보는 컨트롤러
	@RequestMapping(value = "/userSeeAdminAnswer.eat", method = { RequestMethod.GET })
	public String userSeeAdminAnswer(HttpServletRequest req) {

		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");

		HashMap<String, String> andminAnswer = service.getAdminAnswer(qnaSeq);
		req.setAttribute("andminAnswer", andminAnswer);
		return "QnA/userSeeAdminAnswer";
	}

	// 9
	@RequestMapping(value = "/adminAnswerEdit.eat", method = { RequestMethod.GET })
	public String adminAnswerEdit(HttpServletRequest req) {

		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");
		String qnaInquiry = req.getParameter("qnaInquiry");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaRegDate = req.getParameter("qnaRegDate");
		String qnaProgress = req.getParameter("qnaProgress");

		req.setAttribute("qnaSeq", qnaSeq);
		req.setAttribute("qnaInquiry", qnaInquiry);
		req.setAttribute("qnaSubject", qnaSubject);
		req.setAttribute("qnaRegDate", qnaRegDate);
		req.setAttribute("qnaProgress", qnaProgress);
		return "QnA/adminAnswerEdit";
	}

	// 10
	@RequestMapping(value = "/userQuestionEdit.eat", method = { RequestMethod.GET })
	public String uesrQuestionEdit(HttpServletRequest req) {

		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");
		String userName = req.getParameter("userName");
		String qnaInquiry = req.getParameter("qnaInquiry");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaRegDate = req.getParameter("qnaRegDate");
		String qnaProgress = req.getParameter("qnaProgress");

		req.setAttribute("qnaSeq", qnaSeq);
		req.setAttribute("userName", userName);
		req.setAttribute("qnaInquiry", qnaInquiry);
		req.setAttribute("qnaSubject", qnaSubject);
		req.setAttribute("qnaRegDate", qnaRegDate);
		req.setAttribute("qnaProgress", qnaProgress);
		return "QnA/userQuestionEdit";
	}

	// 11
	@RequestMapping(value = "/adminAnswerEditEnd.eat", method = { RequestMethod.GET })
	public String adminAnswerEditEnd(HttpServletRequest req) {

		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaComment = req.getParameter("qnaComment");

		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("qnaSeq", qnaSeq);
		hashMap.put("qnaSubject", qnaSubject);
		hashMap.put("qnaComment", qnaComment);

		int n = service.editAdminAnswer(hashMap);

		if (n == 0) {
			req.setAttribute("msg", "수정이 실패하였습니다.");
			req.setAttribute("loc", "javascript:history.back();");
		} else if (n == 1) {
			req.setAttribute("msg", "수정이 성공하였습니다.");
			req.setAttribute("loc", "javascript:self.close();");
		}
		return "QnA/msg";
	}

	// 12
	@RequestMapping(value = "/userQuestionEditEnd.eat", method = { RequestMethod.GET })
	public String userQuestionEditEnd(HttpServletRequest req) {

		HttpSession session = req.getSession();
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			req.setAttribute("msg", "잘못된 접근입니다.");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		String qnaSeq = req.getParameter("qnaSeq");
		String qnaInquiry = req.getParameter("qnaInquiry");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaComment = req.getParameter("qnaComment");

		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("qnaSeq", qnaSeq);
		hashMap.put("qnaInquiry", qnaInquiry);
		hashMap.put("qnaSubject", qnaSubject);
		hashMap.put("qnaComment", qnaComment);

		int n = service.editUserQuestion(hashMap);

		if (n == 0) {
			req.setAttribute("msg", "수정이 실패하였습니다.");
			req.setAttribute("loc", "javascript:history.back();");
		} else if (n == 1) {
			req.setAttribute("msg", "수정이 성공하였습니다.");
			req.setAttribute("loc", "javascript:self.close();");
		}
		return "QnA/msg";
	}

	// 13
	// 관리자가 회원의 답변을 등록하는 컨트롤러
	@RequestMapping(value = "/adminAnswerRegister.eat", method = { RequestMethod.POST })
	public String adminAnswerRegister(HttpServletRequest req) {

		String qnaSeq = req.getParameter("qnaSeq");
		String qnaSubject = req.getParameter("qnaSubject");
		String qnaContent = req.getParameter("qnaComment");

		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("qnaSubject", qnaSubject);
		hashMap.put("qnaComment", qnaContent);
		hashMap.put("qnaSeq", qnaSeq);

		int result = service.adminAnswerRegister(hashMap);

		if (result < 2) {
			req.setAttribute("msg", "답변등록이 실패하였습니다.");
			req.setAttribute("loc", "javascript:history.back();");
		} else if (result == 2) {
			req.setAttribute("msg", "답변등록이 성공하였습니다.");
			req.setAttribute("loc", "adminQnaList.eat");
		}

		return "QnA/msg";
	}

	// 14
	// adminQnaList에서 Q&A를 삭제하는 컨트롤러
	@RequestMapping(value = "/deleteQna.eat", method = { RequestMethod.POST })
	public String deleteQna(HttpServletRequest req, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");

		String qnaColName = req.getParameter("qnaColNameDeleteFrm");
		String qnaSearch = req.getParameter("qnaSearchDeleteFrm");
		String qnaInquiry = req.getParameter("qnaInquiryDeleteFrm");
		String qnaRegYearStart = req.getParameter("qnaRegYearStartDeleteFrm");
		String qnaRegMonthStart = req.getParameter("qnaRegMonthStartDeleteFrm");
		String qnaRegDayStart = req.getParameter("qnaRegDayStartDeleteFrm");
		String qnaRegYearEnd = req.getParameter("qnaRegYearEndDeleteFrm");
		String qnaRegMonthEnd = req.getParameter("qnaRegMonthEndDeleteFrm");
		String qnaRegDayEnd = req.getParameter("qnaRegDayEndDeleteFrm");
		String qnaProgress = req.getParameter("qnaProgressDeleteFrm");

		String[] qnaSeqArr = req.getParameterValues("qnaSeqCheckBox");

		int count = service.countAnswer(qnaSeqArr);
		int result = service.deleteQna(qnaSeqArr);

		String loc = "";

		if (loginUser.getUserSeq().equals("0")) {
			loc = String.format(
					"adminQnaList.eat?qnaRegYearStart=%s&qnaRegMonthStart=%s&qnaRegDayStart=%s&qnaRegYearEnd=%s&qnaRegMonthEnd=%s&qnaRegDayEnd=%s&qnaInquiry=%s&qnaColName=%s&qnaSearch=%s&qnaProgress=%s",
					qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd, qnaRegMonthEnd, qnaRegDayEnd,
					qnaInquiry, qnaColName, qnaSearch, qnaProgress);
		} else if (loginUser.getUserSeq().equals("1")) {
			loc = "userMyPage.eat";
		}

		if (count + qnaSeqArr.length == result) {
			req.setAttribute("msg", "삭제가 완료되었습니다.");
			req.setAttribute("loc", loc);

		} else {
			req.setAttribute("msg", "삭제가 실패되었습니다.");
			req.setAttribute("loc", "javascript:history.back();");
		}

		return "QnA/msg";
	}

	// 15
	@RequestMapping(value = "/faq.eat", method = { RequestMethod.GET })
	public String faq(HttpServletRequest req, HttpServletResponse res) {

		List<FaqVO> faqList = service.getFaqList();
		req.setAttribute("faqList", faqList);
		return "QnA/FAQ";
	}

	// 16
	@RequestMapping(value = "/faqDetail.eat", method = { RequestMethod.GET })
	public String faqDetail(HttpServletRequest req) {
		String faqSeq = req.getParameter("faqSeq");
		FaqVO vo = service.selectOneFaq(faqSeq);

		req.setAttribute("vo", vo);
		return "QnA/faqDetail";
	}

	// 17
	@RequestMapping(value = "/faqListByType.eat", method = { RequestMethod.GET })
	public String faqListByType(HttpServletRequest req) {
		String faqType = req.getParameter("faqType");
		List<FaqVO> faqList = service.getFaqListByType(faqType);
		String count = req.getParameter("count");

		if (count == null) {
			count = "0";
		}

		req.setAttribute("faqList", faqList);
		req.setAttribute("faqType", faqType);
		req.setAttribute("count", count);
		return "QnA/faqListByType";

	}
	//////////////////////////////////////////////////////// 은석17
	//////////////////////////////////////////////////////// //////////////////////////////////////////////////////////////

	@RequestMapping(value = "/report.eat", method = { RequestMethod.GET })
	public String report(HttpServletRequest req, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		System.out.println("///////////////////////////////////////////////////////");
		if (loginUser == null) {
			req.setAttribute("msg", "로그인 후 이용해주세요");
			req.setAttribute("loc", "javascript:history.back();");
			return "QnA/msg";
		}

		req.setAttribute("userSeq", loginUser.getUserSeq());
		return "QnA/report";
	}
}
