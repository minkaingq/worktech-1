<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
  <title>채팅 목록</title>

  <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<!--   <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script> -->
  <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <link rel="stylesheet" href="resources/dist/assets/modules/prism/prism.css">
  <link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
  <!-- General CSS Files -->
<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">

<!-- Template CSS -->
<link rel="stylesheet" href="resources/dist/assets/css/style.css">
<link rel="stylesheet" href="resources/dist/assets/css/components.css">

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
    }

    .container {
      margin-top: 20px;
      margin-bottom: 20px;
    }

    img {
      max-width: 100%;
    }

    .inbox_msg {
      border: 1px solid #c4c4c4;
      clear: both;
      overflow: hidden;
    }

    .recent_heading {
      float: left;
      width: 40%;
    }

    .srch_bar {
      display: inline-block;
      text-align: right;
      width: 65%;
      height: 100%;
    }

    .headind_srch {
      padding: 10px 0px 10px 20px;
      overflow: hidden;
      background: rgba(0, 0, 0, 0.1);
      border-bottom: 1px solid #c4c4c4;
    }

    .recent_heading h4 {
      color: #666666;
      font-size: 20px;
      margin: auto;
    }

    .srch_bar button {
      background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
      border: medium none;
      padding: 0;
      color: #707070;
      font-size: 18px;
      outline: 0;
    }

    .srch_bar input {
      border: 1px solid #cdcdcd;
      border-width: 0 0 1px 0;
      width: 80%;
      padding: 2px 0 4px 6px;
      background: none;
    }

    .srch_bar  {
      background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
      border: medium none;
      padding: 0;
      color: #707070;
      font-size: 18px;
    }

    .srch_bar {
      margin: 0 0 0 -27px;
    }

    .chat_ib h5 {
      font-size: 15px;
      color: #464646;
      margin: 0 0 8px 0;
    }

    .chat_ib h5 .chat_date {
      font-size: 13px;
      float: right;
    }

    .chat_ib p {
      font-size: 14px;
      color: #989898;
      margin: auto
    }

    .chat_img {
      float: left;
      width: 11%;
    }

    .chat_ib {
      float: left;
      padding: 0 0 0 15px;
      width: 88%;
    }

    .chat_people {
      overflow: hidden;
      clear: both;
    }

    .chat_list {
      border-bottom: 1px solid #c4c4c4;
      margin: 0;
      padding: 18px 16px 10px;
    }
    
    .alarmBadge {
    	display: inline-block;
    	background: #FF4848;
    	border-radius: 100%;
    	width: 18px;
    	height: 18px;
    	text-align: center;
    	color: white;
    	font-size: 12px;
    	margin-left: 5px;
    	position: absolute;
    }
    
    .btn {
    	display: inline-block;
    	margin: 0px;
    	padding: 0px;
    	width: 30px;
    }
    
    button:hover{
    	cursor: pointer;
    }
    
    .chatNo {
    	display: none;
    }
  </style>
</head>

<body>
	<div class="container">
		<div class="messaging">
			<div class="inbox_msg">
				<div class="headind_srch">
					<div class="recent_heading">
						<h4>채팅 목록</h4>
					</div>
					<div class="srch_bar">
<!-- 						<div class="btn"> -->
<!-- 							<button type="button"> -->
<!-- 								<i class="fas fa-cog"></i> -->
<!-- 							</button> -->
<!-- 						</div> -->
						<div class="btn">
							<button type="button" id="addChat">
								<i class="fas fa-plus"></i>
							</button>
						</div>
					</div>
				</div>
				<form action="chatDetail.ct" method="post" id="goDetail">
					<input type="hidden" name="chatRoomNo" id="chatRoomNo">
					<div id="chatBody">
						<c:forEach var="ch" items="${ list }">
							<div class="chat_list">
								<div class="chatNo">${ ch.chatRoomNo }</div>
								<div class="chat_people">
									<div class="chat_img">
										<c:if test="${ fn:length(ch.gatheringList) > 2 }">
											<img src="resources/dist/assets/img/avatar/avatar-group.png" class="mr-3 rounded-circle" width="50"
												alt="image">
										</c:if>
										<c:if test="${ fn:length(ch.gatheringList) == 2 }">
											<c:forEach var="gl" items="${ ch.gatheringList }">
												<c:if test="${ gl.gatheringMember != loginUser.mNo }">
													<c:if test="${ gl.profile ne null }">
														<img src="resources/profileUploadFiles/${ gl.profile.pReName }" class="mr-3 rounded-circle" width="50" height="50"
															alt="image">
													</c:if>
													<c:if test="${ gl.profile eq null }">
														<img src="resources/dist/assets/img/avatar/avatar-1.png" class="mr-3 rounded-circle" width="50"
															alt="image">
													</c:if>
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${ fn:length(ch.gatheringList) < 2 }">
											<img src="resources/dist/assets/img/avatar/avatar-4.png" class="mr-3 rounded-circle" width="50"
												alt="image">
										</c:if>
									</div>
									<div class="chat_ib">
										<h5>
											<c:if test="${ fn:length(ch.gatheringList) >= 2 }">
												<c:if test="${ ch.chatTitle eq 'Personal' }">
													<c:forEach var="gl" items="${ ch.gatheringList }">
														<c:if test="${ gl.gatheringMember != loginUser.mNo }">
															${ gl.gatheringMemberDName } ${ gl.gatheringMemberName } ${ gl.gatheringMemberJobGrade }
														</c:if>
													</c:forEach>
												</c:if>
												<c:if test="${ ch.chatTitle ne 'Personal' }">
													${ ch.chatTitle } <b>(${ fn:length(ch.gatheringList) })</b>
												</c:if>
											</c:if>
											<c:if test="${ fn:length(ch.gatheringList) < 2 }">
												대화 상대 없음
											</c:if>
											<c:if test="${ ch.notReadCount != 0 }">
												<span class="alarmBadge">${ ch.notReadCount }</span>
											</c:if>
											<span class="chat_date">
												<jsp:useBean id="today" class="java.util.Date" />
												<fmt:formatDate var="now" value="${today}" pattern="yyyy-MM-dd" />
												
												<c:if test="${ now eq ch.date }">
													${ ch.time }
												</c:if>
												<c:if test="${ now ne ch.date }">
													${ ch.date }
												</c:if>
											</span>
										</h5>
										<p>${ ch.recentMsg }</p>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<script>
    	// 게시글 목록 마우스오버 이벤트
	    $(document).on('mouseover', '.chat_list', function() {
	    	$(this).css({'background':'rgba(0, 0, 0, 0.04)', 'font-weight':'bold', 'cursor':'pointer'});
		});
    	
	    $(document).on('mouseout', '.chat_list', function() {
	    	$(this).css({'background':'none', 'font-weight':'normal'});
		});
	    
	    $(document).on('click', '.chat_list', function() {
	    	var chatRoomNo = $(this).find('.chatNo').text();
			$('#chatRoomNo').val(chatRoomNo);
			$('#goDetail').submit();
		});
    	
    	$(function() {
	    	$('#addChat').click(function() {
	    		location.href='addChatView.ct';
			});
	    });
    	
    	function chatListReload() {
			$.ajax({
				url: 'reloadChatList.ct',
				success: function(data) {
					var chatBody = $('#chatBody');
					var loginmNo = ${ loginUser.mNo };
					var innerDiv = '';
					
					chatBody.html('');
					
					for(var i in data){
						innerDiv += '<div class="chat_list">'
									+ '<div class="chatNo">' + data[i].chatRoomNo + '</div>'
									+ '<div class="chat_people">'
									+ '<div class="chat_img">';
									
						if(data[i].gatheringList.length > 2){
							innerDiv += '<img src="resources/dist/assets/img/avatar/avatar-group.png" class="mr-3 rounded-circle" width="50" height="50" alt="image">';
						} else if (data[i].gatheringList.length == 2) {
							for(var g in data[i].gatheringList){
								if(data[i].gatheringList[g].gatheringMember != loginmNo){
									if(data[i].gatheringList[g].profile != null){
										innerDiv += '<img src="resources/profileUploadFiles/' + data[i].gatheringList[g].profile.pReName + '" class="mr-3 rounded-circle" width="50" alt="image">';
									} else {
										innerDiv += '<img src="resources/dist/assets/img/avatar/avatar-1.png" class="mr-3 rounded-circle" width="50" alt="image">';
									}
								}
							}
						} else {
							innerDiv += '<img src="resources/dist/assets/img/avatar/avatar-4.png" class="mr-3 rounded-circle" width="50" alt="image">';
						}
						
						innerDiv += '</div>'
									+ '<div class="chat_ib">'
									+ '<h5>';
						
						if(data[i].gatheringList.length >= 2){
							if(data[i].chatTitle == 'Personal'){
								for(var g in data[i].gatheringList){
									if(data[i].gatheringList[g].gatheringMember != loginmNo){
										innerDiv += data[i].gatheringList[g].gatheringMemberDName + ' ' + data[i].gatheringList[g].gatheringMemberName + ' ' + data[i].gatheringList[g].gatheringMemberJobGrade;
									}
								}
							} else {
								innerDiv += data[i].chatTitle + ' <b>(' + data[i].gatheringList.length + ')</b>';
							}
						} else{
							innerDiv += '대화 상대 없음';
						}
						
						if(data[i].notReadCount != 0){
							innerDiv += '<span class="alarmBadge">' + data[i].notReadCount + '</span>';
						}
						
						innerDiv += '<span class="chat_date">';
						
						// 오늘 날짜
						var today = new Date(); 
						var year = today.getFullYear(); 
						var month = ('0' + (today.getMonth() + 1)).slice(-2);
						var day = ('0' + today.getDate()).slice(-2);
						
						var now = year + '-' + month + '-' + day;
						
						if(now == data[i].date){
							innerDiv += data[i].time;
						} else{
							innerDiv += data[i].date;
						}
						
						innerDiv += '</span></h5>'
									+ '<p>' + data[i].recentMsg + '</p>'
									+ '</div></div></div>';
					}
					
					chatBody.html(innerDiv);
				},
				error: function(data) {
					console.log(data);
					console.log("error");
				}
			});
		}
    	
    	// 5초마다 채팅방 업데이트
    	$(function() {
//     		chatListReload();
			
// 			setInterval(function() {
// 				chatListReload();
// 			}, 5000);
		});
	    
	</script>
	
	<!-- General JS Scripts -->
<!-- 	<script src="resource/dist/assets/modules/jquery.min.js"></script> -->
<!-- 	<script src="resource/dist/assets/modules/popper.js"></script> -->
<!-- 	<script src="resource/dist/assets/modules/tooltip.js"></script> -->
<!-- 	<script src="resource/dist/assets/modules/bootstrap/js/bootstrap.min.js"></script> -->
<!-- 	<script src="resource/dist/assets/modules/nicescroll/jquery.nicescroll.min.js"></script> -->
<!-- 	<script src="resource/dist/assets/modules/moment.min.js"></script> -->
<!-- 	<script src="resource/dist/assets/js/stisla.js"></script> -->
	
	<!-- JS Libraies -->
<!-- 	<script src="resource/dist/assets/modules/prism/prism.js"></script> -->
	
	<!-- Page Specific JS File -->
<!-- 	<script src="resource/dist/assets/js/page/bootstrap-modal.js"></script> -->
	
	<!-- Template JS File -->
<!-- 	<script src="resource/dist/assets/js/scripts.js"></script> -->
<!-- 	<script src="resource/dist/assets/js/custom.js"></script> -->
</body>


</html>