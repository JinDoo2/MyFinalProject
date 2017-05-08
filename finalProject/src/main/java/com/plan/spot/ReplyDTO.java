package com.plan.spot;

import java.sql.Date;

public class ReplyDTO {
	private int num;
	private String id;
	private String contents;
	private Date reg_date;
	private int city_no;
	private int ref;
	private int icon;
	private String spot_img;
	
	
	
	public int getCity_no() {
		return city_no;
	}
	public void setCity_no(int city_no) {
		this.city_no = city_no;
	}
	public String getSpot_img() {
		return spot_img;
	}
	public void setSpot_img(String spot_img) {
		this.spot_img = spot_img;
	}
	public int getIcon() {
		return icon;
	}
	public void setIcon(int icon) {
		this.icon = icon;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	
}
