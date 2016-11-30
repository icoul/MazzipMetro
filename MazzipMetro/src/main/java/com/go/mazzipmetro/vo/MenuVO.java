package com.go.mazzipmetro.vo;

import org.springframework.web.multipart.MultipartFile;

public class MenuVO {
	
	private String[] restSeq;		/* 업장번호 */
	private String[] menuName; 		/* 메뉴명 */
	private String[] menuContent;	/* 메뉴설명 */
	private MultipartFile[] menuImg;		/* 메뉴이미지 */
	private String[] menuPrice;		/* 메뉴가격 */
	private String[] menuSalePrice;	/* 메뉴세일가격 */
	private String[] menuSort;		/* 메뉴분류 */
	private String[] menuEvent;		/* 메뉴이벤트  */
	private String[] menuStatus;
	
	public MenuVO(){}

	public MenuVO(String[] restSeq, String[] menuName, String[] menuContent, MultipartFile[] menuImg,
			String[] menuPrice, String[] menuSalePrice, String[] menuSort, String[] menuEvent, String[] menuStatus) {
		super();
		this.restSeq = restSeq;
		this.menuName = menuName;
		this.menuContent = menuContent;
		this.menuImg = menuImg;
		this.menuPrice = menuPrice;
		this.menuSalePrice = menuSalePrice;
		this.menuSort = menuSort;
		this.menuEvent = menuEvent;
		this.menuStatus = menuStatus;
	}

	public String[] getRestSeq() {
		return restSeq;
	}

	public void setRestSeq(String[] restSeq) {
		this.restSeq = restSeq;
	}

	public String[] getMenuName() {
		return menuName;
	}

	public void setMenuName(String[] menuName) {
		this.menuName = menuName;
	}

	public String[] getMenuContent() {
		return menuContent;
	}

	public void setMenuContent(String[] menuContent) {
		this.menuContent = menuContent;
	}

	public MultipartFile[] getMenuImg() {
		return menuImg;
	}

	public void setMenuImg(MultipartFile[] menuImg) {
		this.menuImg = menuImg;
	}

	public String[] getMenuPrice() {
		return menuPrice;
	}

	public void setMenuPrice(String[] menuPrice) {
		this.menuPrice = menuPrice;
	}

	public String[] getMenuSalePrice() {
		return menuSalePrice;
	}

	public void setMenuSalePrice(String[] menuSalePrice) {
		this.menuSalePrice = menuSalePrice;
	}

	public String[] getMenuSort() {
		return menuSort;
	}

	public void setMenuSort(String[] menuSort) {
		this.menuSort = menuSort;
	}

	public String[] getMenuEvent() {
		return menuEvent;
	}

	public void setMenuEvent(String[] menuEvent) {
		this.menuEvent = menuEvent;
	}

	public String[] getMenuStatus() {
		return menuStatus;
	}

	public void setMenuStatus(String[] menuStatus) {
		this.menuStatus = menuStatus;
	}
}
