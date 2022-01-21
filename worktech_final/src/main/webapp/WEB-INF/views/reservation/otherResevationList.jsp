<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="resources/js/jquery-3.6.0.min.js"></script>
<title>예약 자원 목록</title>

<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">
<link rel="stylesheet" href="resources/dist/assets/css/style.css">
<link rel="stylesheet" href="resources/dist/assets/css/components.css">

<!-- General CSS Files -->
<link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">

<!-- CSS Libraries -->

<!-- Template CSS -->
<link rel="stylesheet" href="resources/dist/assets/css/style.css">
<link rel="stylesheet" href="resources/dist/assets/css/components.css">
<!-- Start GA -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-94034622-3"></script>

<style>
.content {
	margin: 0 auto;
	margin-left: 30px;
	width: 1000px;
	display: table;
	margin-left: auto;
	margin-right: auto;
}

.title {
	margin-top: 50px;
	border-bottom: 1px solid #cccccc;
	margin-bottom: 40px;
}

.small_title {
	margin-bottom: 40px;
	font-size: 14px;
	font-weight: bold;
}

.r_table {
	border-collapse: collapse;
}

.r_table td {
	text-indent: 30px;
	font-size: 13px;
}

.first_td {
	background: #F2F2F2;
	border-top: 1px solid #e3e3e3;
	border-bottom: 1px solid #e3e3e3;
	height: 45px;
	font-size: 13px;
	text-indent: 20px;
	border-collapse: separate;
}

.last_td {
	border-bottom: 2px solid #e3e3e3;
}

.perso {
	background-color: transparent !important;
	background-image: none !important;
	border-color: transparent;
	border: none;
	font-size: 12px;
	color: #909090;
}

.perso:hover {
	cursor: pointer;
}

.search {
	display: flex;
	justify-content: center;
}

.Searchbtn {
	margin-left: -70px;
	background-color: transparent !important;
	background-image: none !important;
	border-color: transparent;
	font-weight: bold;
	width: 80px;
}

.Searchbtn:hover {
	cursor: pointer;
}

.Searchbtn:active, .Searchbtn:focus {
	outline: none !important;
	box-shadow: none !important;
}

.paging-area {
	display: flex;
	justify-content: center;
}

</style>
</head>
<body>
	<!-- Main Content -->
	<c:import url="../common/headerUser.jsp" />
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>예약 자원 목록</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item">
						<a href="#">기타 예약</a>
					</div>
					<div class="breadcrumb-item">예약 자원 목록</div>
				</div>
			</div>

			<div class="section-body">
				<div class="row">
					<h2 class="section-title">예약 자원 목록</h2>
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-header">
								<!--  <h4>예약 자원 목록</h4> -->
							</div>
							<div class="card-body">
								<table class="table" id="orvTable">
									<thead>
										<tr>
											<th class="first_td"
												style="border-left: 1px solid #e3e3e3; width: 250px;">분류</th>
											<th class="first_td" style="width: 500px;">자원명</th>
											<th class="first_td"
												style="border-right: 1px solid #e3e3e3; width: 250px;">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="o" items="${ list }">
											<tr>
												<td style="height: 75px;">
													<input type="hidden" name="pdNo" value="${ o.pdNo }"> ${ o.pdCategory }
												</td>
												<td>${ o.pdName }</td>
												<td>
													<c:if test="${ o.pdCount > 0 }">
														<button class="btn btn-primary mr-1" id="${ o.pdNo }"
															onclick="rvPopup(this.id)">예약 가능</button>
													</c:if> 
													<c:if test="${ o.pdCount eq 0}">
														<button class="btn btn-danger mr-1" disabled>예약
															불가</button>
													</c:if>
												</td>
											</tr>
										</c:forEach>
									</tbody>
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
            function rvPopup(pdNo){	
            	window.open('otherReservationInsertForm.rv?pdNo=' + pdNo, '자원 예약 폼', 'width=500px,height=570px,scrollbars=yes');       
        	}
            </script>


</body>
</html>