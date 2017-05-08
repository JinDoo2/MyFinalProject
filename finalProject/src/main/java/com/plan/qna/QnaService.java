package com.plan.qna;

import org.springframework.ui.Model;

public interface QnaService {

	public void qna_write(QnaDTO qdto);
	public int qna_update(QnaDTO qdto);
	public void qna_delete(int no);
	public void qna_getview(int curPage,Model model, String id,String type,int page);
	public void replyqna_getreplyview(ReplyQnaDTO rqdto,Model model);
	
	
	/*관리자*/
	public void replyQna_write(ReplyQnaDTO rqdto,int com_no);
	public int replyQna_update(int com_no);
	public void replyQna_delete(int no);
	public void replyQna_getview(QnaDTO qdto,Model model);
	
	
}
