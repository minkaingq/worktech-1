<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기타 예약</title>
	<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/dist/assets/css/style.css">
	<link rel="stylesheet" href="resources/dist/assets/css/components.css">
	<!-- timepicker -->
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">


	<script src="resources/js/jquery-3.6.0.min.js"></script>
<style>
	.content{
		margin: 0 auto;
		display: table;
		margin-left: auto;
		margin-top: 40px; 
		argin-right: auto;
		width: 400px;
		border: 1px solid #e3e3e3;
	}
	.title{
		 margin-top: 8%;
		margin-left: 10%;
	}
	.table{
		margin-top: 10px;
		margin-left: 5%;
		margin-bottom: 20px;
	}
	.table td{
		height: 40px;
		font-size: 14px;
		/* border: 1px solid #e3e3e3;  */
		
	}
	
	button{
		background-color: #e3e3e3;
		border: none;
		margin-left: 20px;
		margin-top: 10px;
		width: 80px;
		height: 40px;
		border-radius: 5px;
		margin-bottom: 10%;
	}
	button:hover{
		cursor: pointer;
	}
	.btn_class{
		margin-left: 23%;
	}
	.first{
		width: 110px;
		font-weight: bold;
	}
	#inputArea {
			display: none;
		}
</style>
</head>
<body>
<div class="content">
		<div class="title">
			<h3>기타 예약</h3>
		</div>
		<form method="post" name="rvForm">
			<table class="table">
				<tr>
					<td class="first">자원명</td>
					<td>
						<select id="rvName" name="rvName" style="width: 188px; border: 1px solid #e3e3e3;">
							<option value="${ rv.pdName }">${ rv.pdName }</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="first">수량</td>
					<td>
						<input type="number" name="rvCount" style="width: 180px; border: 1px solid #e3e3e3;" min="1" max="${ rv.pdCount }" value="1">
					</td>
				</tr>
				<tr>
					<td valign="top" style="height: 130px; padding-top: 20px;"  class="first">사용 용도</td>
					<td valign="top" style="padding-top: 20px;">
						<textarea name="rvUsage" style="width: 220px; height: 100px; border: 1px solid #e3e3e3; resize: none;"></textarea>
					</td>
				</tr>
			</table>
			<div id="inputArea">
					<input type="hidden" name="rvType" value="ETC">
					<input type="hidden" name="rvpNo" value="${ rv.pdNo }">
					<input type="hidden" name="rvCategory" value="${ rv.pdCategory }">
				</div>
			<div class="btn_class">
				<button class="btn btn-primary mr-1"  type="submit" onclick="return addOtherReservation();">예약</button>
				<button class="btn btn-danger mr-1"  onclick="window.close();">취소</button>
			</div>
		</form>
	</div>
	
	<script>
		
		function addOtherReservation(){
			
			document.rvForm.target = "rvView";
			document.rvForm.action = "otherReservationInsert.rv";
			document.rvForm.method = "POST";
			document.rvForm.submit();
			
			self.close();
		}
	</script>
</body>
</html>