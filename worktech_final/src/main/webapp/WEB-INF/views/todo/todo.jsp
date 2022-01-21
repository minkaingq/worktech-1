<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Calendar</title>
<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />
<!-- Font Awesome -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=IBM+Plex+Sans+KR&display=swap" rel="stylesheet">
<!-- Theme style -->
<link rel="stylesheet" href="resources/dist/css/adminlte.min.css" />
<!-- myFullCalendar -->
<link rel="stylesheet" href='resources/FullCalendar-Example-master/vendor/css/select2.min.css' />
<link rel="stylesheet" href='resources/FullCalendar-Example-master/vendor/css/bootstrap-datetimepicker.min.css' />
<link rel="stylesheet" href="resources/FullCalendar-Example-master/vendor/css/bootstrap.min.css?sb" />
<link rel="stylesheet" href="resources/FullCalendar-Example-master/css/main.css">
<link rel="stylesheet" href="resources/FullCalendar-Example-master/vendor/css/fullcalendar.min.css" />
<!-- myFullCalendar -->


<style>
body {font-family: 'Do Hyeon', sans-serif;
font-family: 'IBM Plex Sans KR', sans-serif;}

/* select2 */
.select2-container--default .select2-selection--multiple .select2-selection__rendered .select2-search.select2-search--inline .select2-search__field
	{
	margin-top: 4px;
}

.select2-container--default .select2-selection--multiple .select2-selection__choice
	{
	background-color: limegreen;
	border: none;
}

.select2-container--default .select2-selection--multiple .select2-selection__choice__remove
	{
	color: black;
}

.select2-container--default .select2-results__option--highlighted[aria-selected]
	{
	background-color: #0074f0;
	color: #fff;
}

.btn-tool {
	position: relative;
	top: 12px;
}
/* select2 */
#space {
	height: 100px;
	background-color: #f4f6f9;
}

#eventModal {
	padding-right: 0px !important;
}

.modal-header .close {
	padding: 1rem;
	margin: -1rem -1rem -1rem auto;
	opacity: .5;
}
/* 모달 가운데 */
.modal {
	text-align: center;
}

.fc-title, .fc-time {
	font-size: 11.9px;
}

#eventModal {
	padding-bottom: 80px;
	padding-right: 0px;
}

@media screen and (min-width: 768px) {
	.modal:before {
		display: inline-block;
		vertical-align: middle;
		content: " ";
		height: 100%;
	}
}

.modal-dialog {
	display: inline-block;
	text-align: left;
	vertical-align: middle;
}
/* 모달 가운데 */





</style>


</head>

<body>
<%-- <c:import url="../common/headerUser.jsp" /> --%>
<div>
		<div class="main-content">
<!-- 			<!-- Content Header (Page header) --> 
<!-- 				<div class="container-fluid"> -->
<!-- 					<div class="row mb-2"> -->
<!-- 						<div class="col-sm-8"> -->
<!-- 							<h1>일정 관리</h1> -->
<!-- 						</div> -->
<!-- 						<div class="col-sm-4"></div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				/.container-fluid -->
<!-- 			</section> -->
<!-- 			<!-- /.container-fluid -->
<!-- 			<!-- 			</section>

			<!-- Main content -->
			<br>
			<h1 class="section-title" style="text-align:center; text-weight:bold;">개인 캘린더</h1><br>
			<section class="section">
			<div class="section-header">
<!-- 				<h1>개인 캘린더</h1> -->
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
					</div>
<!-- 					<div class="breadcrumb-item">개인 캘린더</div> -->
				</div>
			</div>
<!-- 				<div class="container-fluid"> -->
			<div class="section-body">
<!-- 				<h2 class="section-title">개인 캘린더</h2> -->
					<div class="row">
						<div class="col-xs-2">
							<div class="card card-primary">
								<div class="card-header">
									<div class="card-tools">
										<button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
											<i class="fas fa-minus"></i>
										</button>
									</div>
								</div>
								<div class="card-body">
									<label for="calendar_view">카테고리</label>
									<div class="form-group">
										<!-- 									<div class="col-lg-6"> -->
										<div class="input-group">
											<select class="filter" id="type_filter" multiple="multiple">
												<option value="업무">팀 업무</option>
												<option value="개인">개인</option>
												<option value="프로젝트">프로젝트</option>
												<option value="회의">회의</option>
											</select>
										</div>
									</div>
<!-- 																		</div> -->
									<div class="form-group">
<!-- 																			<div class="col-lg-6"> -->
<!-- 										<label for="calendar_view">일정별 </label> -->
										<div class="input-group">
											<input style="display:none;" class='filter' type="checkbox" value="${loginUser.mNo }" checked>
											<label class="checkbox-inline">
											<input class='filter' type="checkbox" value="true" checked>일정 분류</label> 
										</div>
									</div>
									
									
									
								</div>
							</div>
<!-- 							<br> -->
	<button onclick="location.href='javascript:history.back();'"  type="reset" class="btn btn-default">뒤로 가기</button>
<!-- 								<input type="button"  onclick="location.href=''javascript:history.back();'"> -->
						</div>
						<div class="col-xs-9">
							<div class="card card-primary">
								<div id="loading"></div>
								<div id="calendar" class="fc fc-unthemed fc-ltr"></div>
							</div>
						</div>
						
					</div>
<!-- 				</div> -->
<!-- 				</div> -->
				
				<!-- /.filter panel -->

				<div class="container">
					<!-- 일자 클릭시 메뉴오픈 -->
					<div id="contextMenu" class="dropdown clearfix">
						<ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu" style="display: block; position: static; margin-bottom: 5px;">
							<li><a tabindex="-1" href="#">팀 업무</a></li>
							<li><a tabindex="-1" href="#">개인</a></li>
							<li><a tabindex="-1" href="#">프로젝트</a></li>
							<li><a tabindex="-1" href="#">회의</a></li>
							<li class="divider"></li>
							<li><a tabindex="-1" href="#" data-role="close">닫기</a></li>
						</ul>
					</div>

					<!-- 					<div id="wrapper"> -->
					<!-- 						<div id="loading"></div> -->
					<!-- 					</div> -->


					<!-- 일정 추가 MODAL -->
					<div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title"></h4>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">

									

									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-title">일정명</label>
											<input class="inputModal" type="text" name="edit-title" id="edit-title" required="required" />
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-start">시작일</label>
											<input class="inputModal" type="text" name="edit-start" id="edit-start" />
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-end">종료일</label>
											<input class="inputModal" type="text" name="edit-end" id="edit-end" />
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-type">카테고리</label> <select class="inputModal" type="text" name="edit-type" id="edit-type">
												<option value="업무">업무</option>
												<option value="개인">개인</option>
												<option value="출장">출장</option>
												<option value="회의">회의</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-color">색상</label> <select class="inputModal" name="color" id="edit-color">
												<option value="#D25565" style="color: #D25565;">red</option>
												<option value="#9775fa" style="color: #9775fa;">purple</option>
												<option value="#74c0fc" style="color: #74c0fc;">blue</option>
												<option value="#f06595" style="color: #f06595;">pink</option>
												<option value="#63e6be" style="color: #63e6be;">green</option>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="col-xs-12">
											<label class="col-xs-4" for="edit-desc">내용</label>
											<textarea rows="4" cols="50" class="inputModal" name="edit-desc" id="edit-desc"></textarea>
										</div>
									</div>
								</div>
								<div class="modal-footer modalBtnContainer-addEvent">
									<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
									<button type="button" class="btn btn-primary" id="save-event">저장</button>
								</div>
								<div class="modal-footer modalBtnContainer-modifyEvent">
									<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
									<button type="button" class="btn btn-primary" id="updateEvent">저장</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->


				</div>
				</div>
			</section>
			<!-- /.content -->
		</div>
<!-- 		<div id="space"></div> -->




		<!--       </footer> -->
		<c:import url="../common/footer.jsp" />

	<!-- ./wrapper -->












	<!-- jQuery -->
	<script src="resources/plugins/jquery/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- jQuery UI -->
	<script src="resources/plugins/jquery-ui/jquery-ui.min.js"></script>
	<!-- AdminLTE App -->
	<script src="resources/dist/js/adminlte.min.js"></script>
	<!-- fullCalendar 2.2.5 -->
			<script src="resources/plugins/moment/moment.min.js"></script>
			<script src="resources/plugins/fullcalendar/main.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="resources/dist/js/demo.js"></script>
	<!-- Page specific script -->
	<script src="resources/FullCalendar-Example-master/vendor/js/jquery.min.js"></script>
	<!--  -->
	<script src="resources/FullCalendar-Example-master/vendor/js/moment.min.js"></script>
	<script src="resources/FullCalendar-Example-master/vendor/js/fullcalendar.min.js"></script>
	<script src="resources/FullCalendar-Example-master/vendor/js/ko.js"></script>
	<script src="resources/FullCalendar-Example-master/vendor/js/select2.min.js"></script>
	<script src="resources/FullCalendar-Example-master/vendor/js/bootstrap-datetimepicker.min.js"></script>
	<script src="resources/FullCalendar-Example-master/js/main.js"></script>
	<script src="resources/FullCalendar-Example-master/js/addEvent.js"></script>
	<script src="resources/FullCalendar-Example-master/js/editEvent.js"></script>
	<script src="resources/FullCalendar-Example-master/js/etcSetting.js"></script>
	<script src="resources/FullCalendar-Example-master/vendor/js/bootstrap.min.js"></script>
</body>
</html>
