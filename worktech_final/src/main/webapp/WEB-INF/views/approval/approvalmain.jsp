<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>전자 결재</title>
	<style>
		.section-header{
			padding: 20px, 35px;
			margin: -10px, -30px, 30px;
		}
	</style>
</head>

<body>

<c:import url="../common/headerUser.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>전자 결재 홈</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="#">전자 결재</a>
					</div>
				</div>
			</div>
	
 			<div class="section-body">
				<h2 class="section-title">결제 대기</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
							<c:forEach var="app" items="${ list }">
								<div class="col">
									<div class="card mb-4 rounded-3 shadow-sm">
										<div class="card-header py-3">
											<!-- <h4 class="my-0 fw-normal">예산 증액 관련 협조요청 </h4> -->
											<h4 class="my-0 fw-normal">${ app.appTitle }</h4>
										</div>
						          		<div class="card-body">
						          			<p>기안자</p>
						           			<h1 class="card-title pricing-card-title">
						           				<figure class="avatar avatar-xl"><img src="resources/images/propile.png" alt=""></figure>
						           				<!-- OOO 대리 -->${ app.mName } ${ app.jobGrade }
						           			</h1><br>
						            		<!-- <p>기안일 : 2021.12.11 | 13:34</p> --> ${ app.appDate }
						            		<br>
						            		<button type="button" class="w-100 btn btn-lg btn-outline-primary">결제하기</button>
						          		</div>
						       		</div>
						      	</div>
						    </c:forEach>  	
						    </div>
						</div>
					</div>
				</div>
			</div>			
			
			
			<div class="table-responsive">
				<h2 class="section-title">결제 진행</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
						<c:forEach var="app" items="${ list }">
							<div class="row row-cols-1 row-cols-md-3 mb-3">
							
								<div class="col">
									<div class="card mb-4 rounded-3 shadow-sm">
										<table class="table" id="table">
											<tbody>
												<tr>
													<td rowspan="2" class="col-1"><h4 class="my-0 fw-normal">${ app.appNo }</h4></td>
													<td rowspan="2">
														<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
			  												<path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
			  												<path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5L9.5 0zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
														</svg>
													</td>
													<td><h4 class="my-0 fw-normal">${ app.appTitle }</h4></td>
													<td><h4 class="my-0 fw-normal">${ app.mName } ${ app.jobGrade }</h4></td>
													<td rowspan="2">진행중 - 취소</td>
												</tr>
												<tr>
													<td>${ app.appDate }</td>
													<td>${ app.dName }</td>
												</tr>
											</tbody>
						          		</table>
						       		</div>		       								       		
						      	</div>
						    
							</div></c:forEach>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<c:import url="../common/footer.jsp" />

	<script>
		document.getElementById('addDate').value = new Date().toISOString().substring(0, 10);;
		
		$(function(){
			$('#table tr td').mouseenter(function(){
				$(this).parent().css({'color':'yellowgreen', 'font-weight':'bold', 'cursor':'pointer'});
			}).mouseout(function(){
				$(this).parent().css({'color':'black', 'font-weight':'normal'});
			}).click(function(){
				var appNo = $(this).parent().children().eq(0).text();
				location.href="appdetail.ap?appNo=" + appNo + '&page=' + ${pi.currentPage};
			});
		});		
	</script>
</body>

</html>