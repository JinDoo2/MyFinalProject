package com.plan.spot;


import java.util.ArrayList;

import org.springframework.ui.Model;

public interface SpotService {

	public void list(int curPage,Model model,String type);

	public void spotWrite(SpotDTO spotDTO);
	
	public void spotView(int num, Model model);
	
	public void search(SpotSearchType spotSearchType,Model model);
	
	public void spotUpdate(SpotDTO spotDTO);
	
	public void spotDelect(int num);
	
	public void spotReplyView(int num, Model model,String icon);
	
	public void spotReply(ReplyDTO replyDTO);
	
	public void spotReplyDelete(int num);
	
	public void spotReplyUpdate(ReplyDTO replyDTO);
	
	public void category(int curPage,Model model,String type,String category);
	
	public void spotReplyUpdateForm(Model model,int num,int ref);
	
	public void crilbCount(Model model,int num);

	
	
}
