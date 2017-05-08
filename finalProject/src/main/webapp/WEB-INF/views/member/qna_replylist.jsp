<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/css/mypage.css" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
$('.collapse').bind("pageshow",function(event){
	 
    $('#collapseExample').bind('expand', function () {
    //펼쳐졌을때 동작 
    }).bind('collapse', function () {
    //닫혀 졌을때 동작
    });

});

$(function(){
	$(".p_qna_view_btn_1").click(function () {
		var i = $(".p_qnalist_id").val();
		var n = $(".p_qnalist_no").val();
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/replyqna_getreplyview",
			data:{
					id:i,
					qnalist_no:n
				 },
				 success: function (result){
								$(".p_reply_body").html(result);
				 },
				 error : function(){
					 alert("아직안만들엇지렁");
				 }
		});
	});	
	
	$(".p_qnadel").click(function () {
		var a=$(this).attr("data-index");
		var n = $(".p_qnalist_nono"+a).val();
/* 		$("#p_qnadel_no").html("<input type='hidden' id='p_qnaup_nono' value="+n+">");*/			

	$(".qna_delbt").click(function () {
				$.ajax({
					type:"POST",
					url:"${pageContext.request.contextPath}/member/qna_delete",
					data:{
						com_no:n
					},
					success:function(){
						alert("삭제완료");
						window.location.reload();
					},
					error:function(){
						alert("실패");
					}
				});
		})
	});
	
	
	
	
	$(".p_qna_view_btn_2").click(function () {
		$("#p_hidden_d_ata").html("");	
		var no = $(this).val();
		var id = $(this).attr("data-id");
		$("#p_hidden_d_ata").append("<input type='hidden' name='qnalist_no' value='"+no+"'>");
		$("#p_hidden_d_ata").append("<input type='hidden' name='id' value='"+id+"'>");
		$("#p_hidden_d_ata").append("<input type='hidden' name='com_no' value='"+no+"'>");
		
	});
	
});

</script>
<c:choose>
	<c:when test="${empty qna_list}">
		<div id="p_qnanotice_con"><h2>질문 하신 글이 없습니다.</h2></div>
	</c:when>
	<c:otherwise>
		<c:forEach items="${qna_list}" var="i" varStatus="a">	
			<div id="p_qna_form">
					<div class="p_qna_list" id="${a}">
							<div id="p_qna_body_list" class="p_body_div_1">
								<!-- <div id="p_qna_list_img"></div> -->
										<div id="p_updel" style="float: right;">
										<a data-toggle="modal" data-target="#p_qnadelete"  style="cursor: pointer;" class="p_qnadel" data-index="${a.index}"><span class="glyphicon glyphicon-trash" aria-hidden="true">삭제</span></a>
										</div>
										<c:if test="${ i.m_img == null }"><img src="${pageContext.request.contextPath}/resources/img/login/user.png"
											style="width: 50px; height: 50px; border-radius: 50%; cursor: pointer;"></c:if>
										<c:if test="${ i.m_img != null }">
										<div class="p_qna_d_userimg"><span><img src="${pageContext.request.contextPath}/resources/memberimg/${i.m_img}"
										style="width: 50px; height: 50px; border-radius: 50%;"></span></div></c:if>
										<input type="hidden" class="p_qnalist_nono${a.index}" value="${i.com_no}"> 
										<div class="p_qna_d_title">&nbsp;&nbsp;<span>${i.title}</span>
										<div class="p_qna_d_id"><span>작성자:&nbsp;&nbsp;${i.id}</span></div>
										<div class="p_qna_d_reg_date"><span>${i.reg_date}</span></div></div>
										<div class="p_qna_d_contents"><span>${i.contents}</span></div>
										
										
									
										<c:if test="${ not empty admin }">
										<!--관리자만 볼 수 있는 버튼  -->
										<div class="p_qnaadminbt"><button class="btn btn-danger p_qna_view_btn_2" data-toggle="modal" data-target="#p_qnaReplymodal" data-id="${i.id}" value="${i.com_no}">답변 하기</button></div>
										</c:if>
										<div id="p_qna_view_btn">
											<a data-toggle="collapse" data-parent="p_replyqnaList" data-target="#${i.com_no}" aria-expanded="false" aria-controls="collapseExample" href="#p_collapse"><button class="btn btn-primary p_qna_view_btn_1" type="button">답변 보기</button></a>
										</div>
				      		</div>
				      					
										
				      	<c:choose>
				      		<c:when test="${empty replyqna }">
								<div class="collapse" id="${i.com_no}">
								<div><h2>답변이 아직 등록되지 않았습니다.</h2></div>
								</div>
				      		</c:when>
				      		<c:otherwise>
				      		
								<div class="p_body_div_1 p_reply_body" id="p_qna_body_list_contents">
										
								</div>	
				      		</c:otherwise>
				      	</c:choose>	
						</div>
			</div>
		</c:forEach>	
	</c:otherwise>
</c:choose>


									<div class="modal fade bs-example-modal-sm" id="p_qnadelete" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
										  <div class="modal-dialog modal-sm">
										    <div class="modal-content" id="p_modal_mout">
										     <form action="${pageContext.request.contextPath}/member/qna_delete" method="post">
										      <div id="p_qnadel_no" ></div>	 
										      <br><br><span style="margin-left: 65px;">정말로 삭제 하시겠습니까?</span><br><br><br>
									  		  <button type="button" class="button button3 qna_delbt" style="margin-left: 90px;margin-bottom: 20px;">예</button></a><span>              </span>
										      <button class="button button5" data-dismiss="modal" >아니오</button>
										     </form>	
										    </div>	
										  </div>
										</div>
