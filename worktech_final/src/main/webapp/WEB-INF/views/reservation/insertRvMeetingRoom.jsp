<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회의실 예약</title>
	<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="resources/dist/assets/css/style.css">
	<link rel="stylesheet" href="resources/dist/assets/css/components.css">
	
	<!-- timepicker -->
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	
	<!-- Google Font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
	
	<script src="resources/js/jquery-3.6.0.min.js"></script>
	<style>
		body{
			background-color: white;
			font-family: 'Noto Sans KR', sans-serif;
			font-size: 15px;
		}
	
		.content{
			margin: 0 auto;
			margin-top: 35px; 
			width: 400px;
			border: 1px solid #e3e3e3;
		}
		.title{
			margin-top: 8%;
			margin-left: 5%;
		}
		.table{
			margin-top: 40px;
			margin-left: 20px;
		}
		.table td{
			height: 40px;
			padding: 10px !important;
			font-size: 14px;
			
		}
	
		.btn_class{
			text-align: center;
			margin-bottom: 20px;
		}
		
		.first{
			width: 90px;
			font-weight: bold;
		}
		
		.tableDiv{
			text-align: center;
		}
		
		.timepicker:hover{
			cursor: pointer;
		}
		
		.timepicker{
			text-align: center;
		}
		
		#inputArea {
			display: none;
		}
	</style>
</head>
<body>
	<div class="content">
		<div class="title">
			<h5>회의실 예약</h5>
		</div>
		<form method="post" name="rvForm">
			<div class="tableDiv">
				<table class="table">
					<tr>
						<td class="first">자원명</td>
						<td>
							<select name="rvName" id="rvName" style="width: 220px; border: 1px solid #e3e3e3;" disabled>
								<option value="회의실" selected>회의실</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="first">날짜</td>
						<td><input id="rvDate" name="rvDate" type="date" style="width: 220px; border: 1px solid #e3e3e3;"></td>
					</tr>
					<tr>
						<td class="first">예약 시간</td>
						<td>
							<input type="text" class="timepicker" name="startTime" id="rvStartTime" style="width: 100px; border: 1px solid #e3e3e3;" readonly="readonly">
							~
							<input type="text" class="timepicker" name="endTime" id="rvEndTime" style="width: 100px; border: 1px solid #e3e3e3;" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td valign="top" style="height: 130px; padding-top: 20px;"  class="first">사용 용도</td>
						<td valign="top" style="padding-top: 20px;">
							<textarea name="rvUsage" style="width: 220px; height: 100px; border: 1px solid #e3e3e3; resize: none;">사용 인원(또는 부서) : 
사용 목적 : </textarea>
						</td>
					</tr>
				</table>
				<div id="inputArea">
					<input type="hidden" name="rvType" value="MEETING">
				</div>
			</div>
			<div class="btn_class">
				 <button class="btn btn-primary mr-1" type="submit" onclick="return addMeetingRoom();">예약</button>
				 <input class="btn btn-danger mr-1" type="button" value="취소" onclick="window.close();">
			</div>
		</form>
	</div>
	
	<script>
		document.getElementById('rvDate').value = new Date().toISOString().substring(0, 10);
		
// 		var checkDup = 999;
		
		function checkDupTime(rvStartTime, rvEndTime) {
			$.ajax({
				url: 'checkTime.rv',
				async: false,
				data: {rvStartTime:rvStartTime, rvEndTime:rvEndTime},
				success: function(data) {
					if(data == 0){
						$('#rvName').prop('disabled', false);
						
						document.rvForm.target = "rvView";
						document.rvForm.action = "rvMeetingRoomInsert.rv";
						document.rvForm.method = "POST";
						document.rvForm.submit();
						
						self.close();
					}  else {
						alert("이미 예약된 시간입니다.");
						return false;
					}
				},
				error: function(data) {
					console.log("error : " + data);
				}
			});
			
			return checkDup;
		}
		
		function addMeetingRoom() {
			var startTime = $("#rvStartTime").val();
			var endTime = $("#rvEndTime").val();
			var rvDate = $("#rvDate").val();
			
			// 현재 시간
			var now = new Date();
			var year = now.getFullYear();
			var month = now.getMonth();
			var day = now.getDate();
			var hours = now.getHours();
			var minutes = now.getMinutes();
			
			var today = new Date(year, month, day, hours, minutes);
			
			if(startTime == '' || endTime == ''){
				alert('예약 시간을 확인해 주세요.');
				return false;
			} else if(startTime == endTime){
				alert("예약 시작 시간과 종료 시간은 동일할 수 없습니다.");
				return false;
			} else{
				// 날짜 합치기
				var rvStartTime = new Date(rvDate + " " + startTime);
				var rvEndTime = new Date(rvDate + " " + endTime);
				
				if(rvStartTime.getTime() > rvEndTime.getTime()){
					alert("예약 종료 시간이 시작 시간보다 빠를 수 없습니다.");
					return false;
				}else if(today.getTime() > rvStartTime.getTime()){
					alert("현재 시간보다 이전 시간으로 예약할 수 없습니다.");
					return false;
				} else {
					checkDupTime(rvStartTime, rvEndTime);
				}
			}
		}
		
		$(function() {
		    $(".timepicker").timepicker({
		        timeFormat: 'HH:mm',
		        interval: 30,
		        minTime: '9',
		        maxTime: '19:00',
		        dynamic: false,
		        dropdown: true,
		        scrollbar: true       
		    });
		});
		
		
	</script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
</body>
</html>