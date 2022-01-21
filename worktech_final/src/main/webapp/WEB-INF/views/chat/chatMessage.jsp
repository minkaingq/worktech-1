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
    <title>채팅 메시지</title>

    <!-- General CSS Files -->
    <link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">

    <!-- CSS Libraries -->

    <!-- Template CSS -->
    <link rel="stylesheet" href="resources/dist/assets/css/style.css">
    <link rel="stylesheet" href="resources/dist/assets/css/components.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
    
    <script src="resources/js/jquery-3.6.0.min.js"></script>
    <!-- Start GA -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-94034622-3"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }
        gtag('js', new Date());

        gtag('config', 'UA-94034622-3');
    </script>
    <!-- /END GA -->

    <style>
        body{
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        #chatMsgBody{
        	height: 400px;
        }
        
        .senderName{
        	display: inline-block; 
        	margin-left: 10px; 
        	font-size: 13px; 
        	font-weight: 900;
        	margin-bottom: 5px;
        }
        
        .chatRoomOpen, .sysMsg {
        	text-align: center;
        	margin-bottom: 15px;
        	font-size: 12px;
        	color: gray;
        }
        
        .main-content {
        	padding-top: 40px;
        }
        
        #endChat {
        	visibility: hidden;
        }
        
        a:hover{
        	cursor: pointer;
        }
        
        .myInfo:hover{
        	cursor: default !important;
        	background: none;
        }
    </style>
</head>

<body>
    <div class="main-content">
        <section class="section">
            <div class="col-12 col-sm-6 col-lg-4">
                <div class="card chat-box" id="mychatbox">
                    <div class="card-header">
                    	<h4 style="width: 90%;">
	                    	<c:if test="${ fn:length(memberList) > 1 }">
		                    	<c:if test="${ cr.chatTitle eq 'Personal' }">
									<c:forEach var="gl" items="${ memberList }">
										<c:if test="${ gl.gatheringMember != loginUser.mNo }">
											${ gl.gatheringMemberDName } ${ gl.gatheringMemberName } ${ gl.gatheringMemberJobGrade }
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${ cr.chatTitle ne 'Personal' }">
									${ cr.chatTitle } <b>(${ fn:length(memberList) })</b>
								</c:if>
							</c:if>
							<c:if test="${ fn:length(memberList) <= 1 }">
								대화 상대 없음
							</c:if>
                    	</h4>
                    	<c:if test="${ fn:length(memberList) > 2 }">
	                    	<ul class="navbar-nav navbar-right" style="width: 5%; text-align: right;">
		                    	<li class="dropdown" >
			                        <a data-toggle="dropdown" class="nav-link-lg nav-link-user">
										<i class="fas fa-users"></i>
			                        </a>
									<div class="dropdown-menu dropdown-menu-right">
			                            <a onclick="inviteChat()" class="dropdown-item has-icon">
			                                <i class="fas fa-user-plus"></i> 채팅방 초대
			                            </a>
			                            <c:forEach var="gl" items="${ memberList }">
											<c:if test="${ gl.gatheringMember != loginUser.mNo }">
												<c:url value='addPersonalChat.ct' var="personalChat">
													<c:param name="selectmNo" value="${ gl.gatheringMember }"/>
												</c:url>
					                            <a href="${ personalChat }" class="dropdown-item">
													<c:if test="${ gl.profile != null }">
														<img src="resources/profileUploadFiles/${ gl.profile.pReName }" class="mr-1 rounded-circle" width="20" height="20"
															alt="image">
													</c:if>
													<c:if test="${ gl.profile == null }">
														<img src="resources/dist/assets/img/avatar/avatar-1.png" class="mr-1 rounded-circle" width="20"
															alt="image">
													</c:if>
						                               ${ gl.gatheringMemberName } ${ gl.gatheringMemberJobGrade }
						                            <c:if test="${ gl.gatheringMember == cr.chatOpenMem }">
						                            	<i class="fas fa-crown" style="color: #FFBB00;"></i>
						                            </c:if>
					                            </a>
											</c:if>
											<c:if test="${ gl.gatheringMember == loginUser.mNo }">
												<a class="dropdown-item myInfo">
													<c:if test="${ gl.profile.pReName != null }">
														<img src="resources/profileUploadFiles/${ gl.profile.pReName }" class="mr-3 rounded-circle" width="20" height="20"
															alt="image">
													</c:if>
													<c:if test="${ gl.profile.pReName == null }">
														<img src="resources/dist/assets/img/avatar/avatar-1.png" class="mr-1 rounded-circle" width="20"
															alt="image">
													</c:if>
													 <span style="color: #67d4ef;">${ gl.gatheringMemberName } ${ gl.gatheringMemberJobGrade }</span> 
													 <c:if test="${ gl.gatheringMember == cr.chatOpenMem }">
						                            	<i class="fas fa-crown" style="color: #FFBB00;"></i>
						                            </c:if>
												</a>
											</c:if>
										</c:forEach>
			                        </div>
		                        </li>
	                        </ul>
                        </c:if>
                    	<ul class="navbar-nav navbar-right" style="width: 5%; text-align: right;">
	                    	<li class="dropdown" >
		                        <a data-toggle="dropdown" class="nav-link-lg nav-link-user">
									<i class="fas fa-bars"></i>
		                        </a>
								<div class="dropdown-menu dropdown-menu-right">
		                            <a href="chatView.ct" class="dropdown-item">
		                               <i class="fas fa-arrow-alt-circle-left"></i> &nbsp;&nbsp;목록으로
		                            </a>
									<c:if test="${ fn:length(memberList) > 2 }">
			                            <a href="#" onclick="renameChatRoom();" class="dropdown-item has-icon">
			                                <i class="fas fa-user-edit"></i> 채팅방 이름 변경
			                            </a>
		                            </c:if>
		                            <a href="#" onclick="exitChatRoom();" class="dropdown-item has-icon text-danger">
		                                <i class="fas fa-sign-out-alt"></i> 채팅방 나가기
		                            </a>
		                            <c:if test="${ cr.chatOpenMem == loginUser.mNo && fn:length(memberList) > 2 }">
			                            <a href="#" onclick="deleteChatRoom();" class="dropdown-item has-icon text-danger">
			                                <i class="fas fa-trash"></i> 채팅방 삭제
			                            </a>
		                            </c:if>
		                        </div>
	                        </li>
                        </ul>
                    </div>
                    <jsp:useBean id="today" class="java.util.Date" />
					<fmt:formatDate var="now" value="${today}" pattern="yyyy-MM-dd" />
                    <div class="card-body chat-content" tabindex="1" style="overflow: hidden; outline: none;" id="chatMsgBody">
	                    <div class="chatRoomOpen">채팅방이 생성되었습니다.</div>
	                    <c:forEach var="msg" items="${ messageList }">
	                    	<c:if test="${ msg.readYN ne 'Y' && loginUser.mNo != msg.sendMember }">
	                    		<div class="chat-item chat-left">
	                    			<div class="senderName">${ msg.sendMemberFullName }</div>
	                    			<c:if test="${ msg.pReName != null }">
	                    				<img src="resources/profileUploadFiles/${ msg.pReName }" width="50" height="50">
	                    			</c:if>
	                    			<c:if test="${ msg.pReName == null }">
	                    				<img src="resources/dist/assets/img/avatar/avatar-1.png">
	                    			</c:if>
	                    			<div class="chat-details">
		                    			<div class="chat-text">${ msg.msgContent }</div>
	                                	<div class="chat-time">
	                                		<c:if test="${ now eq msg.date }">
												${ msg.time }
											</c:if>
											<c:if test="${ now ne msg.date }">
												${ msg.date }
											</c:if>
	                                	</div>
	                                </div>
	                    		</div>
	                    	</c:if>
	                    	<c:if test="${ msg.readYN ne 'Y' && loginUser.mNo == msg.sendMember }">
	                    		<div class="chat-item chat-right">
	                    			<c:if test="${ msg.pReName != null }">
	                    				<img src="resources/profileUploadFiles/${ msg.pReName }" width="50" height="50">
	                    			</c:if>
	                    			<c:if test="${ msg.pReName == null }">
	                    				<img src="resources/dist/assets/img/avatar/avatar-1.png">
	                    			</c:if>
	                    			<div class="chat-details">
		                    			<div class="chat-text">${ msg.msgContent }</div>
		                    			<div class="chat-time">
	                                		<c:if test="${ now eq msg.date }">
												${ msg.time }
											</c:if>
											<c:if test="${ now ne msg.date }">
												${ msg.date }
											</c:if>
	                                	</div>
                                	</div>
	                    		</div>
	                    	</c:if>
	                    	<c:if test="${ msg.readYN eq 'Y' }">
	                    		<div class="sysMsg">${ msg.msgContent }</div>
	                    	</c:if>
	                    </c:forEach>
	                    <div id="endChat"></div>
                    </div>
                    <div class="card-footer chat-form">
	                    <c:if test="${ fn:length(memberList) <= 1 }">
		                    <input type="text" id="msg" class="form-control" placeholder="더이상 메시지를 보낼 수 없는 채팅방입니다." readonly="readonly">
	                    </c:if>
	                    <c:if test="${ fn:length(memberList) > 1 }">
		                    <c:if test="${ cr.chatType == 0 }">
		                    	<input type="text" id="msg" class="form-control" onkeyup="enterkey()" placeholder="메시지를 입력하세요">
		                    </c:if>
		                    <c:if test="${ cr.chatType == 1 }">
			                    <c:if test="${ cr.chatOpenMem != loginUser.mNo }">
			                    	<input type="text" id="msg" class="form-control" placeholder="해당 채팅방은 개설자만 메시지 전송이 가능합니다" readonly="readonly">
			                    </c:if>
			                    <c:if test="${ cr.chatOpenMem == loginUser.mNo }">
			                    	<input type="text" id="msg" class="form-control" onkeyup="enterkey()" placeholder="메시지를 입력하세요">
			                    </c:if>
		                    </c:if>
	                    </c:if>
	                    <button class="btn btn-primary" id="button-send">
	                        <i class="far fa-paper-plane"></i>
	                    </button>
                    </div>
                </div>
            </div>
        </section>
    </div>
    
    <script type="text/javascript">
		var sock = new SockJS("http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/chat");
		
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		sock.onopen = onOpen;
		
		// 일반 메시지
		function sendMessage() {
			// 메시지 부분이 비어 있지 않으면
			if($('#msg').val() != ''){
				// 내 메시지 서버로 보내기
				var message = $("#msg").val();
				
				var sendMemberFullName = "${ loginUser.dName } ${ loginUser.name } ${ loginUser.jobGrade }";
				
				var data = {
						"msgContent" : message,
						"chatRoomNo" : "${ cr.chatRoomNo }",
		                "sendMember" : "${ loginUser.mNo }",
		                "sendMemberFullName" : sendMemberFullName,
		                "pReName" : "${ loginUser.profile.pReName }"
		            };
				
		        var jsonData = JSON.stringify(data);
		        
		        // 보낸 메시지 추가
		        var chatMsgBody = $('#chatMsgBody');
		        var innerDiv = '';
		        
		        innerDiv += '<div class="chat-item chat-right">';
		        
		        if("${ loginUser.profile.pReName }" != '' && "${ loginUser.profile.pReName }" != null ){
		        	innerDiv += '<img src="resources/profileUploadFiles/${ loginUser.profile.pReName }" width="50" height="50">';	
		        } else {
		        	innerDiv += '<img src="resources/dist/assets/img/avatar/avatar-1.png">';
		        }
		        
		        // 현재 시간 구하기
		        var today = new Date();   
	
		        var hours = today.getHours(); // 시
		        var minutes = today.getMinutes();  // 분
		        
		        var now = hours + ":" + minutes;
		        
		        innerDiv += '<div class="chat-details">'
		        			+ '<div class="chat-text">' + message + '</div>'
		        			+ '<div class="chat-time">' + now + '</div></div></div>';
		        
		        chatMsgBody.append(innerDiv);
		        
		        updateTime();
		        sock.send(jsonData);
		        
		        $('#msg').val('');
			} else {
				alert("메시지를 입력하세요.");
				$('#msg').focus();
			}
		}
		
		//서버에서 메시지를 받았을 때
		function onMessage(msg) {
			
			var msgData = JSON.parse(msg.data);
			
			var msgContent = msgData.msgContent;
			var chatRoomNo = msgData.chatRoomNo;
			var sendMember = msgData.sendMember;
			var sendMemberFullName = msgData.sendMemberFullName;
			var pReName = msgData.pReName;
			var readYN = msgData.readYN;
			
			// 받은 메시지 추가
			// 동일한 채팅방일 경우
			if(chatRoomNo == "${ cr.chatRoomNo }"){
				
				// 보낸 사람이 내가 아닐 경우에만 추가해야 함
				if(sendMember != "${ loginUser.mNo }"){
					var chatMsgBody = $('#chatMsgBody');
			        var innerDiv = '';
	
			        if(readYN != 'Y'){
				        // 일반 메시지
						innerDiv += '<div class="chat-item chat-left">'
									+ '<div class="senderName">' + sendMemberFullName + '</div>';
				        
				        if(pReName != '' && pReName != null ){
				        	innerDiv += '<img src="resources/profileUploadFiles/' + pReName + '" width="50" height="50">';	
				        } else {
				        	innerDiv += '<img src="resources/dist/assets/img/avatar/avatar-1.png">';
				        }
				        
				        // 현재 시간 구하기
				        var today = new Date();   
			
				        var hours = today.getHours(); // 시
				        var minutes = today.getMinutes();  // 분
				        
				        var now = hours + ":" + minutes;
				        
				        innerDiv += '<div class="chat-details">'
				        			+ '<div class="chat-text">' + msgContent + '</div>'
				        			+ '<div class="chat-time">' + now + '</div></div></div>';
				        
				        chatMsgBody.append(innerDiv);
					} else {
						// 시스템 메시지
						innerDiv += '<div class="sysMsg">' + msgContent + '</div>';
					    chatMsgBody.append(innerDiv);
					}
				}
				
				updateScroll();
				updateTime();
			}
		}
		
		//채팅창에서 나갔을 때
		function onClose(evt) {
			updateTime();
		}
		
		//채팅창에 들어왔을 때
		function onOpen(evt) {
			var names = '${names}';
			
			if(names != ''){
				names = names.replace("[", '');
				names = names.replace("]", '');
				
				var nameArr = names.split(", ");
				sendSystemMessage(nameArr);
			}
			updateTime();
		}
	
		// 채팅 전송
		$('#button-send').on('click', function(e) {
			sendMessage();
			updateScroll();
		});
		
		// readtime update ajax
		function updateTime() {
			var mNo = "${ loginUser.mNo }";
			var chatRoomNo = ${ cr.chatRoomNo };
			
			$.ajax({
				url: 'updateTime.ct',
				data: {mNo:mNo, chatRoomNo:chatRoomNo},
				success: function(data) {
					console.log(data);
				},
				error: function(data) {
					console.log(data);
				}
			});
		}
		
		// 가장 아래 메시지로 스크롤 내리기
		function updateScroll(){
		    var element = document.getElementById("chatMsgBody");
		    element.scrollTop = element.scrollHeight;
		}
		
		window.onload = function(){
			var offset = $('#endChat').offset();
			$('#chatMsgBody').animate({scrollTop : offset.top}, 400);
		}
		
		// 채팅방 이름 변경
		function renameChatRoom() {
			var renameTitle = prompt('변경할 채팅방 이름을 입력하세요', '${ cr.chatTitle }');
			
			if(renameTitle == ''){
				alert('채팅방 이름을 입력하세요');
				
			} else if (renameTitle != null){
				if(renameTitle != '${ cr.chatTitle }' ) {
					if(confirm("해당 채팅방의 모든 사용자에게 적용됩니다.")){
						var url = 'renameChatTitle.ct';
						var inputData = {"chatTitle":renameTitle, "chatRoomNo":"${cr.chatRoomNo}"};
						
						submitForm(url, inputData);
					}
				} else{
					alert('같은 이름으로 변경할 수 없습니다.');
				}
			}
		}
		
		function exitChatRoom() {
			if(confirm("채팅방을 나가시겠습니까?")){
				var url = 'quitChatRoom.ct';
				var inputData = {"gatheringMember":"${ loginUser.mNo }", "chatRoomNo":"${cr.chatRoomNo}"};
				
				submitForm(url, inputData);
			}
		}
		
		function deleteChatRoom() {
			if(confirm("채팅방을 삭제하시겠습니까?\n※ 모든 사용자에게서 삭제됩니다.")){
				var url = 'deleteChatRoom.ct';
				var inputData = {"chatRoomNo":"${cr.chatRoomNo}"};
				
				submitForm(url, inputData);
			}
		}
		
		
		// submit form 생성
		function submitForm(url, inputData) {
			var newForm = $('<form></form>'); 
			newForm.attr("method","post"); 
			newForm.attr("action", url);
			
			for(var i in inputData){
				newForm.append($('<input/>', {type: 'hidden', name: i, value: inputData[i] })); 
			}
			
			newForm.appendTo('body'); 
			newForm.submit();
		}
		
		// 엔터키로 전송하기
		function enterkey() {
			if (window.event.keyCode == 13) {
				sendMessage();
			}
		}

		// 시스템 메시지
		function sendSystemMessage(nameArr) {
			// 내 메시지 서버로 보내기
			var message = '';
			var count = nameArr.length - 1;
			
			if(nameArr.length > 1){
				message = "${ loginUser.name } 님이 [" + nameArr[0] + "] 님 외 " + count + "명을 초대하였습니다.";
			} else{
				message = "${ loginUser.name } 님이 [" + nameArr[0] + "] 님을 초대하였습니다.";
			}
			
			var sendMemberFullName = "${ loginUser.dName } ${ loginUser.name } ${ loginUser.jobGrade }";
			
			var data = {
					"msgContent" : message,
					"chatRoomNo" : "${ cr.chatRoomNo }",
	                "sendMember" : "${ loginUser.mNo }",
	                "sendMemberFullName" : sendMemberFullName,
	                "readYN" : "Y"
	        };
			
	        var jsonData = JSON.stringify(data);
	        
	        // 시스템 메시지 추가
	        var chatMsgBody = $('#chatMsgBody');
	        var innerDiv = '';
	        
	        innerDiv += '<div class="sysMsg">' + message + '</div>';
	        
	        chatMsgBody.append(innerDiv);
	        
	        updateTime();
	        sock.send(jsonData);
		        
		}
		
		// 채팅방 초대
		function inviteChat() {
			location.href = 'inviteChatMemberView.ct?chatRoomNo=' + ${ cr.chatRoomNo };
		}
	</script>

    <!-- General JS Scripts -->
    <script src="resources/dist/assets/modules/jquery.min.js"></script>
    <script src="resources/dist/assets/modules/popper.js"></script>
    <script src="resources/dist/assets/modules/bootstrap/js/bootstrap.min.js"></script>
    <script src="resources/dist/assets/modules/nicescroll/jquery.nicescroll.min.js"></script>
<!--     <script src="resources/dist/assets/js/stisla.js"></script> -->

    <!-- JS Libraies -->

    <!-- Page Specific JS File -->
<!--     <script src="resources/dist/assets/js/page/components-chat-box.js"></script> -->

    <!-- Template JS File -->
    <script src="resources/dist/assets/js/scripts.js"></script>
    <script src="resources/dist/assets/js/custom.js"></script>
</body>
</html>