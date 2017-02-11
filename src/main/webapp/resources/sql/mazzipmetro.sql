/* 유저테이블 */
CREATE TABLE TBL_User (
	userSeq NUMBER NOT NULL, /* 유저번호 */
	gradeSeq VARCHAR2(20), /* 유저등급 */
	userName VARCHAR2(30) NOT NULL, /* 유저이름 */
	userEmail VARCHAR2(50) NOT NULL, /* 유저이메일 */
	userPw VARCHAR2(30) NOT NULL, /* 유저비밀번호 */
	userGender VARCHAR2(10) NOT NULL, /* 유저성별 */
	userBirthDay VARCHAR2(8) NOT NULL, /* 유저생일 */
	userPhone VARCHAR2(13) NOT NULL, /* 유저핸드폰 */
	userRegDate DATE DEFAULT sysdate NOT NULL, /* 유저가입일 */
	userProfile VARCHAR2(50), /* 유저프로필이미지 */
	userPoint NUMBER DEFAULT 0 NOT NULL, /* 유저포인트 */
	userExp NUMBER DEFAULT 0, /* 유저경험치 */
	userStation VARCHAR2(100), /* 유저선호지역 */
	userSort NUMBER NOT NULL, /* 유저구분 */
	userStatus NUMBER DEFAULT 0 NOT NULL /* 유저상태 */
);

COMMENT ON TABLE TBL_User IS '유저테이블';

COMMENT ON COLUMN TBL_User.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_User.gradeSeq IS '유저등급';

COMMENT ON COLUMN TBL_User.userName IS '유저이름';

COMMENT ON COLUMN TBL_User.userEmail IS '유저이메일';

COMMENT ON COLUMN TBL_User.userPw IS '유저비밀번호';

COMMENT ON COLUMN TBL_User.userGender IS '유저성별';

COMMENT ON COLUMN TBL_User.userBirthDay IS '유저생일';

COMMENT ON COLUMN TBL_User.userPhone IS '유저핸드폰';

COMMENT ON COLUMN TBL_User.userRegDate IS '유저가입일';

COMMENT ON COLUMN TBL_User.userProfile IS '유저프로필이미지';

COMMENT ON COLUMN TBL_User.userPoint IS '유저포인트';

COMMENT ON COLUMN TBL_User.userExp IS '유저경험치';

COMMENT ON COLUMN TBL_User.userStation IS '유저선호지역';

COMMENT ON COLUMN TBL_User.userSort IS 'userStatus는 1,2,3의 3가지 경우가 존재한다
1 : 일반유저
2 : 사업주
3 : 관리자';

COMMENT ON COLUMN TBL_User.userStatus IS 'status는 0, 1의 2가지 경우가 존재한다
0 : 사용가능
1 : 휴면계정
2: 사용불가능';

CREATE UNIQUE INDEX PK_TBL_User_userName
	ON TBL_User (
		userSeq ASC
	);

CREATE UNIQUE INDEX UQ_TBL_User_userEmail
	ON TBL_User (
		userEmail ASC
	);

ALTER TABLE TBL_User
	ADD
		CONSTRAINT PK_TBL_User
		PRIMARY KEY (
			userSeq
		);

ALTER TABLE TBL_User
	ADD
		CONSTRAINT UK_TBL_User_userEmail
		UNIQUE (
			userEmail
		);

ALTER TABLE TBL_User
	ADD
		CONSTRAINT CK_TBL_User_userStatus
		CHECK (userStatus in (1, 2, 3));

ALTER TABLE TBL_User
	ADD
		CONSTRAINT CK_TBL_User_status
		CHECK (status in (0,1,2));

/* 등급테이블 */
CREATE TABLE TBL_Grade (
	gradeSeq VARCHAR2(20) NOT NULL, /* 등급번호 */
	gradeName VARCHAR2(30) NOT NULL, /* 등급명 */
	gradeExp NUMBER, /* 등급별 사용자 경험치 */
	gradeReviewNum NUMBER, /* 등급필요리뷰수 */
	gradeScore NUMBER /* 등급필요점수 */
);

COMMENT ON TABLE TBL_Grade IS '등급테이블';

COMMENT ON COLUMN TBL_Grade.gradeSeq IS '등급번호';

COMMENT ON COLUMN TBL_Grade.gradeName IS '등급명';

COMMENT ON COLUMN TBL_Grade.gradeExp IS '등급별 사용자 경험치';

COMMENT ON COLUMN TBL_Grade.gradeReviewNum IS '등급필요리뷰수';

COMMENT ON COLUMN TBL_Grade.gradeScore IS '등급필요점수';

CREATE UNIQUE INDEX PK_TBL_Grade
	ON TBL_Grade (
		gradeSeq ASC
	);

ALTER TABLE TBL_Grade
	ADD
		CONSTRAINT PK_TBL_Grade
		PRIMARY KEY (
			gradeSeq
		);

/* 업장테이블 */
CREATE TABLE TBL_Restaurant (
	restSeq NUMBER NOT NULL, /* 업장번호 */
	userSeq NUMBER NOT NULL, /* 유저번호 */
	gradeSeq VARCHAR2(20) NOT NULL, /* 업장등급 */
	restName VARCHAR2(50) NOT NULL, /* 업장이름 */
	restPhone VARCHAR2(30), /* 업장전화번호 */
	restImg VARCHAR2(100), /* 업장대표이미지 */
	restAddr VARCHAR2(200) NOT NULL, /* 업장지번주소 */
	restNewAddr VARCHAR2(200), /* 업장도로명주소 */
	restLatitude NUMBER, /* 업장 위도 */
	restLongitude NUMBER, /* 업장 경도 */
	restZIndex VARCHAR2(30) NOT NULL, /* 업장Z인덱스 */
	dongId VARCHAR2(10) NOT NULL, /* 업장동 */
	metroId VARCHAR2(10) NOT NULL, /* 업장소속지하철 */
	restRegDate DATE DEFAULT sysdate NOT NULL, /* 업장등록일자 */
	restVisitor NUMBER, /* 업장방문수 */
	restStatus NUMBER DEFAULT 0 NOT NULL, /* 업장상태 */
	restContent CLOB, /* 업장소개글 */
	restBgTag VARCHAR2(50), /* 대분류 */
	restMdTag VARCHAR2(50) /* 중분류 */
);

COMMENT ON TABLE TBL_Restaurant IS '업장테이블';

COMMENT ON COLUMN TBL_Restaurant.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Restaurant.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_Restaurant.gradeSeq IS '업장등급';

COMMENT ON COLUMN TBL_Restaurant.restName IS '업장이름';

COMMENT ON COLUMN TBL_Restaurant.restPhone IS '업장전화번호';

COMMENT ON COLUMN TBL_Restaurant.restImg IS '업장대표이미지';

COMMENT ON COLUMN TBL_Restaurant.restAddr IS '업장지번주소';

COMMENT ON COLUMN TBL_Restaurant.restNewAddr IS '업장도로명주소';

COMMENT ON COLUMN TBL_Restaurant.restLatitude IS '업장 위도';

COMMENT ON COLUMN TBL_Restaurant.restLongitude IS '업장 경도';

COMMENT ON COLUMN TBL_Restaurant.restZIndex IS '업장Z인덱스';

COMMENT ON COLUMN TBL_Restaurant.dongId IS '업장동';

COMMENT ON COLUMN TBL_Restaurant.metroId IS '업장소속지하철';

COMMENT ON COLUMN TBL_Restaurant.restRegDate IS '업장등록일자';

COMMENT ON COLUMN TBL_Restaurant.restVisitor IS '업장방문수';

COMMENT ON COLUMN TBL_Restaurant.restStatus IS '업장상태는 0과 1 두 가지 숫자만 가능하다
0 : 사용가능
1 : 삭제된 업장';

COMMENT ON COLUMN TBL_Restaurant.restContent IS '업장소개글';

COMMENT ON COLUMN TBL_Restaurant.restBgTag IS '대분류';

COMMENT ON COLUMN TBL_Restaurant.restMdTag IS '중분류';

CREATE UNIQUE INDEX PK_TBL_Restaurant_restSeq
	ON TBL_Restaurant (
		restSeq ASC
	);

CREATE UNIQUE INDEX UIX_TBL_Restaurant_restPhone
	ON TBL_Restaurant (
		restPhone ASC
	);

ALTER TABLE TBL_Restaurant
	ADD
		CONSTRAINT PK_TBL_Restaurant
		PRIMARY KEY (
			restSeq
		);

ALTER TABLE TBL_Restaurant
	ADD
		CONSTRAINT UK_TBL_Restaurant
		UNIQUE (
			restPhone
		);

ALTER TABLE TBL_Restaurant
	ADD
		CONSTRAINT CK_TBL_Restaurant_restStatus
		CHECK (restStatus in (0,1));

/* 업장평가테이블 */
CREATE TABLE TBL_Restaurant_Judge (
	restSeq NUMBER NOT NULL, /* 업장번호 */
	reviewSeq NUMBER, /* 리뷰번호 */
	restScroe NUMBER, /* 업장점수 */
	restReview NUMBER /* 업장리뷰갯수 */
);

COMMENT ON TABLE TBL_Restaurant_Judge IS '업장평가테이블';

COMMENT ON COLUMN TBL_Restaurant_Judge.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Restaurant_Judge.reviewSeq IS '리뷰번호';

COMMENT ON COLUMN TBL_Restaurant_Judge.restScroe IS '업장점수';

COMMENT ON COLUMN TBL_Restaurant_Judge.restReview IS '업장리뷰갯수';

CREATE UNIQUE INDEX PK_TBL_Restaurant_Judge
	ON TBL_Restaurant_Judge (
		restSeq ASC
	);

ALTER TABLE TBL_Restaurant_Judge
	ADD
		CONSTRAINT PK_TBL_Restaurant_Judge
		PRIMARY KEY (
			restSeq
		);

/* 업장컨텐츠테이블 */
CREATE TABLE TBL_Restaurant_Content (
	restSeq NUMBER NOT NULL, /* 업장번호 */
	userSeq NUMBER NOT NULL, /* 유저번호 */
	contentSeq NUMBER NOT NULL, /* 컨텐츠번호 */
	contentBuyDate DATE NOT NULL, /* 컨텐츠구매일자 */
	contentLimit DATE NOT NULL, /* 컨텐츠기한 */
	contentStatus NUMBER DEFAULT 0 NOT NULL /* 컨텐츠상태 */
);

COMMENT ON TABLE TBL_Restaurant_Content IS '업장컨텐츠테이블';

COMMENT ON COLUMN TBL_Restaurant_Content.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Restaurant_Content.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_Restaurant_Content.contentSeq IS '컨텐츠번호';

COMMENT ON COLUMN TBL_Restaurant_Content.contentBuyDate IS '컨텐츠구매일자';

COMMENT ON COLUMN TBL_Restaurant_Content.contentLimit IS '컨텐츠기한';

COMMENT ON COLUMN TBL_Restaurant_Content.contentStatus IS '컨텐츠상태는 0과 1 두 가지 숫자만 가능하다
0 : 사용가능
1 : 삭제된 컨텐츠';

ALTER TABLE TBL_Restaurant_Content
	ADD
		CONSTRAINT CK_TBL_Restaurant_Content_Status
		CHECK (contentStatus in (0, 1));

/* 컨텐츠테이블 */
CREATE TABLE TBL_Content_Cat (
	contentSeq NUMBER NOT NULL, /* 컨텐츠번호 */
	contentName VARCHAR2(30) NOT NULL, /* 컨텐츠명 */
	contentPrice NUMBER NOT NULL /* 컨텐츠가격 */
);

COMMENT ON TABLE TBL_Content_Cat IS '컨텐츠테이블';

COMMENT ON COLUMN TBL_Content_Cat.contentSeq IS '컨텐츠번호';

COMMENT ON COLUMN TBL_Content_Cat.contentName IS '컨텐츠명';

COMMENT ON COLUMN TBL_Content_Cat.contentPrice IS '컨텐츠가격';

CREATE UNIQUE INDEX PK_TBL_Content_Cat
	ON TBL_Content_Cat (
		contentSeq ASC
	);

ALTER TABLE TBL_Content_Cat
	ADD
		CONSTRAINT PK_TBL_Content_Cat
		PRIMARY KEY (
			contentSeq
		);

/* 업장방문객테이블 */
CREATE TABLE TBL_Restaurant_Visitor (
	restSeq NUMBER NOT NULL, /* 업장번호 */
	userGender VARCHAR2(10) NOT NULL, /* 유저성별 */
	userBirthDay VARCHAR2(8) NOT NULL /* 유저생일 */
);

COMMENT ON TABLE TBL_Restaurant_Visitor IS '업장방문객테이블';

COMMENT ON COLUMN TBL_Restaurant_Visitor.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Restaurant_Visitor.userGender IS '유저성별';

COMMENT ON COLUMN TBL_Restaurant_Visitor.userBirthDay IS '유저생일';

/* 리뷰테이블 */
CREATE TABLE TBL_Review (
	reviewSeq NUMBER NOT NULL, /* 리뷰번호 */
	userSeq NUMBER NOT NULL, /* 유저번호 */
	restSeq NUMBER, /* 업장번호 */
	reviewTitle VARCHAR2(100) NOT NULL, /* 리뷰제목 */
	reviewContent VARCHAR2(4000) NOT NULL, /* 리뷰내용 */
	reviewScore NUMBER DEFAULT 0 NOT NULL, /* 리뷰점수 */
	reviewHit NUMBER DEFAULT 0, /* 리뷰방문객 */
	reviewMood NUMBER NOT NULL, /* 리뷰평점 분위기 */
	reviewTaste NUMBER NOT NULL, /* 리뷰평점 맛 */
	reviewPrice NUMBER NOT NULL, /* 리뷰평점 가격 */
	reviewService NUMBER NOT NULL, /* 리뷰평점 서비스 */
	reviewAvgScore NUMBER NOT NULL, /* 리뷰평점 */
	reviewRegDate VARCHAR2(30) NOT NULL, /* 리뷰등록일자 */
	reviewStatus NUMBER(1) DEFAULT 0 NOT NULL, /* 리뷰상태 */
	reviewBTag VARCHAR2(50), /* 리뷰 대분류 */
	reviewMTag VARCHAR2(50) /* 리뷰 중분류 */
);

COMMENT ON TABLE TBL_Review IS '리뷰테이블';

COMMENT ON COLUMN TBL_Review.reviewSeq IS '리뷰번호';

COMMENT ON COLUMN TBL_Review.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_Review.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Review.reviewTitle IS '리뷰제목';

COMMENT ON COLUMN TBL_Review.reviewContent IS '리뷰내용';

COMMENT ON COLUMN TBL_Review.reviewScore IS '리뷰점수';

COMMENT ON COLUMN TBL_Review.reviewHit IS '리뷰방문객';

COMMENT ON COLUMN TBL_Review.reviewMood IS '리뷰평점 분위기';

COMMENT ON COLUMN TBL_Review.reviewTaste IS '리뷰평점 맛';

COMMENT ON COLUMN TBL_Review.reviewPrice IS '리뷰평점 가격';

COMMENT ON COLUMN TBL_Review.reviewService IS '리뷰평점 서비스';

COMMENT ON COLUMN TBL_Review.reviewAvgScore IS '리뷰평점';

COMMENT ON COLUMN TBL_Review.reviewRegDate IS '리뷰등록일자';

COMMENT ON COLUMN TBL_Review.reviewStatus IS '리뷰상태는 0과 1 두 가지 숫자만 가능하다
0 : 사용가능
1 : 삭제된 리뷰';

COMMENT ON COLUMN TBL_Review.reviewBTag IS '리뷰 대분류';

COMMENT ON COLUMN TBL_Review.reviewMTag IS '리뷰 중분류';

CREATE UNIQUE INDEX PK_TBL_Review
	ON TBL_Review (
		reviewSeq ASC
	);

ALTER TABLE TBL_Review
	ADD
		CONSTRAINT PK_TBL_Review
		PRIMARY KEY (
			reviewSeq
		);

ALTER TABLE TBL_Review
	ADD
		CONSTRAINT CK_TBL_Review_Status
		CHECK (reviewStatus in (0,1));

/* 유저출석테이블 */
CREATE TABLE TBL_User_Attend (
	userSeq NUMBER NOT NULL, /* 유저번호 */
	allAttendDay NUMBER DEFAULT 0, /* 전체출석일수 */
	continueAttendDay NUMBER, /* 새 컬럼 */
	attendLastDay DATE DEFAULT sysdate, /* 마지막출석일 */
	userRandomBox NUMBER DEFAULT 0, /* 유저랜덤박스갯수 */
	userPremiumRandomBox NUMBER, /* 유저프리미엄랜덤박스갯수 */
	alertUpgradeStatus NUMBER DEFAULT 0, /* 업그레이드상태 */
	alertRandomBoxStatus NUMBER /* 랜덤박스상태 */
);

COMMENT ON TABLE TBL_User_Attend IS '유저출석테이블';

COMMENT ON COLUMN TBL_User_Attend.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_User_Attend.allAttendDay IS '전체출석일수';

COMMENT ON COLUMN TBL_User_Attend.continueAttendDay IS '새 컬럼';

COMMENT ON COLUMN TBL_User_Attend.attendLastDay IS '마지막 출석일은 가입한 오늘부터 시작된다.';

COMMENT ON COLUMN TBL_User_Attend.userRandomBox IS '유저랜덤박스갯수';

COMMENT ON COLUMN TBL_User_Attend.userPremiumRandomBox IS '유저프리미엄랜덤박스갯수';

COMMENT ON COLUMN TBL_User_Attend.alertUpgradeStatus IS '업그레이드상태';

COMMENT ON COLUMN TBL_User_Attend.alertRandomBoxStatus IS '랜덤박스상태';

CREATE UNIQUE INDEX PK_TBL_User_Attend
	ON TBL_User_Attend (
		userSeq ASC
	);

ALTER TABLE TBL_User_Attend
	ADD
		CONSTRAINT PK_TBL_User_Attend
		PRIMARY KEY (
			userSeq
		);

ALTER TABLE TBL_User_Attend
	ADD
		CONSTRAINT CK_TBL_User_AttendContinueCheck
		CHECK (attendContinueCheck in (0,1));

/* 업장소개테이블 */
CREATE TABLE TBL_Restaurant_Ad (
	restSeq NUMBER NOT NULL, /* 업장번호 */
	AdImg VARCHAR2(100) NOT NULL, /* 업장소개이미지 */
	AdImgStatus NUMBER /* 소개이미지상태 */
);

COMMENT ON TABLE TBL_Restaurant_Ad IS '업장소개테이블';

COMMENT ON COLUMN TBL_Restaurant_Ad.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Restaurant_Ad.AdImg IS '업장소개이미지';

COMMENT ON COLUMN TBL_Restaurant_Ad.AdImgStatus IS '소개이미지상태';

/* 업장메뉴테이블 */
CREATE TABLE TBL_Restaurant_Menu (
	menuSeq NUMBER NOT NULL, /* 메뉴번호 */
	restSeq NUMBER NOT NULL, /* 업장번호 */
	menuName VARCHAR2(20) NOT NULL, /* 메뉴명 */
	menuContent VARCHAR2(300) NOT NULL, /* 메뉴설명 */
	menuImg VARCHAR2(100), /* 메뉴이미지 */
	menuPrice VARCHAR2(20) NOT NULL, /* 메뉴가격 */
	menuSalePrice VARCHAR2(20) DEFAULT 0, /* 메뉴세일가격 */
	menuSort VARCHAR2(50) NOT NULL, /* 메뉴분류 */
	menuEvent VARCHAR2(50), /* 메뉴이벤트  */
	menuStatus NUMBER DEFAULT 0 NOT NULL /* 메뉴상태 */
);

COMMENT ON TABLE TBL_Restaurant_Menu IS '업장메뉴테이블';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuSeq IS '메뉴번호';

COMMENT ON COLUMN TBL_Restaurant_Menu.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuName IS '메뉴명';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuContent IS '메뉴설명';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuImg IS '메뉴이미지';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuPrice IS '메뉴가격';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuSalePrice IS '메뉴세일가격';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuSort IS '메뉴분류';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuEvent IS '계절메뉴 등
';

COMMENT ON COLUMN TBL_Restaurant_Menu.menuStatus IS '업장메뉴상태는 0과 1 두 가지 숫자만 가능하다
0 : 사용가능
1 : 삭제된 업장메뉴';

ALTER TABLE TBL_Restaurant_Menu
	ADD
		CONSTRAINT CK_TBL_Restaurant_MenuStatus
		CHECK (menuStatus in (0,1));

/* 리뷰통계테이블 */
CREATE TABLE TBL_ReviewVisitor (
	reviewSeq NUMBER NOT NULL, /* 리뷰번호 */
	userGender VARCHAR2(10) NOT NULL, /* 유저성별 */
	userBirthDay VARCHAR2(10) NOT NULL /* 유저생일 */
);

COMMENT ON TABLE TBL_ReviewVisitor IS '리뷰통계테이블';

COMMENT ON COLUMN TBL_ReviewVisitor.reviewSeq IS '리뷰번호';

COMMENT ON COLUMN TBL_ReviewVisitor.userGender IS '유저성별';

COMMENT ON COLUMN TBL_ReviewVisitor.userBirthDay IS '유저생일';

/* 리뷰이미지테이블 */
CREATE TABLE TBL_Review_Image (
	reviewImgSeq NUMBER NOT NULL, /* 리뷰이미지번호 */
	reviewSeq NUMBER NOT NULL, /* 리뷰번호 */
	reviewImg VARCHAR2(30) NOT NULL, /* 리뷰이미지 */
	reviewImgStatus NUMBER DEFAULT 0 NOT NULL /* 리뷰이미지상태 */
);

COMMENT ON TABLE TBL_Review_Image IS '리뷰이미지테이블';

COMMENT ON COLUMN TBL_Review_Image.reviewImgSeq IS '리뷰이미지번호';

COMMENT ON COLUMN TBL_Review_Image.reviewSeq IS '리뷰번호';

COMMENT ON COLUMN TBL_Review_Image.reviewImg IS '리뷰이미지';

COMMENT ON COLUMN TBL_Review_Image.reviewImgStatus IS '리뷰이미지상태는 0과 1 두 가지 숫자만 가능하다
0 : 사용가능
1 : 삭제된 이미지';

CREATE UNIQUE INDEX PK_TBL_Review_Image
	ON TBL_Review_Image (
		reviewImgSeq ASC
	);

ALTER TABLE TBL_Review_Image
	ADD
		CONSTRAINT PK_TBL_Review_Image
		PRIMARY KEY (
			reviewImgSeq
		);

ALTER TABLE TBL_Review_Image
	ADD
		CONSTRAINT CK_TBL_Review_Image_Status2
		CHECK (reviewImage in (0,1));

/* 쿠폰 테이블 */
CREATE TABLE TBL_Coupon (
	couponSeq NUMBER NOT NULL, /* 쿠폰번호 */
	restSeq NUMBER NOT NULL, /* 업장번호 */
	userSeq NUMBER, /* 유저번호 */
	metroId varchar2(10) NOT NULL, /* 업장소속지하철 */
	couponRegDate DATE, /* 쿠폰발행일 */
	couponUserDate DATE, /* 쿠폰유저등록일 */
	couponUseDate DATE, /* 쿠폰사용일 */
	couponExpiryDate DATE DEFAULT 
, /* 쿠폰유효기간 */
	couponStatus NUMBER DEFAULT 0 NOT NULL /* 쿠폰상태 */
);

COMMENT ON TABLE TBL_Coupon IS '쿠폰 테이블';

COMMENT ON COLUMN TBL_Coupon.couponSeq IS '쿠폰번호';

COMMENT ON COLUMN TBL_Coupon.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_Coupon.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_Coupon.metroId IS '업장소속지하철';

COMMENT ON COLUMN TBL_Coupon.couponRegDate IS '쿠폰발행일';

COMMENT ON COLUMN TBL_Coupon.couponUserDate IS '쿠폰유저등록일';

COMMENT ON COLUMN TBL_Coupon.couponUseDate IS '쿠폰사용일';

COMMENT ON COLUMN TBL_Coupon.couponExpiryDate IS '쿠폰유효기간';

COMMENT ON COLUMN TBL_Coupon.couponStatus IS '쿠폰상태는 0, 1, 2가 있다

0 : 업주가 쿠폰을 발행한 상태
1: 발행한 쿠폰을 유저가 받은 상태
2: 유저가 받은 쿠폰을 사용하여 완전소진된 상태
3: 유저가 기한초과로 사용 못 한 경우';

CREATE UNIQUE INDEX PK_TBL_Coupon
	ON TBL_Coupon (
		couponSeq ASC
	);

ALTER TABLE TBL_Coupon
	ADD
		CONSTRAINT PK_TBL_Coupon
		PRIMARY KEY (
			couponSeq
		);

ALTER TABLE TBL_Coupon
	ADD
		CONSTRAINT CK_TBL_Coupon_status
		CHECK (couponStatus in (0,1,2,3));

/* 구 테이블 */
CREATE TABLE TBL_Gu (
	guId VARCHAR2(10) NOT NULL, /* 구id */
	guName VARCHAR2(50) NOT NULL /* 구이름 */
);

COMMENT ON TABLE TBL_Gu IS '구 테이블';

COMMENT ON COLUMN TBL_Gu.guId IS '구id';

COMMENT ON COLUMN TBL_Gu.guName IS '구이름';

CREATE UNIQUE INDEX PK_TBL_Gu
	ON TBL_Gu (
		guId ASC
	);

ALTER TABLE TBL_Gu
	ADD
		CONSTRAINT PK_TBL_Gu
		PRIMARY KEY (
			guId
		);

/* 지하철 테이블 */
CREATE TABLE TBL_Metro (
	metroId VARCHAR2(10) NOT NULL, /* 지하철역 id */
	metroName VARCHAR2(50), /* 지하철역 이름 */
	metroNum VARCHAR(10), /* 호선 */
	latitude NUMBER, /* 위도 */
	longitude NUMBER /* 경도 */
);

COMMENT ON TABLE TBL_Metro IS '지하철 테이블';

COMMENT ON COLUMN TBL_Metro.metroId IS '지하철역 id';

COMMENT ON COLUMN TBL_Metro.metroName IS '체크키 : ''1'',''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''인천1'',''인천2'',''분당'',''신분당'',''경의중앙'',''경춘'',''수인'',''에버라인'',''공항철도'',''의정부'',''경강''';

COMMENT ON COLUMN TBL_Metro.metroNum IS '호선';

COMMENT ON COLUMN TBL_Metro.latitude IS '위도';

COMMENT ON COLUMN TBL_Metro.longitude IS '''1'',''2'',''3'',''4'',''5'',''6'',''7'',''8'',''9'',''인천1'',''인천2'',''분당'',''신분당'',''경의중앙'',''경춘'',''수인'',''에버라인'',''공항철도'',''의정부'',''경강''';

CREATE UNIQUE INDEX PK_TBL_Metro
	ON TBL_Metro (
		metroId ASC
	);

ALTER TABLE TBL_Metro
	ADD
		CONSTRAINT PK_TBL_Metro
		PRIMARY KEY (
			metroId
		);

/* 동 테이블 */
CREATE TABLE TBL_Dong (
	dongId VARCHAR2(10) NOT NULL, /* 동id */
	dongName VARCHAR2(50) NOT NULL, /* 동이름 */
	guId VARCHAR2(10) /* 구id */
);

COMMENT ON TABLE TBL_Dong IS '동 테이블';

COMMENT ON COLUMN TBL_Dong.dongId IS '동id';

COMMENT ON COLUMN TBL_Dong.dongName IS '동이름';

COMMENT ON COLUMN TBL_Dong.guId IS '구id';

CREATE UNIQUE INDEX PK_TBL_Dong
	ON TBL_Dong (
		dongId ASC
	);

ALTER TABLE TBL_Dong
	ADD
		CONSTRAINT PK_TBL_Dong
		PRIMARY KEY (
			dongId
		);

/* 가고싶다 테이블 */
CREATE TABLE TBL_WantToGo (
	wantToGoSeq NUMBER NOT NULL, /* 가고싶다번호 */
	userSeq NUMBER NOT NULL, /* 유저번호 */
	restSeq NUMBER NOT NULL, /* 업장번호 */
	wantToGoRegDate DATE NOT NULL, /* 가고싶다등록일 */
	wantToGoStatus NUMBER DEFAULT 0 NOT NULL /* 가고싶다유무 */
);

COMMENT ON TABLE TBL_WantToGo IS '가고싶다 테이블';

COMMENT ON COLUMN TBL_WantToGo.wantToGoSeq IS '가고싶다번호';

COMMENT ON COLUMN TBL_WantToGo.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_WantToGo.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_WantToGo.wantToGoRegDate IS '가고싶다등록일';

COMMENT ON COLUMN TBL_WantToGo.wantToGoStatus IS '가고싶다유무';

CREATE UNIQUE INDEX PK_TBL_WantToGo
	ON TBL_WantToGo (
		wantToGoSeq ASC
	);

ALTER TABLE TBL_WantToGo
	ADD
		CONSTRAINT PK_TBL_WantToGo
		PRIMARY KEY (
			wantToGoSeq
		);

ALTER TABLE TBL_WantToGo
	ADD
		CONSTRAINT CK_TBL_WantGoStatus
		CHECK (wantGoStatus in (0,1,2));

/* 새FAQ테이블 */
CREATE TABLE TBL_FAQ (
	faqSeq NUMBER NOT NULL, /* FnQ번호 */
	faqType VARCHAR2(30) NOT NULL, /* 질문타입 */
	faqQuestion VARCHAR2(4000) NOT NULL, /* 질문 */
	faqAnswer VARCHAR2(4000) NOT NULL, /* 질문답변 */
	faqStatus NUMBER NOT NULL /* 질문상태 */
);

COMMENT ON TABLE TBL_FAQ IS '새FAQ테이블';

COMMENT ON COLUMN TBL_FAQ.faqSeq IS 'FnQ번호';

COMMENT ON COLUMN TBL_FAQ.faqType IS '질문타입';

COMMENT ON COLUMN TBL_FAQ.faqQuestion IS '질문';

COMMENT ON COLUMN TBL_FAQ.faqAnswer IS '질문답변';

COMMENT ON COLUMN TBL_FAQ.faqStatus IS '질문상태';

CREATE UNIQUE INDEX PK_TBL_FAQ
	ON TBL_FAQ (
		faqSeq ASC
	);

ALTER TABLE TBL_FAQ
	ADD
		CONSTRAINT PK_TBL_FAQ
		PRIMARY KEY (
			faqSeq
		);

/* 고객센터 테이블 */
CREATE TABLE TBL_QnA (
	qnaSeq NUMBER NOT NULL, /* QnA글번호 */
	userSeq NUMBER NOT NULL, /* 유저번호 */
	qnaInquery VARCHAR2(30) NOT NULL, /* QnA문의유형 */
	qnaSubject VARCHAR2(50) NOT NULL, /* QnA제목 */
	qnaContent VARCHAR2(2000) NOT NULL, /* QnA글내용 */
	qnaRegDate DATE DEFAULT sysdate NOT NULL, /* QnA등록일자 */
	qnaAnswerDate DATE, /* QnA답변등록일자 */
	qnaProgress VARCHAR2(40) DEFAULT 0 NOT NULL, /* QnA진행과정 */
	fk_seq NUMBER DEFAULT 0 NOT NULL, /* QnA원글번호 */
	qnaStatus NUMBER(1) DEFAULT 0 NOT NULL /* QnA삭제유무 */
);

COMMENT ON TABLE TBL_QnA IS '고객센터 테이블';

COMMENT ON COLUMN TBL_QnA.qnaSeq IS 'QnA글번호';

COMMENT ON COLUMN TBL_QnA.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_QnA.qnaInquery IS 'QnA문의유형';

COMMENT ON COLUMN TBL_QnA.qnaSubject IS 'QnA제목';

COMMENT ON COLUMN TBL_QnA.qnaContent IS 'QnA글내용';

COMMENT ON COLUMN TBL_QnA.qnaRegDate IS 'QnA등록일자';

COMMENT ON COLUMN TBL_QnA.qnaAnswerDate IS 'QnA답변등록일자';

COMMENT ON COLUMN TBL_QnA.qnaProgress IS 'QnA진행과정';

COMMENT ON COLUMN TBL_QnA.fk_seq IS 'QnA원글번호';

COMMENT ON COLUMN TBL_QnA.qnaStatus IS 'QnA삭제유무';

CREATE UNIQUE INDEX PK_TBL_QnA
	ON TBL_QnA (
		qnaSeq ASC
	);

ALTER TABLE TBL_QnA
	ADD
		CONSTRAINT PK_TBL_QnA
		PRIMARY KEY (
			qnaSeq
		);

ALTER TABLE TBL_QnA
	ADD
		CONSTRAINT CK_TBL_QnA_qnaInquery
		CHECK (qnaInquery in (1,2,3,4,5));

ALTER TABLE TBL_QnA
	ADD
		CONSTRAINT CK_TBL_QnA_qnaProgress
		CHECK (qnaProgress in (0,1));

ALTER TABLE TBL_QnA
	ADD
		CONSTRAINT CK_TBL_QnA_qnaStatus
		CHECK (qnaStatus in (0,1));

/* 유저칭호테이블2 */
CREATE TABLE TBL_User_Alias (
	aliasSeq NUMBER NOT NULL, /* 칭호번호 */
	userSeq NUMBER NOT NULL, /* 유저번호 */
	aliasType VARCHAR2(30) NOT NULL, /* 칭호타입 */
	aliasId VARCHAR2(30) NOT NULL, /* 칭호id */
	aliasName VARCHAR2(50) NOT NULL, /* 칭호명 */
	aliasNum NUMBER NOT NULL, /* 칭호구분번호 */
	aliasStatus NUMBER(1) DEFAULT 0 NOT NULL /* 칭호상태 */
);

COMMENT ON TABLE TBL_User_Alias IS '유저칭호테이블2';

COMMENT ON COLUMN TBL_User_Alias.aliasSeq IS '칭호번호';

COMMENT ON COLUMN TBL_User_Alias.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_User_Alias.aliasType IS 'dongId, metroId, guId, restBgTag, restMdTag
';

COMMENT ON COLUMN TBL_User_Alias.aliasId IS '해당 id 및 tag : 1171010100, 2005, 한식,양식.../고기,물고기,채소,밥,면,분식, ';

COMMENT ON COLUMN TBL_User_Alias.aliasName IS '입문자, 숙련자, 마스터';

COMMENT ON COLUMN TBL_User_Alias.aliasNum IS '칭호구분번호';

COMMENT ON COLUMN TBL_User_Alias.aliasStatus IS '칭호상태는 0과 1 두 가지 숫자만 가능하다
0 : 사용가능
1 : 삭제된 칭호';

CREATE UNIQUE INDEX PK_TBL_User_Alias
	ON TBL_User_Alias (
		aliasSeq ASC
	);

ALTER TABLE TBL_User_Alias
	ADD
		CONSTRAINT PK_TBL_User_Alias
		PRIMARY KEY (
			aliasSeq
		);

ALTER TABLE TBL_User_Alias
	ADD
		CONSTRAINT CK_TBL_User_Alias_Status2
		CHECK (aliasStatus in (0,1));

/* 새 테이블 */
CREATE TABLE TABLE (
);

COMMENT ON TABLE TABLE IS '새 테이블';

/* 테마 테이블 */
CREATE TABLE TBL_THEME (
	themeSeq NUMBER NOT NULL, /* 테마번호 */
	reviewSeq NUMBER NOT NULL, /* 리뷰번호 */
	restSeq NUMBER NOT NULL, /* 업장번호 */
	theme VARCHAR2(70) /* 테마명 */
);

COMMENT ON TABLE TBL_THEME IS '테마 테이블';

COMMENT ON COLUMN TBL_THEME.themeSeq IS '테마번호';

COMMENT ON COLUMN TBL_THEME.reviewSeq IS '리뷰번호';

COMMENT ON COLUMN TBL_THEME.restSeq IS '업장번호';

COMMENT ON COLUMN TBL_THEME.theme IS '테마명';

/* 리뷰댓글 테이블 */
CREATE TABLE TBL_Review_Comment (
	commentSeq NUMBER NOT NULL, /* 댓글번호 */
	reviewSeq NUMBER NOT NULL, /* 리뷰번호 */
	userSeq NUMBER NOT NULL, /* 유저번호 */
	content NVARCHAR2(2000) NOT NULL, /* 댓글내용 */
	regDate DATE NOT NULL, /* 작성날짜 */
	status NUMBER(1) NOT NULL, /* 댓글상태 */
	commentCount NUMBER NOT NULL, /* 댓글수 */
	groupNo NUMBER NOT NULL, /* 그룹번호 */
	FK_Seq NUMBER NOT NULL, /* 대댓글여부 */
	depthNo NUMBER NOT NULL /* 댓글순서 */
);

COMMENT ON TABLE TBL_Review_Comment IS '리뷰댓글 테이블';

COMMENT ON COLUMN TBL_Review_Comment.commentSeq IS '댓글번호';

COMMENT ON COLUMN TBL_Review_Comment.reviewSeq IS '리뷰번호';

COMMENT ON COLUMN TBL_Review_Comment.userSeq IS '유저번호';

COMMENT ON COLUMN TBL_Review_Comment.content IS '댓글내용';

COMMENT ON COLUMN TBL_Review_Comment.regDate IS '작성날짜';

COMMENT ON COLUMN TBL_Review_Comment.status IS '댓글상태';

COMMENT ON COLUMN TBL_Review_Comment.commentCount IS '댓글수';

COMMENT ON COLUMN TBL_Review_Comment.groupNo IS '그룹번호';

COMMENT ON COLUMN TBL_Review_Comment.FK_Seq IS '대댓글여부';

COMMENT ON COLUMN TBL_Review_Comment.depthNo IS '댓글순서';

CREATE UNIQUE INDEX PK_TBL_Review_Comment
	ON TBL_Review_Comment (
		commentSeq ASC
	);

ALTER TABLE TBL_Review_Comment
	ADD
		CONSTRAINT PK_TBL_Review_Comment
		PRIMARY KEY (
			commentSeq
		);

ALTER TABLE TBL_Review_Comment
	ADD
		CONSTRAINT CK_TBL_COMMENT_STATUS
		CHECK (status in(0,1) );

/* 리뷰좋아요 테이블 */
CREATE TABLE TBL_Review_Liker (
	reviewSeq NUMBER NOT NULL, /* 리뷰번호 */
	userSeq NUMBER NOT NULL /* 유저번호 */
);

COMMENT ON TABLE TBL_Review_Liker IS '리뷰좋아요 테이블';

COMMENT ON COLUMN TBL_Review_Liker.reviewSeq IS '리뷰번호';

COMMENT ON COLUMN TBL_Review_Liker.userSeq IS '유저번호';

ALTER TABLE TBL_User
	ADD
		CONSTRAINT FK_TBL_Grade_TO_TBL_User
		FOREIGN KEY (
			gradeSeq
		)
		REFERENCES TBL_Grade (
			gradeSeq
		);

ALTER TABLE TBL_Restaurant
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_Restaurant
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_Restaurant
	ADD
		CONSTRAINT FK_TBL_Grade_TO_TBL_Restaurant
		FOREIGN KEY (
			gradeSeq
		)
		REFERENCES TBL_Grade (
			gradeSeq
		);

ALTER TABLE TBL_Restaurant
	ADD
		CONSTRAINT FK_TBL_Metro_TO_TBL_Restaurant
		FOREIGN KEY (
			metroId
		)
		REFERENCES TBL_Metro (
			metroId
		);

ALTER TABLE TBL_Restaurant
	ADD
		CONSTRAINT FK_TBL_Dong_TO_TBL_Restaurant
		FOREIGN KEY (
			dongId
		)
		REFERENCES TBL_Dong (
			dongId
		);

ALTER TABLE TBL_Restaurant_Judge
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_Restaurant_Judge
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_Restaurant_Judge
	ADD
		CONSTRAINT FK_TBL_Review_TO_TBL_Restaurant_Judge
		FOREIGN KEY (
			reviewSeq
		)
		REFERENCES TBL_Review (
			reviewSeq
		);

ALTER TABLE TBL_Restaurant_Content
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_Restaurant_Content
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_Restaurant_Content
	ADD
		CONSTRAINT FK_TBL_Content_Cat_TO_TBL_Restaurant_Content
		FOREIGN KEY (
			contentSeq
		)
		REFERENCES TBL_Content_Cat (
			contentSeq
		);

ALTER TABLE TBL_Restaurant_Content
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_Restaurant_Content
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_Restaurant_Visitor
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_Restaurant_Visitor
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_Review
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_Review
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_Review
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_Review
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_User_Attend
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_User_Attend
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_Restaurant_Ad
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_Restaurant_Ad
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_Restaurant_Menu
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_Restaurant_Menu
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_ReviewVisitor
	ADD
		CONSTRAINT FK_TBL_Review_TO_TBL_ReviewVisitor
		FOREIGN KEY (
			reviewSeq
		)
		REFERENCES TBL_Review (
			reviewSeq
		);

ALTER TABLE TBL_Review_Image
	ADD
		CONSTRAINT FK_TBL_Review_TO_TBL_Review_Image
		FOREIGN KEY (
			reviewSeq
		)
		REFERENCES TBL_Review (
			reviewSeq
		);

ALTER TABLE TBL_Coupon
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_Coupon
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_Coupon
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_Coupon
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_Dong
	ADD
		CONSTRAINT FK_TBL_Gu_TO_TBL_Dong
		FOREIGN KEY (
			guId
		)
		REFERENCES TBL_Gu (
			guId
		);

ALTER TABLE TBL_WantToGo
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_WantToGo
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_WantToGo
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_WantToGo
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_QnA
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_QnA
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_User_Alias
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_User_Alias
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_THEME
	ADD
		CONSTRAINT FK_TBL_Restaurant_TO_TBL_THEME
		FOREIGN KEY (
			restSeq
		)
		REFERENCES TBL_Restaurant (
			restSeq
		);

ALTER TABLE TBL_THEME
	ADD
		CONSTRAINT FK_TBL_Review_TO_TBL_THEME
		FOREIGN KEY (
			reviewSeq
		)
		REFERENCES TBL_Review (
			reviewSeq
		);

ALTER TABLE TBL_Review_Comment
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_Review_Comment
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_Review_Comment
	ADD
		CONSTRAINT FK_TBL_Review_TO_TBL_Review_Comment
		FOREIGN KEY (
			reviewSeq
		)
		REFERENCES TBL_Review (
			reviewSeq
		);

ALTER TABLE TBL_Review_Liker
	ADD
		CONSTRAINT FK_TBL_User_TO_TBL_Review_Liker
		FOREIGN KEY (
			userSeq
		)
		REFERENCES TBL_User (
			userSeq
		);

ALTER TABLE TBL_Review_Liker
	ADD
		CONSTRAINT FK_TBL_Review_TO_TBL_Review_Liker
		FOREIGN KEY (
			reviewSeq
		)
		REFERENCES TBL_Review (
			reviewSeq
		);
    
    
-- sequence -----------------------------------------------------------------------------

create sequence SEQ_TBL_JOBTEST;
create sequence SEQ_TBL_METRO;
create sequence SEQ_TBL_RESTAURANT;
create sequence SEQ_TBL_USER_ALIAS;
create sequence SEQ_TBL_WANTTOGO;
create sequence TBL_COUPON_SEQ;
create sequence TBL_FAQSEQ;
create sequence TBL_GRADE_SEQ;
create sequence TBL_QNASEQ;
create sequence TBL_QNA_SEQ;
create sequence TBL_RESTAURANT_MENUSEQ;
create sequence TBL_RESTAURANT_SEQ;
create sequence TBL_REVIEWIMAGESEQ;
create sequence TBL_REVIEWSEQ;
create sequence TBL_REVIEW_COMMENTSEQ;
create sequence TBL_REVIEW_IMAGE_SEQ;
create sequence TBL_REVIMGSEQ;
create sequence TBL_THEMASEQ;
create sequence TBL_THEMESEQ;
create sequence TBL_USER_SEQ;