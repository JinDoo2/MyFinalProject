<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/views/temp/script.jspf" %>
<%@ include file="/WEB-INF/views/temp/header.jspf" %>
<%@ include file="/resources/css/mypage.css" %>
<Head>	
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	function ontop() {p_top_menu_home.innerText="홈";}
	function ontop1() {p_top_menu_Schedule.innerText="여행 일정";}
	function ontop2() {p_top_menu_reviewnscrap.innerText="리뷰&스크랩";}
	function ontop3() {p_top_menu_QnA.innerText="질문&답변";}
	function ontop4() {p_top_menu_myinfo.innerText="나의 정보";}
	
	function outtop() {p_top_menu_home.innerText="Home";}
	function outtop1() {p_top_menu_Schedule.innerText="Schedule";}
	function outtop2() {p_top_menu_reviewnscrap.innerText="review & Scrap";}
	function outtop3() {p_top_menu_QnA.innerText="QnA";}
	function outtop4() {p_top_menu_myinfo.innerText="My info";}	

	
	
	
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/SE2/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
$(function(){
    //전역변수
    var obj = [];               
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "SmartEditor",
        sSkinURI: "${pageContext.request.contextPath}/resources/SE2/SmartEditor2Skin.html", 
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,             
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,     
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true, 
        }
    });
    //전송버튼
    $("#savebutton").click(function(){
        //id가 smarteditor인 textarea에 에디터에서 대입
        obj.getById["SmartEditor"].exec("UPDATE_CONTENTS_FIELD", []);
        //폼 submit
        $("#frm").submit();
    })
})
    
	

  
    
   
</script>
<script type="text/javascript">
$(function(){
	/* $.ajax({
		url:"./complitePlan",
		type:"POST",
		success: function(data) {
			alert(data);
			$(".complite_inner").html(data);
		},error: function() {
			alert("error");
		}
	}); */
	$("#home-tab").click(function(){
		var id =$("#p_qnaid").val();
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/jimlist",
			data:{id:id},
			success:function(data){
				$("#p_home_body_Schedule").html(data);
			}
		});
	});
	
	var page=3;
	$("#p_qnalist_1").click(function () {
		
		var i = $("#p_qnaid").val();
		var juso="";
		var sess = $("#session_id").val();
		if(sess=='admin'){
			 juso = "qna_replylist";
		}else if(sess!=null&&sess!='admin' ){ 
			juso = "qna_list";
		}
		 $.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/"+juso,
			data:{
					id:i,
					page:page
				 },
				 success: function (result){
								$(".p_qna_body").html(result);
				 },
				 error : function(){
					 alert("error");
				 }
		}); 
			 sess = null;
	});	
	
	/* $("#replyqna_submit").click(function () {
		var i = $("#p_qnaid").val();
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/qna_list",
			data:{
					id:i
				 },
				 success: function (result){
								$(".p_qna_body").html(result);
				 },
				 error : function(){
					 alert("error");
				 }
		});
	});	 */
	
	
	$("#p_up_echeck").change(function () {
		var e = $(this).val();
		$.ajax({
			type:"POST",
			url:"${pageContext.request.contextPath}/member/email",
			data:{
					email:e
				 },
				 success: function (data){
							$("#p_up_emailcheckresult").html(data); 	 
				 }
		});
	});
	
	
	$("#p_update_btn").click(function () {
		
		/* 공백 처리  */
		
		var joinpw = $('#p_up_pwcheck').val();			
		var joinname = $('#p_up_namecheck').val();
		var joinemail = $('#p_up_echeck').val();
		
		if (joinpw == '' || joinpw == null){
			alert('pw를 입력하세요');
			return;
		}
		
		if (joinname == '' || joinname == null){
			alert('name를 입력하세요');
			return;
		}
		if (joinemail == '' || joinemail == null){
			alert('email를 입력하세요');
			return;
		}
		/* 이메일테스트  */
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		if(regex.test(joinemail) === false) {
		 alert("잘못된 이메일 형식입니다.");
		 return false;
		} 
		
		  if($("#p_echeckok").val() ==2){	
			var keep = 1;
			/* 업데이트 진행*/
		}else{
			var keep = 2;
			/* 회원가입 오류  */
		}  
	
		 if(keep==1){
			$.ajax({
				type:"POST",
				url:"${pageContext.request.contextPath}/member/update",
				data:{
					pw:$("#p_up_pwcheck").val(),
					name:$("#p_up_namecheck").val(),
					email:$("#p_up_echeck").val()	
				},
				success: function () {
					alert("수정 성공");
					window.location.reload();
				}
			})
		}else{
			alert("입력 한 정보를 확인하세요.");
		}
		
	});
	
	
	
	/* plan관한 script */
	
	$(".complite").click(function() {
		$(".complite_inner").css("display","block");
		$(".incomplite_inner").css("display","none");
	});
	$(".incomplite").click(function() {
		$(".complite_inner").css("display","none");
		$(".incomplite_inner").css("display","block");
	});
	
	
		for(var i=1;i<$("#plan_list2_size").val();i++){
			$("."+(i*3)).css("margin-right","0px");
			
		}
		for(var i=1;i<$("#plan_list3_size").val();i++){
			$("."+(i*3)).css("margin-right","0px");
			
		}

});
	




</script>
<style type="text/css">
	.pfilter_clear{
 	clear: both;
 }
 .pfilter_right_content{
 	float: left;
 	width: 95px;
 	height: 50px;
 	text-align: center;
 	cursor: pointer;
 }
 .plan_inner_list{
 	float: left;
 	margin-right:28px;
 	margin-bottom: 20px;
    width: 345px;
    height: 296px;
    border: 1px solid #dfdfdf;
    position: relative;
    background: #fff;
    overflow: hidden;
 }
 .plan_list_bg{
 	/* width: 345px;
 	height: 200px;
 	background-color: gray;
 	overflow: hidden; */
 	width: 345px;
    height: 200px;
    position: absolute;
    left: 0px;
    top: 0px;
    z-index: 0;
    overflow: hidden;
 	transform-origin: center center 0px;  
    -webkit-transition: all 2.5s ease;
    -moz-transition: all 2.5s ease;
    -o-transition: all 2.5s ease;
    transition: all 2.5s ease; 
 }
 .plan_list_bg:hover{
 color:white !important;
 	-webkit-transform: scale(1.3,1.3);
    -moz-transform: scale(1.3,1.3);
   	-o-transform: scale(1.3,1.3);
    transform: scale(1.3,1.3);
    
 } 
 .plan_list_bg img{
 	width: 100%;
    height: 200px;
    position: absolute;
    left: 0px;
    top: 0px;
    z-index: 0;
    transition: all 3.6s;
    -webkit-transition: all 3.6s;
 }
 .plan_list_title span{
 	margin-left: 10px;
 }
 .plan_list_title{
 	/* margin-top: 140px; */
 	/* width: 200px; */
 	width: 100%;
    height: 100px;
    background: linear-gradient( to bottom, rgba(0,0,0,0), rgba(0,0,0,1));
    position: absolute;
    z-index: 1;
    left: 0px;
    top: 100px;
 }
 #pinner_list_order{
 	width: 100%;
 	margin-top: 50px;
 	margin-bottom: 10px;
 }
 #pinner_order_menu{
 	float: left;
 	font-size: 20px;
 }
 #pinner_list_counts{
 	float: right;
 	font-size: 15px;
 }
 .plan_counts{
 	float: right;
 	margin-left: 10px;
 }
 .plan_clips{
 	float: right;
 	margin-left: 10px;
 }
 .plan_spots{
 	float: right;
 	
 }
 .plan_bigcity{
 	margin-top: 5px;
 }
 .plan_id{
 	margin-top: 5px;
 
 }
 .plan_list_ex{
 	padding: 10px;
 	width: 100%;
    position: absolute;
    top: 200px;
    font-size: 14px;
    color: #6f6f6f;
    line-height: 20px;
    background-color: white;
 }
 
 
 .big_city_list{
 	float: left;
 	margin-left: 30px;
 	width: 80px;
 	height: 50px;
 	line-height:50px;
 	text-align: center;
 	cursor: pointer;
 }
 
 .big_city_name_title{
 	width: 100%;
 	text-align: center;
 }
 
 .pfilter_rigth_filter_inner{
 	float: left;
 	margin-left: 30px;
 	width: 80px;
 	height: 30px;
 	line-height: 30px;
 	text-align: center;
 	display: none;
 	background-color: #c8c8c8;
 	border-radius: 7px;
 	margin-top: 10px;
 }
  .pfilter_rigth_filter_inner1{
 	float: left;
 	margin-left: 30px;
 	width: 80px;
 	height: 50px;
 	line-height: 50px;
 	text-align: center;
 	display: none;
 }	
 .planner_List_inner_big_box a{
 	color:white !important;
 	
 }
.plan_title{
width:600px;

overflow:hidden;
text-overflow:ellipsis;
white-space:nowrap;
}
#ppage_view{
	width: 250px;
	height: 50px;
	background-color: #213B82;
	color: white;
	font-size: 20px;
	font-weight: bold;
	margin: 0 auto;
	text-align: center;
	line-height: 50px;
	margin-bottom: 50px;
	cursor: pointer;
} 
	.complite{
		width: 150px;
		height: 50px;
		font-size: 15px;
		font-weight:bolder;
		color:gray;
		text-align:center;
		border: 1px solid #c8c8c8;
		border-radius: 10px;
		line-height: 50px;
		margin-right: 10px;
		cursor: pointer;
		float: left;
	}
	.incomplite{
		width: 150px;
		height: 50px;
		font-size: 15px;
		font-weight:bolder;
		color:gray;
		text-align:center;
		border: 1px solid #c8c8c8;
		border-radius: 10px;
		line-height: 50px;
		cursor: pointer;
		float: left;
	}
	.clear{
		clear: both;
	}
	.complite_inner{
		width: 1092px;
		margin-top: 30px;
	
	}
	.incomplite_inner{
		width: 1092px;
		display: none;
		margin-top: 30px;
	}

  .complite_inner a{
 	color:black !important;
 }
  .incomplite_inner a{
 	color:black !important;
 }
/*  .plan_sc_body{
 	width: 1092px;
 	height:1000px;
 	margin: 0 auto;
 	margin-top: 100px;
 } */
</style>
</Head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>

<!-- Tab menu -->
<input type="hidden" id="session_id" value="${sessionScope.admin.id }">

<div id="main-body" >
	<div id="p_my_top" >
				<div id=p_top_title>
					<div id="myCarousel" class="carousel slide" data-ride="carousel">
							  <!-- Indicators -->
							  <ol class="carousel-indicators">
							    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
							    <li data-target="#myCarousel" data-slide-to="1"></li>
							    <li data-target="#myCarousel" data-slide-to="2"></li>
							    <li data-target="#myCarousel" data-slide-to="4"></li>
							    <li data-target="#myCarousel" data-slide-to="5"></li>
							    <li data-target="#myCarousel" data-slide-to="6"></li>
							    <li data-target="#myCarousel" data-slide-to="7"></li>
							    <li data-target="#myCarousel" data-slide-to="8"></li>
							    <li data-target="#myCarousel" data-slide-to="9"></li>
							    <li data-target="#myCarousel" data-slide-to="10"></li>
							  </ol>
							
							  <!-- Wrapper for slides -->
							  <div class="carousel-inner" role="listbox">
							    <div class="item active">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo1.jpg">
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo2.jpg">							    
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo3.jpg">
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo4.jpg">
							    </div>
							 	 <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo5.jpg">
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo6.jpg">
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo7.jpg">
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo8.jpg">
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo9.jpg">
							    </div>
							    <div class="item">
							      <img class="p_slide_img" src="${pageContext.request.contextPath}/resources/img/mypage/photo10.jpg">
							    </div>
							
							  
							  </div>
							
							  <!-- Left and right controls -->
							  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
							    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
							    <span class="sr-only">Previous</span>
							  </a>
							  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
							    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
							    <span class="sr-only">Next</span>
							  </a>
							</div>
			
			
			
				</div>
		<div id=p_top_menu>
			<div id=p_top_menu_center>
				<ul id="myTab" class="nav nav-tabs" role="tablist">
				  <li role="presentation" class="active"><a data-target="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true" class="p_tab_title_tab"><div class="p_top_menu_list" ><span id="p_top_menu_home" onmouseover="ontop()" onmouseout="outtop()">Home</span></div></a></li>
				  <li role="presentation" class=""><a data-target="#schedule" role="tab" id="schedule-tab" data-toggle="tab" aria-controls="schedule" aria-expanded="false" class="p_tab_title_tab"><div class="p_top_menu_list"><span id="p_top_menu_Schedule" onmouseover="ontop1()" onmouseout="outtop1()">Schedule</span></div></a></li>
				  <li role="presentation" class=""><a data-target="#reviewnscrap" role="tab" id="reviewnscrap-tab" data-toggle="tab" aria-controls="reviewnscrap" aria-expanded="false" class="p_tab_title_tab"><div class="p_top_menu_list"><span id="p_top_menu_reviewnscrap" onmouseover="ontop2()" onmouseout="outtop2()">Review & Scrap</span></div></a></li>				
				  <li role="presentation" class="" id="p_qnalist_1"><a data-target="#QnA" role="tab" id="QnA-tab" data-toggle="tab" aria-controls="QnA" aria-expanded="false" class="p_tab_title_tab"><div class="p_top_menu_list" ><span id="p_top_menu_QnA" onmouseover="ontop3()" onmouseout="outtop3()">QnA</span>
				  <c:choose>
				  	<c:when test="${empty admin }">
				  	 <input type="hidden" id="p_qnaid" value="${member.id}"></div>
				  	</c:when>
				  	<c:otherwise>
				  	 <input type="hidden" id="p_qnaid" value="${admin.id}"></div>
				  	</c:otherwise>
				  </c:choose>
				 </a></li>
				  <li role="presentation" class=""><a data-target="#myinfo" role="tab" id="myinfo-tab" data-toggle="tab" aria-controls="QnA" aria-expanded="false" class="p_tab_title_tab"><div class="p_top_menu_list" ><span id="p_top_menu_myinfo" onmouseover="ontop4()" onmouseout="outtop4()">My Info</span></div></a></li>	
				</ul>
			</div>										
		</div>	
	</div>
	
	


<div class="container">
	<!-- 회원 img 넣을 div 생성  <img src="..." alt="..." class="img-rounded">-->
	
	
	
	<!-- Home tab -->
	
	<div id="myTabContent" class="tab-content">
	  <div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
	    <div class="p_home_body">
		<div class="p_home_body_d1" id="p_home_body_d1_1">
			<div class="p_home_body_d1_header">
				<div class="p_home_body_title"><h1>recently Schedule</h1></div><div class="p_home_body_plus"></div>
			</div>
								<div id="p_home_body_Schedule">
									
								</div>


		</div>
		<div class="p_home_body_d1" id="p_home_body_d1_2">
			<div class="p_home_body_d1_header">
				<div class="p_home_body_title"><h1>recently Review & Scrap</h1></div><div class="p_home_body_plus"></div>		
			</div>
			
								<div id="p_home_body_review">
								
								</div>
								<div id="p_home_body_scrap">
								
								</div>


		</div>	
		<div class="p_home_body_d1" id="p_home_body_d1_3">
			<div class="p_home_body_d1_header">
				<div class="p_home_body_title" id="p_qna_list"><h1>recently QnA</h1></div><div class="p_home_body_plus"></div>		
		 	</div>
								<div id="p_home_body_QnA">
								
								</div>



		</div>
	</div>
	  </div>
	  
	  
	  
	  
	<!--schedule tab  -->
     
     <div role="tabpanel" class="tab-pane fade" id="schedule" aria-labelledby="schedule-tab">
         <div class="p_home_body" style="width: 1092px;">
            <div class="plan_title">
            	<div class="plan_title_inner complite">완성된 일정</div>
            	<div class="plan_title_inner incomplite">미완성된 일정</div>
            	<div class="clear"></div>
            </div>
			
			<div class="complite_inner">
			<div style="color: orange;">${plan_list2.size() } 개의 완성된 일정</div>
				<input type="hidden" value="${plan_list2.size() }" id="plan_list2_size">
		<c:forEach items="${plan_list2 }" var="planList" varStatus="i2">
	 			<a href="${pageContext.request.contextPath}/planMake/planView?id=${planList.id }&plan_no=${planList.plan_no}">
		 		<div class="plan_inner_list ${i2.index+1 }" >
	 				<div class="plan_list_title" style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">
		 				<div style="margin-top: 50px;">
		 					<span>${planList.s_date }</span><span>${planList.days}DAYS</span><br>
		 					<span class="plan_title">${planList.plan_name }</span>
		 				</div>
	 				</div>
		 			<div class="plan_list_bg">
		 				<img src="${pageContext.request.contextPath}/resources/img/city/cityIMG/${city_list[planList.city_no].city_img1}">
		 				
		 			</div>
		 			<div class="plan_list_ex">
		 				<span>
							<c:choose>
								<c:when test="${planList.thema == 1 }">
									가족여행
								</c:when>
								<c:when test="${planList.thema == 2 }">
									친구여행
								</c:when>
								<c:when test="${planList.thema == 3 }">
									커플여행
								</c:when>
								<c:otherwise>
									나홀로여행
								</c:otherwise>
							</c:choose>
							
						</span>
		 				<div class="plan_counts"><img src="${pageContext.request.contextPath}/resources/img/plan/pn_list_view_icon.png">&nbsp;&nbsp;${planList.counts }</div>
		 				<div class="plan_clips"><img src="${pageContext.request.contextPath}/resources/img/plan/list_clip_icon.png">&nbsp;&nbsp;${planList.jim }</div>
		 				<div class="plan_spots"><img src="${pageContext.request.contextPath}/resources/img/plan/pn_list_spot_icon.png">&nbsp;&nbsp;${planList.spot_counts }</div>
		 				<div class="pfilter_clear"></div>
		 				<div class="plan_bigcity">${planList.city_names}</div>
		 				<div class="pfilter_clear"></div>
		 				<div class="plan_id">${planList.id }</div>
		 			</div>
		 		</div>
		 		</a>
	 		</c:forEach>
			</div>
  			
  			<div class="incomplite_inner">
  			<div style="color: orange;">${plan_list3.size() } 개의 미완성된 일정</div>
  			<input type="hidden" value="${plan_list3.size() }" id="plan_list3_size">
				<c:forEach items="${plan_list3 }" var="planList" varStatus="i3">
	 			<a href="${pageContext.request.contextPath}/planMake/planView?id=${planList.id }&plan_no=${planList.plan_no}">
		 		<div class="plan_inner_list ${i3.index+1 }" >
	 				<div class="plan_list_title" style="text-overflow:ellipsis;overflow:hidden;white-space:nowrap">
	 					<div style="margin-top: 50px;">	
	 					<span>${planList.s_date }</span><span>${planList.days}DAYS</span><br>
	 					<span class="plan_title">${planList.plan_name }</span>
	 					</div>
	 				</div>
		 			<div class="plan_list_bg">
						<img src="${pageContext.request.contextPath}/resources/img/city/cityIMG/${city_list[planList.city_no].city_img1}">		 				
		 			</div>
		 			<div class="plan_list_ex">
		 				<span>
							<c:choose>
								<c:when test="${planList.thema == 1 }">
									가족여행
								</c:when>
								<c:when test="${planList.thema == 2 }">
									친구여행
								</c:when>
								<c:when test="${planList.thema == 3 }">
									커플여행
								</c:when>
								<c:otherwise>
									나홀로여행
								</c:otherwise>
							</c:choose>
							
						</span>
		 				<div class="plan_counts"><img src="${pageContext.request.contextPath}/resources/img/plan/pn_list_view_icon.png">&nbsp;&nbsp;${planList.counts }</div>
		 				<div class="plan_clips"><img src="${pageContext.request.contextPath}/resources/img/plan/list_clip_icon.png">&nbsp;&nbsp;${planList.jim }</div>
		 				<div class="plan_spots"><img src="${pageContext.request.contextPath}/resources/img/plan/pn_list_spot_icon.png">&nbsp;&nbsp;${planList.spot_counts }</div>
		 				<div class="pfilter_clear"></div>
		 				<div class="plan_bigcity">${planList.city_names}</div>
		 				<div class="pfilter_clear"></div>
		 				<div class="plan_id">${planList.id }</div>
		 			</div>
		 		</div>
		 		</a>
	 		</c:forEach>
			</div>
			          
         </div>
     </div>
	 
	 
	 
	 
	 
	  
	  <!-- review n scrap tab -->
	  
	  <div role="tabpanel" class="tab-pane fade" id="reviewnscrap" aria-labelledby="reviewnscrap-tab">
			<div class="p_home_body" id="p_home_body_reviewnsacrap_1">
					<div class="p_reviewnscrap_1" id="p_review_1">
												<div class="p_review_list">	
												<h1>review</h1>
													<div id="p_review_body_list_img" class="p_body_div_1">
										      			<div class="p_body_div_2"  id="p_review_body_list_img_info">g</div>
										      		</div>
													<div class="p_body_div_3" id="p_review_body_list_contents"></div>	
												</div>
												
												<div class="p_review_list">	
													<div id="p_review_body_list_img" class="p_body_div_1">
										      			<div class="p_body_div_2"  id="p_review_body_list_img_info">g</div>
										      		</div>
													<div class="p_body_div_3" id="p_review_body_list_contents"></div>	
												</div>
					</div>
					<div class="p_reviewnscrap_1" id="p_scrap_1">
												<div class="p_scrap_list">
												<h1>scrap</h1>
													<div id="p_scrap_body_list_img" class="p_body_div_1">
										      			<div class="p_body_div_2" id="p_scrap_body_list_img_info">g</div>
										      		</div>
													<div class="p_body_div_3" id="p_scrap_body_list_contents"></div>	
												</div>
					
												<div class="p_scrap_list">
													<div id="p_scrap_body_list_img" class="p_body_div_1">
										      			<div class="p_body_div_2" id="p_scrap_body_list_img_info">g</div>
										      		</div>
													<div class="p_body_div_3" id="p_scrap_body_list_contents"></div>	
												</div>
					
					
					</div>
				
					
			
			</div>
	  </div>
	  
	  
	  
	  
	  <!--QnA tab  -->
	  
	  <div role="tabpanel" class="tab-pane fade" id="QnA" aria-labelledby="QnA-tab">
			<div id="p_qna_writebtn"><button type="button" id="modalbt1" data-toggle="modal" data-target="#p_qnaWritemodal" class="btn btn-warning">질문 하기</button></div>
			<div class="p_home_body p_qna_body"><h1>QnA</h1> 
				
			</div>
			
		
	  </div>
	  
	  
	  
	  
	  
	  
	  <!--my info tab  -->
	  
	  <div role="tabpanel" class="tab-pane fade" id="myinfo" aria-labelledby="myinfo-tab">
			<div class="p_home_body" ">
						<div id="p_home_body_mypage">
							<form action="${pageContext.request.contextPath}/member/update" method="post">
								<div>
							<table class="table table-striped">
								<tr>
									<td><h1>my info</h1><input type="hidden" name="no" value="${member.no}"></td>
								</tr>
								<tr>
									<td><div class="input-group p_myinfo_input"><span class="input-group-addon" id="p_addon_1">ID</span>
  										<input type="text" class="form-control"  name="id" readonly="memberID" value="${member.id}" aria-describedby="basic-addon1">
											</div>
									</td>
								</tr>
								<tr>
									<td><div class="input-group p_myinfo_input"><span class="input-group-addon" id="p_addon_2">PW</span>
  										<input type="password" class="form-control" id="p_up_pwcheck" name="pw"  aria-describedby="basic-addon1">
											</div>
									</td>
								</tr>
								<tr>
									<td><div class="input-group p_myinfo_input"><span class="input-group-addon" id="p_addon_3">Name</span>
  										<input type="text" class="form-control" id="p_up_namecheck"  name="name" value="${member.name}"  aria-describedby="basic-addon1">
											</div>
									</td>
								</tr>
								<tr>
									<td><div class="input-group p_myinfo_input"><span class="input-group-addon" id="p_addon_4" >Email</span>
  										<input type="email" class="form-control" placeholder="Email" name="email" id="p_up_echeck"  value="${member.email}" aria-describedby="basic-addon1">
											</div>
											<div id="p_up_emailcheckresult">${echeck}</div>
									</td>
								</tr>
								
							</table>
									<button type="button" class="button button5" id="p_update_btn">수정 완료</button>
							  </div>
							</form>
									<a href="${pageContext.request.contextPath}/member/mypage"><button class="button button3" id="p_updatecancel_btn">수정 취소</button></a><span>              </span>
							<div id="p_mypage_moutbt"><button type="button" class="btn btn-warning" data-toggle="modal" data-target=".bs-example-modal-sm" id="">회원 탈퇴</button></div>						

										<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
										  <div class="modal-dialog modal-sm">
										    <div class="modal-content" id="p_modal_mout">
										     <form action="${pageContext.request.contextPath}/member/delete" method="post">
												 <input type="hidden" name="no" value="${member.no}">
										      <br><br><span>정말로 탈퇴 하시겠습니까?</span><br><br><br>
									  		  <button type="submit" class="button button3">예</button></a><span>              </span>
										      <button class="button button5" data-dismiss="modal" >아니오</button>
										     </form>	
										    </div>	
										  </div>
										</div>
						</div>
			
			</div>
	  </div>
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	</div>
	
</div>






<!--QnA write Modal -->
<div class="modal fade" id="p_qnaWritemodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" id="p_qna_md_2">
      <form action="${pageContext.request.contextPath}/member/qna_write" id="frm" method="post">
    <div class="modal-content" id="p_qna_md_3">
		     	<div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">질문 하기</h4>
     			</div>
     				<input type="hidden" name="id" value="${member.id}">
     				<input type="hidden" name="m_img" value="${member.m_img}">
					<input type="text" id="p_qna_mdtitle" name="title" placeholder="제목을 입력하세요.">
							<div class="modal-body">
					<textarea name="contents" id="SmartEditor" rows="10" cols="100" style="width: 568px; height: 170px;"></textarea>
							</div>
		      </div>
		      <div class="modal-footer" id="p_qna_footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        <button type="button" id="savebutton" class="btn btn-primary">Save</button>
		      </div>
		</form>
    
    </div>
  </div>

<!--QnA Replywrite Modal -->
<div class="modal fade" id="p_qnaReplymodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document" id="p_qna_md_2">
      <form action="${pageContext.request.contextPath}/member/replyqna_write" method="post">
  		  <div class="modal-content" id="p_qna_md_4">
		     	<div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">답변 하기</h4>
     			</div>
					<input type="text" id="p_qna_mdtitle"  name="title" placeholder="제목을 입력하세요.">
							<div class="modal-body" id="replyqna_md_body">
					<textarea name="contents" id="ir3" rows="10" cols="100" style="width: 568px; height: 170px;"></textarea>
							</div><div id="p_hidden_d_ata"></div>
		      </div>
		      <div class="modal-footer" id="p_replymd_footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		        <button type="submit" id="replyqna_submit" class="btn btn-primary">Save</button>
		      </div>
		</form>
    
    </div>
  </div>








</body>
