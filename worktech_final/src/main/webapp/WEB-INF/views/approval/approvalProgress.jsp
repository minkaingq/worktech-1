<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>전자 결재</title>
	
	<link rel="stylesheet" href="resources/assets/modules/bootstrap-daterangepicker/daterangepicker.css">
  	<link rel="stylesheet" href="resources/assets/modules/bootstrap-colorpicker/dist/css/bootstrap-colorpicker.min.css">
  	<link rel="stylesheet" href="resources/assets/modules/select2/dist/css/select2.min.css">
  	<link rel="stylesheet" href="resources/assets/modules/jquery-selectric/selectric.css">
  	<link rel="stylesheet" href="resources/assets/modules/bootstrap-timepicker/css/bootstrap-timepicker.min.css">
  	<link rel="stylesheet" href="resources/assets/modules/bootstrap-tagsinput/dist/bootstrap-tagsinput.css">
  	
	<style>
        table {
            border-collapse: collapse;
            background: white;
        }

        table th {
            border-bottom: 1px solid #e3e3e3;
            text-align: center;
            font-size: 15px;
        }

        table td {
            text-align: center;
            font-size: 15px;
        }		
	
		.section-header{
			padding: 20px, 35px;
			margin: -10px, -30px, 30px;
		}
		
		.paging-area {
            display: flex;
            justify-content: center;
        }
	</style>
</head>

<body>
	<c:import url="../common/headerUser.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>결재 진행함</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="#">전자 결재</a>
					</div>
					<div class="breadcrumb-item">결제 진행함</div>
				</div>
			</div>
			
			<div class="col-12 col-md-12 col-lg-12">
                <div class="card">
                  <form method="post" class="needs-validation" >
                    <div class="card-header">
                      <h4>검색창</h4>
                    </div>
                    <div class="card-body">
                        <div class="row">                               
                          <div class="form-group col-md-6 col-12">
                            <label>문서 제목</label>
                            <input type="text" class="form-control" >
                          </div>
                          <div class="form-group col-md-6 col-12">
                            <label>문서 </label>
                            <input type="text" class="form-control" >
                          </div>
                        </div>
                    </div>
                    
                    <div class="card">
                  		<div class="card-body">
                  			<div class="row">
                    		<div class="form-group col-md-6 col-12">
                      		<label>작성일</label>
                      			<div class="input-group">
                        			<div class="input-group-prepend">
                          				<div class="input-group-text">
                            				<i class="fas fa-calendar"></i>
                          				</div>
                        			</div>
                        			<input type="text" class="form-control daterange-cus">
                      			</div>
                    		</div>
	                  		<div class="card-footer text-right">
	                     		<button class="btn btn-primary">검색</button>
	                    	</div>                    		
                  		</div>
                	</div>
                	</div>
                	

                  </form>
            	</div>
            </div>
			
			<div class="table-responsive">
				<h2 class="section-title">결제 대기</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="row row-cols-1 row-cols-md-3 mb-3">
								<div class="col">
									<div class="card mb-4 rounded-3 shadow-sm">
										<table class="table" id="table">
											<thead>
                                        		<tr>
                                            		<th class="col-1">결재 번호</th>
                                            		<th class="col-1"></th>
                                            		<th class="col-5">결재 작성자 / 결재 작성일</th>
                                            		<th class="col-3">결재 작성자 / 부서명</th>
                                            		<th class="col-3">결재 진행도</th>
                                        		</tr>
                                    		</thead>
											<tbody>
											<c:forEach var="app" items="${ list }">
												<tr>
													<td rowspan="2" class="col-1"><h4 class="my-0 fw-normal">${ app.appNo }</h4></td>
													<td rowspan="2" class="col-1">
														<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
			  												<path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1h-5zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
			  												<path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5L9.5 0zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
														</svg>
													</td>
													<td class="col-5"><h4 class="my-0 fw-normal">${ app.appTitle }</h4></td>
													<td class="col-3"> <h4 class="my-0 fw-normal">${ app.mName } ${ app.jobGrade }</h4></td>
													<td rowspan="2" class="col-3">
														<c:choose>
															<c:when test="${ app.appResult eq '0' }">대기중</c:when>
															<c:when test="${ app.appResult eq '1' }">진행중</c:when>
															<c:when test="${ app.appResult eq '2' }">승인</c:when>
															<c:when test="${ app.appResult eq '3' }">반려</c:when>
														</c:choose>
													</td>
												</tr>
												<tr>
													<td class="col-5">${ app.appDate }</td>
													<td class="col-3">${ app.dName }</td>
												</tr>
											</c:forEach>
											</tbody>
						          		</table>
						       		</div>					       								       		
						      	</div>				
							</div>						
							<div class="card-body paging-area">
								<div class="buttons">
									<nav aria-label="Page navigation example">
										<ul class="pagination">
											<c:if test="${ pi.currentPage <= 1 }">
												<li class="page-item disabled">
													<a class="page-link" aria-label="Previous">
														<i class="fas fa-angle-double-left"></i>
	                                                </a>
	                                            </li>
	                                            <li class="page-item disabled">
	                                                <a class="page-link" aria-label="Previous">
                                                        <i class="fas fa-angle-left"></i>
                                                    </a>
                                                </li>
											</c:if>
                                            	<c:if test="${ pi.currentPage > 1 }">
                                            		<c:url var="start" value="approvalwait.ap">
														<c:param name="page" value="1"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ start }" aria-label="Previous">
	                                                        <i class="fas fa-angle-double-left"></i>
	                                                    </a>
	                                                </li>
													<c:url var="before" value="approvalwait.ap">
														<c:param name="page" value="${ pi.currentPage - 1 }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ before }" aria-label="Previous">
	                                                        <i class="fas fa-angle-left"></i>
	                                                    </a>
	                                                </li>
	                                            </c:if>
	                                            <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                                            	<c:if test="${ p eq pi.currentPage }">
	                                            		<li class="page-item disabled"><a class="page-link">${ p }</a></li>
	                                            	</c:if>
	                                            
	                                            	<c:if test="${ p ne pi.currentPage }">
		                                            	<c:url var="pagination" value="approvalwait.ap">
															<c:param name="page" value="${ p }"/>
														</c:url>
	                                            		<li class="page-item">
	                                            			<a class="page-link" href="${ pagination }">${ p }</a>
	                                            		</li>
	                                            	</c:if>
	                                            </c:forEach>
												<c:if test="${ pi.currentPage >= pi.maxPage }">
	                                                <li class="page-item disabled">
	                                                	<a class="page-link" aria-label="Next">
	                                                		<i class="fas fa-angle-right"></i>
	                                                	</a>
	                                                </li>
	                                                <li class="page-item disabled">
	                                                	<a class="page-link" aria-label="Next">
	                                                		<i class="fas fa-angle-double-right"></i>
	                                                	</a>
	                                                </li>
												</c:if>
												<c:if test="${ pi.currentPage < pi.maxPage }">
													<c:url var="after" value="approvalwait.ap">
														<c:param name="page" value="${ pi.currentPage + 1 }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ after }" aria-label="Next">
	                                                        <i class="fas fa-angle-right"></i>
	                                                    </a>
	                                                </li>
													<c:url var="end" value="approvalwait.ap">
														<c:param name="page" value="${ pi.maxPage }"/>
													</c:url>
	                                                <li class="page-item">
	                                                    <a class="page-link" href="${ end }" aria-label="Next">
	                                                        <i class="fas fa-angle-double-right"></i>
	                                                    </a>
	                                                </li>
												</c:if>
                                            </ul>
                                        </nav>
                                    </div>
                                </div>						
						</div>
					</div>
				</div>
			</div>
	</section>
	</div>
	<c:import url="../common/footer.jsp" />
	
	<script>
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
	
		  <!-- JS Libraies -->
  <script src="resources/assets/modules/cleave-js/dist/cleave.min.js"></script>
  <script src="resources/assets/modules/cleave-js/dist/addons/cleave-phone.us.js"></script>
  <script src="resources/assets/modules/jquery-pwstrength/jquery.pwstrength.min.js"></script>
  <script src="resources/assets/modules/bootstrap-daterangepicker/daterangepicker.js"></script>
  <script src="resources/assets/modules/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
  <script src="resources/assets/modules/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
  <script src="resources/assets/modules/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
  <script src="resources/assets/modules/select2/dist/js/select2.full.min.js"></script>
  <script src="resources/assets/modules/jquery-selectric/jquery.selectric.min.js"></script>
	

</body>

</html>