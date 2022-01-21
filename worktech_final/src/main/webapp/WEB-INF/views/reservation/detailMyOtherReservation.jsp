<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 예약 상세 조회</title>
	<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">
	<link rel="stylesheet" href="resources/dist/assets/css/style.css">
	<link rel="stylesheet" href="resources/dist/assets/css/components.css">
<script src="resources/js/jquery-3.6.0.min.js"></script>
<style>
	.content{
		margin: 0 auto;
		display: table;
		margin-left: auto;
		margin-top: 30px; 
		argin-right: auto;
		width: 400px;
		border: 1px solid #e3e3e3;
	}
	.title{
		margin-top: 8%;
		margin-left: 10%;
	}
	.table{
		margin-top: 20px;
	}
	.table td{
		height: 40px;
		font-size: 13px;
		/* border: 1px solid #e3e3e3;  */
		
	}

	button{
		background-color: #e3e3e3;
		border: none;
		margin-left: 20px;
		margin-top: 40px;
		width: 80px;
		height: 40px;
		border-radius: 5px;
		margin-bottom: 10%;
	}
	button:hover{
		cursor: pointer;
	}
	.btn_class{
		text-align: center;
	}
	.first{
		width: 150px;
		font-weight: bold;
	}
</style>
</head>
<body>
<div class="content">
	<div class="title">
			<h3>예약 확인</h3>
		</div>
		<table class="table">
			<tr>
				<td class="first">자원명</td>
				<td>
					${ rv.rvName }
				</td>
			</tr>
			<tr>
				<td class="first">수량</td>
				<td>${ rv.rvCount } 개</td>
			</tr>
			<tr>
				<td class="first">예약 날짜</td>
				<td>${ rv.rvDate }</td>
			</tr>
			<tr>
				<td class="first">사용 용도</td>
				<td>${ rv.rvUsage }</td>
			</tr>
		</table>
		<div id="inputArea">
			<input type="hidden" name="rvNo" id="rvNo" value="${ rv.rvNo }">
			<input type="hidden" name="rvpNo" id="rvpNo" value="${ rv.rvpNo }">
			<input type="hidden" name="rvCount" id="rvCount" value="${ rv.rvCount }">
		</div>
		<div class="btn_class">
			<button class="btn btn-primary mr-1" onclick="window.close();">닫기</button>
			<c:if test="${ rv.rvStatus eq 'N' }">
				<button class="btn btn-danger mr-1" id="15" name="rvNo" value="${ rv.rvNo }" onclick="return DeleteReservation();">반납</button>
			</c:if>
		</div>

	</div>
<script>
	function DeleteReservation(){
		
		
		var bool = confirm('반납하시겠습니까?');
		var rvNo = $('#rvNo').val();
		var rvpNo = $('#rvpNo').val();
		var rvCount = $('#rvCount').val();
		
		if(bool) {
			$.ajax({
				url: 'orvListDelete.rv',
				data: {rvNo:rvNo, rvpNo:rvpNo, rvCount:rvCount},
				success: function(data){
					console.log(data);
					opener.parent.location.reload();
					self.close();
				},
				error: function(data){
					console.log(data)
				}
			});
		}

	}
</script>
</body>
</html>