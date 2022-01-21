<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no"
	name="viewport">
<title>회의실 예약</title>

<!-- General CSS Files -->
<link rel="stylesheet"
	href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="resources/dist/assets/modules/fontawesome/css/all.min.css">

<!-- Google Font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
	rel="stylesheet">

<!-- Template CSS -->
<link rel="stylesheet" href="resources/dist/assets/css/style.css">
<link rel="stylesheet" href="resources/dist/assets/css/components.css">
<link href='resources/fullcalendar/lib/main.css' rel='stylesheet' />
<script src='resources/fullcalendar/lib/main.js'></script>
<script src="resources/fullcalendar/lib/locales-all.js"></script>
<script>
	var rvUsage = '';

	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialDate : new Date(),
			initialView : 'timeGridWeek',
			nowIndicator : true,
			headerToolbar : {
				left : 'prev,next today',
				center : 'title',
				right : 'timeGridWeek,listWeek myCustomButton'
			},
			locale: "ko",
			navLinks : true, // can click day/week names to navigate views
			editable : true,
			selectable : true,
			selectMirror : true,
			selectOverlap: false,
			editable: false,
			dayMaxEvents : true, // allow "more" link when too many events
			slotMinTime : "09:00:00", // 시작 시간
			slotMaxTime: "19:00:00", // 종료 시간
			hiddenDays: [0, 6], // 주말 숨기기
			allDaySlot: false, // 종일 제거
			customButtons: {
				myCustomButton: {
					text: '예약 추가',
					click: function() {
						window.name = 'rvView';
						window.open('insertGenRvMeetingRoom.rv', '회의실 예약', 'width=500px, height=550px, resizable=no, toolbar=1');
			        }
				}
			},
			events:function(info, successCallback, failureCallback){
	            $.ajax({
	                   url: 'getrvMeetingRoomList.rv',
	                   dataType: 'json',
	                   success: function(data) {
	                	   var events = [];
	                	   
	                	   // 현재 시간
	                	   var now = new Date();
						   var year = now.getFullYear();
						   var month = now.getMonth();
						   var day = now.getDate();
						   var hours = now.getHours();
						   var minutes = now.getMinutes();
							
						   var today = new Date(year, month, day, hours, minutes);
	                	   
						   
	                	   if(data != null){ 
	                		   $.each(data, function(index, element) {
								   var rvStartTime = new Date(element.rvStartTime);
								   var rvEndTime = new Date(element.rvEndTime);
									
								   if (today >= rvEndTime){
										events.push({
										       title: element.rvMemberFullName,
										       start: rvStartTime,
										       end: rvEndTime,
										       url: "meetRoomRvDetail.rv?rvNo="+element.rvNo,
										       color:"#ff827b"                                                   
										    }); 
										}
								   else{
										events.push({
											   title: element.rvMemberFullName,
										       start: rvStartTime,
										       end: rvEndTime,
										       url: "meetRoomRvDetail.rv?rvNo="+element.rvNo,
										       color:"#67d4ef"                                                   
										    }); 
	                                    }
	                               }); 
	                           }                        
	                          successCallback(events);                               
	                       }                     
	            }); 
	        }, 
	        eventClick: function(info) {
				info.jsEvent.preventDefault();
				
				if(info.event.url){
					window.open(info.event.url, '회의실 예약 상세', 'width=500, height=550');

				}
			},
			select: function(arg) { 
				var today = new Date();
				
				var syear = arg.start.getFullYear();
				var smonth = arg.start.getMonth()+1;
				var sday = arg.start.getDate();
				
				var eyear = arg.end.getFullYear();
				var emonth = arg.end.getMonth()+1;
				var eday = arg.end.getDate();

				var start = [syear, smonth, sday].join('-');
				var end = [eyear, emonth, eday].join('-');
				  
				  if(arg.start < today) {
					  // 지난 날짜 선택하면 예약할 수 없도록
					  alert("현재 시간보다 이전 시간으로 예약할 수 없습니다.");
				  } else {
						
						if(start != end){
							alert('회의실 예약은 하루 단위로만 가능합니다.');
						} else {
							var rvUsage = prompt('사용 용도를 입력하세요', '사용 인원(또는 부서) : \n사용 목적 : ');
							
							if(rvUsage == ''){
								alert('사용 목적이 입력되지 않았습니다.');
							} else if (rvUsage != null){
								$.ajax({
									url: 'insertSelectRvMeetingRoom.rv',
					                dataType: 'json',
					                data: {startTime:arg.start, endTime:arg.end, date:start, rvUsage:rvUsage},
					                success: function(data) {
					                	if(data > 0){
					                		location.href = 'rvMeetingRoomView.rv';
					                	} else {
					                		alert('예약에 실패하였습니다.');
					                	}
					                },
					                error: function (data) {
										console.log(data);
									}
								});
							}
						}
				    }
			}			
		});

		calendar.render();
	});
</script>
<style>
	body {
		margin: 40px 10px;
		padding: 0;
		font-family: 'Noto Sans KR', sans-serif;
		font-size: 14px;
	}
	
	#calendar {
		max-width: 1100px;
		height: 585px;
		margin: 0 auto;
	}
	
	.fc .fc-myCustomButton-button {
		background: #67d4ef;
		border: 1px solid #67d4ef;
		font-weight: 900;
	}
	
	.fc .fc-myCustomButton-button:hover {
		background: #00b9e7;
		border: 1px solid #67d4ef;
		font-weight: 900;
	}
	
	.fc .fc-view>table {
		border: 1px solid #ddd;
	}
</style>
</head>
<body>
	<c:import url="../common/headerUser.jsp" />
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>회의실 예약</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="#">예약</a>
					</div>
					<div class="breadcrumb-item">회의실 예약</div>
				</div>
			</div>
			<div class="section-body">
				<h2 class="section-title">회의실 예약</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-body">
								<div class="card">
									<div class="card-body">
										<div id='calendar'></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<c:import url="../common/footer.jsp" />
</body>
</html>