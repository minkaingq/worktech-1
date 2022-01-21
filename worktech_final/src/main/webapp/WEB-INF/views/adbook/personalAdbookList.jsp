<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no"
	name="viewport">
<title>개인 주소록</title>
<style>
	h4.section-title {
		top: -13px;
		display: inline;
	}
	
	h4.section-title:hover{
		cursor: pointer;
		color: #67d4ef;
	}
	
	#searchBtn {
		height: 100%;
	}
	
	.paging-area {
        display: flex;
        justify-content: center;
	}
	
	 table {
            border-collapse: collapse;
            background: white;
        }

        table th {
/*             border-bottom: 1px solid #e3e3e3; */
            text-align: center;
            font-size: 15px;
        }

        table td {
/*             border-bottom: 1px solid #e3e3e3; */
            text-align: center;
            font-size: 15px;
        }
	
</style>
</head>
<body>
	<c:import url="../common/headerUser.jsp" />

	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>주소록</h1>
				<div class="section-header-breadcrumb">
              <div class="breadcrumb-item active"><a href="#">주소록</a></div>
              <div class="breadcrumb-item">개인 주소록</div>
            </div>
			</div>

			<div class="section-body">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<c:url var="pAdbookList" value="pAdbookList.ab"/>
								<h4 class="section-title" onclick="location.href='${ pAdbookList }'">개인 주소록</h4>
								<div class="card-header-form">
									
									<!-- 개인 주소록 검색 -->
									<c:url var="searchpAdbook" value="searchpAdbook.ab"/>
									<form action="${ searchpAdbook }">
										<div class="input-group">
											<input type="text" class="form-control" name="searchValue" placeholder="Search">
											<div class="input-group-btn">
												<button class="btn btn-primary" id="searchBtn">
													<i class="fas fa-search"></i>
												</button>
											</div>
										</div>
									</form>
								</div>
							</div>

							<div class="card-body">
								<div style="float : right; margin-bottom: 15px;">
									<button class="btn btn-icon icon-left btn-primary" onclick="addContact()">
										<i class="far fa-edit"></i> 추가
									</button>&nbsp;
									<button class="btn btn-icon icon-left btn-danger" onclick="deleteContact()">
										<i class="fas fa-times"></i> 삭제
									</button>
								</div>
								<br>
								<table class="table table-striped" id="pAdbookTable">
									<thead>
										<tr>
											<th scope="col">
												<div class="custom-checkbox custom-control" style="align : center;">
													<input type="checkbox" class="custom-control-input" id="checkbox-all" onclick="clickAll();">
													<label for="checkbox-all" class="custom-control-label">&nbsp;</label>
												</div>
											</th>
											<th scope="col">이름</th>
											<th scope="col">전화번호</th>
											<th scope="col">이메일</th>
											<th scope="col">회사</th>
											<th scope="col">부서명</th>
											<th scope="col">직책</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="c" items="${ list }">
											<tr>
												<td class="p-0 text-center">
													<input type="hidden" name="adNo" value="${ c.adNo }">
													<div class="custom-checkbox custom-control">
														<input type="checkbox" class="custom-control-input" id="${ c.adNo }" name="pAdCheckbox" value="${ c.adNo }" onclick="clickpAd(this);">
														<label for="${ c.adNo }" class="custom-control-label">&nbsp;</label>
													</div>
												</td>
												<td>${ c.adName }</td>
												<td>${ c.adPhone }</td>
												<td>${ c.adEmail }</td>
												<td>${ c.adCompany }</td>
												<td>${ c.adDept }</td>
												<td>${ c.adJob }</td>
											</tr>
										</c:forEach>
								</table>
								<br clear="all">
								<!-- 주소록 페이지 이동 버튼 -->
								<div class="card-body paging-area">
									<div class="buttons">
										<nav aria-label="Page navigation example">
											<ul class="pagination">
												<c:if test="${ pi.currentPage <= 1 }">
													<li class="page-item disabled"><a class="page-link"
														aria-label="Previous"> <i
															class="fas fa-angle-double-left"></i>
													</a></li>
													<li class="page-item disabled"><a class="page-link"
														aria-label="Previous"> <i class="fas fa-angle-left"></i>
													</a></li>
												</c:if>

												<c:if test="${ pi.currentPage > 1 }">
													<c:url var="start" value="${ loc }">
														<c:param name="page" value="1" />
														<c:if test="${ searchValue ne null }">
															<c:param name="searchValue" value="${ searchValue }" />
														</c:if>
													</c:url>
													<li class="page-item"><a class="page-link"
														href="${ start }" aria-label="Previous"> <i
															class="fas fa-angle-double-left"></i>
													</a></li>
													<c:url var="before" value="${ loc }">
														<c:param name="page" value="${ pi.currentPage - 1 }" />
														<c:if test="${ searchValue ne null }">
															<c:param name="searchValue" value="${ searchValue }" />
														</c:if>
													</c:url>
													<li class="page-item"><a class="page-link"
														href="${ before }" aria-label="Previous"> <i
															class="fas fa-angle-left"></i>
													</a></li>
												</c:if>

												<c:forEach var="p" begin="${ pi.startPage }"
													end="${ pi.endPage }">
													<c:if test="${ p eq pi.currentPage }">
														<li class="page-item disabled"><a class="page-link">${ p }</a></li>
													</c:if>

													<c:if test="${ p ne pi.currentPage }">
														<c:url var="pagination" value="${ loc }">
															<c:param name="page" value="${ p }" />
															<c:if test="${ searchValue ne null }">
																<c:param name="searchValue" value="${ searchValue }" />
															</c:if>
														</c:url>
														<li class="page-item"><a class="page-link"
															href="${ pagination }">${ p }</a></li>
													</c:if>
												</c:forEach>

												<c:if test="${ pi.currentPage >= pi.maxPage }">
													<li class="page-item disabled"><a class="page-link"
														aria-label="Next"> <i class="fas fa-angle-right"></i>
													</a></li>
													<li class="page-item disabled"><a class="page-link"
														aria-label="Next"> <i
															class="fas fa-angle-double-right"></i>
													</a></li>
												</c:if>

												<c:if test="${ pi.currentPage < pi.maxPage }">
													<c:url var="after" value="${ loc }">
														<c:param name="page" value="${ pi.currentPage + 1 }" />
														<c:if test="${ searchValue ne null }">
															<c:param name="searchValue" value="${ searchValue }" />
														</c:if>
													</c:url>
													<li class="page-item"><a class="page-link"
														href="${ after }" aria-label="Next"> <i
															class="fas fa-angle-right"></i>
													</a></li>
													<c:url var="end" value="${ loc }">
														<c:param name="page" value="${ pi.maxPage }" />
														<c:if test="${ searchValue ne null }">
															<c:param name="searchValue" value="${ searchValue }" />
														</c:if>
													</c:url>
													<li class="page-item"><a class="page-link"
														href="${ end }" aria-label="Next"> <i
															class="fas fa-angle-double-right"></i>
													</a></li>
												</c:if>
											</ul>
										</nav>
									</div>
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
		window.name = 'pAdParent';
		
		// 개인 주소록 추가 팝업
		function addContact() {
			open('pAdbookInsertView.ab', '개인 주소록 추가', 'width=600px, height=650px, top=50px, left=400px');
		}
		
		// 개인 주소록 수정 팝업
		$('#pAdbookTable tbody td:not(:first-child)').on('click', function(){
			var adNo = $(this).parent().children().eq(0).children().eq(0).val();
			
			open('pAdbookUpdateView.ab?adNo=' + adNo, '개인 주소록 수정', 'width=600px, height=650px, top=50px, left=400px');
		});
		
		
		// 개인 주소록 삭제
		var pAdCheckbox = $('input[name=pAdCheckbox]');
		
		function deleteContact() {
			var bool = confirm('정말 삭제하시겠습니까?');
			
			if(bool){
				// 삭제할 연락처의 adNo를 담을 배열
				var checkArr = [];
				$('input[name=pAdCheckbox]:checked').each(function(i){
					checkArr.push($(this).val());
				});

				location.href="pAdbookDelete.ab?checked=" + checkArr;
			}
		}
		
		// 체크박스 전체 선택
		var pAd = document.getElementsByName('pAdCheckbox');
		var all = document.getElementById('checkbox-all');
		var count = 0;
		
		function clickpAd(pAd){
			if(pAd.checked == true){
				count++;
			} else {
				count--;
			}
			
			if(count == 10){
				all.checked = true;
			} else {
				all.checked = false;
			}
		}
		
		function clickAll(){
			if(all.checked == true){
				for(var i = 0; i < pAd.length; i++){
					pAd[i].checked = true;
					count = 10;
				}
			} else {
				for(var i = 0; i < pAd.length; i++){
					pAd[i].checked = false;
					count = 0;
				}
			}
		}
	</script>
</body>
</html>