<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 예약 목록</title>
<style>
	#table{
		font-size: 13px;
	}
	 .first_td{
	 	background: #F2F2F2;
	 	border-top: 1px solid #e3e3e3;
	 	border-bottom: 1px solid #e3e3e3;
	 	height: 45px;
	 	font-size: 13px;
	 	text-indent: 20px;
	 	border-collapse: separate;
	 }
</style>
</head>
<c:import url="../common/headerUser.jsp" />
<body>
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>기타 예약 목록</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item">
						<a href="#">기타 예약</a>
					</div>
					<div class="breadcrumb-item">기타 예약 목록</div>
				</div>
			</div>

			<div class="section-body">
				<div class="row">
					<h2 class="section-title">나의 예약 목록</h2>
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-header"></div>
							<div class="card-body">
								<table class="table">
									<thead>
										<tr>
											<th class="first_td" style="border-left: 1px solid #e3e3e3;">분류</th>
											<th class="first_td">자원명</th>
											<th class="first_td">상태</th>
											<th class="first_td" style="border-right: 1px solid #e3e3e3;"></th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="rv" items="${ list }">
											<tr>
												<td style="height: 75px;">${ rv.rvCategory }</td>
												<td>${ rv.rvName }</td>
												<c:if test="${ rv.rvStatus eq 'N' }">
													<td style="font-size: 13px;">예약 중</td>
												</c:if>
												<c:if test="${ rv.rvStatus eq 'Y' }">
													<td style="font-size: 13px;">반납 완료</td>
												</c:if>
												<td>
													<button class="btn btn-primary mr-1"
														style="margin-left: 20px;" id="${ rv.rvNo }"
														onclick="popup(this.id)">상세 보기</button>
												</td>
											</tr>
										</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<c:import url="../common/footer.jsp" />
	<script>
       
            function popup(rvNo){	
            	window.open('myOrvDetail.rv?rvNo=' + rvNo, '자원 예약 폼', 'width=500px,height=570px,scrollbars=yes');       
        	}
     </script>

	<script>
	function DetailReservation(){
		
		var rvNo = $('#rvNo').val();
		var rvpNo = $('#rvpNo').val();
		var rvCount = $('#rvCount').val();
		
		$.ajax({
			url: 'orvListDelete.rv',
			data: {rvNo:rvNo, rvpNo:rvpNo, rvCount:rvCount},
			success: function(data){
				console.log(data);
				
			},
			error: function(data){
				console.log(data)
			}
		});
	}
</script>
</body>
</html>