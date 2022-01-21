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
		
		textarea:focus {
		    outline: none;
		}
		
		textarea {
			width: 220px; height: 100px; border: 1px solid #e3e3e3; resize: none;
			padding: 3px; color: #6C757D;
		}
		
		.border {
			border: 1px solid #e3e3e3; width: 220px; text-align: center;
			margin-left: 36px;
		}
	</style>
</head>
<body>
	<div class="content">
		<div class="title">
			<h5>예약 확인</h5>
		</div>
		<form method="post" name="rvDelete">
			<div class="tableDiv">
				<table class="table">
					<tr>
						<td class="first">자원명</td>
						<td><div class="border">${ rv.rvName }</div></td>
					</tr>
					<tr>
						<td class="first">날짜</td>
						<td><div class="border">${ rv.rvDate }</div></td>
					</tr>
					<tr>
						<td class="first">예약 시간</td>
						<td>
							<div class="border">
								<fmt:formatDate value="${ rv.rvStartTime }" pattern="HH:mm"/>
								~
								<fmt:formatDate value="${ rv.rvEndTime }" pattern="HH:mm"/>
							</div>
						</td>
					</tr>
					<tr>
						<td valign="top" style="height: 130px; padding-top: 20px;"  class="first">사용 용도</td>
						<td valign="top" style="padding-top: 20px;">
							<textarea name="rvUsage" readonly="readonly">${ rv.rvUsage }</textarea>
						</td>
					</tr>
				</table>
				<div id="inputArea">
					<input type="hidden" name="rvNo" value="${ rv.rvNo }">
				</div>
			</div>
			<div class="btn_class">
				 <input class="btn btn-primary mr-1" type="button" value="닫기" onclick="window.close();">
				 <c:set var="now" value="<%=new java.util.Date()%>" />
				 <c:if test="${ loginUser.mNo == rv.rvMember && now <= rv.rvStartTime  }">
					 <button class="btn btn-danger mr-1" type="submit" onclick="return deleteRv();">예약 삭제</button>
				 </c:if>
			</div>
		</form>
	</div>
	
	<script>
		function deleteRv() {
			if(confirm("정말 삭제하시겠습니까?")){
				document.rvDelete.target = "rvView";
				document.rvDelete.action = "rvMeetingRoomDelete.rv";
				document.rvDelete.method = "POST";
				document.rvDelete.submit();
				
				self.close();
			} else{
				return false;				
			}
		}
	</script>
</body>
</html>