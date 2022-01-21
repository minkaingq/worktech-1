<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>일정 추가</title>
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
	</style>
</head>
<body>
	<div class="content">
		<div class="title">
			<h5>일정 추가</h5>
		</div>
		<form method="post" name="pCalForm" id="pCalForm">
			<div class="tableDiv">
				<table class="table">
					<tr>
						<td class="first">일정명</td>
						<td>
							<input name="calTitle" id="calTitle" type="text" style="width: 220px; border: 1px solid #e3e3e3;">
						</td>
					</tr>
					<tr>
						<td class="first">시작일</td>
						<td><input id="calStart" name="calStartStr" type="datetime-local" style="width: 220px; border: 1px solid #e3e3e3;" value="${ calStart }"></td>
					</tr>
					<tr>
						<td class="first">종료일</td>
						<td><input id="calEnd" name="calEndStr" type="datetime-local" style="width: 220px; border: 1px solid #e3e3e3;" value="${ calEnd }"></td>
					</tr>
					<tr>
						<td valign="top" style="height: 130px; padding-top: 20px;"  class="first">기타 메모</td>
						<td valign="top" style="padding-top: 20px;">
							<textarea name="calContent" style="width: 220px; height: 100px; border: 1px solid #e3e3e3; resize: none;"></textarea>
						</td>
					</tr>
				</table>
			</div>
			<div class="btn_class">
				 <button class="btn btn-primary mr-1" type="submit" onclick="return addCalendar();">등록</button>
				 <input class="btn btn-danger mr-1" type="button" value="취소" onclick="window.close();">
			</div>
		</form>
	</div>
	
</body>

<script>
	function addCalendar(){
		
		if($('#calTitle').val() != '' && $('#calTitle').val() != null){
			document.pCalForm.target = "calendarView";
			document.pCalForm.action = "insertPCal.cr";
			document.pCalForm.method = "POST";
			document.pCalForm.submit();
			
			self.close();
			return false;
		} else {
			alert('일정명을 입력하세요');
			return false;
		}
	}
</script>
</html>