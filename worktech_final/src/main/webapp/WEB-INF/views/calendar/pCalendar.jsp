<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>개인 캘린더</title>
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
	
	  document.addEventListener('DOMContentLoaded', function() {
	
	    /* initialize the calendar
	    -----------------------------------------------------------------*/
	
	    var calendarEl = document.getElementById('calendar');
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
	      },
	      locale: "ko",
	      selectable : true,
		  selectMirror : false,
		  selectOverlap: true,
	      editable: true,
	      events:function(info, successCallback, failureCallback){
	           // ajax로 등록된 일정 불러오기
	      }, 
	      eventClick: function(info) {
			info.jsEvent.preventDefault();
				
			if(info.event.url){
				// 일정 상세 확인 코드 작성
	
			}
		  },
		  select: function(arg) { 
			var start = new Date(arg.start.getTime() - (arg.start.getTimezoneOffset() * 60000)).toISOString().slice(0, -1);
			var end = new Date(arg.end.getTime() - (arg.end.getTimezoneOffset() * 60000));
			end = new Date(end.setDate(end.getDate() - 1)).toISOString().slice(0, -1);
			$('#calStart').val(start);
			$('#calEnd').val(end);
				
			// 날짜 선택 시 실행할 코드 작성
			window.name = 'calendarView';
			var f = $('#inputForm');
				
			window.open('', 'calInsert', 'width=500px, height=550px, resizable=no, toolbar=1');
			$('#inputForm').submit();
		  }
			
	    });
	    calendar.render();
	
	  });
	
	</script>
<style>
	body {
		margin-top: 40px;
		font-size: 14px;
		font-family: 'Noto Sans KR', sans-serif;
	}
	
	#calendar {
		max-width: 1100px;
		margin: 0 auto;
	}
	
	#inputArea {
		visibility: hidden;
	}
</style>
</head>
<body>
	<c:import url="../common/headerUser.jsp" />
	<div id="inputArea">
		<form id="inputForm" target="calInsert" action="insertView.cr">
			<input id="calStart" name="calStart" type="datetime-local">
			<input id="calEnd" name="calEnd" type="datetime-local">
		</form>
	</div>
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>개인 캘린더</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="#">캘린더</a>
					</div>
					<div class="breadcrumb-item">개인 캘린더</div>
				</div>
			</div>
			<div class="section-body">
				<h2 class="section-title">개인 캘린더</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-body">
								<div class="card">
									<div class="card-body">
										<div id='wrap'>
											<div id='calendar-wrap'>
												<div id='calendar'></div>
											</div>
										</div>
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