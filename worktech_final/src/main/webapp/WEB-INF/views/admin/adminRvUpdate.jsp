<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>관리자 예약 자산 수정</title>
	<style>
        .inputData {
            border: 1px #dff5fa solid;
            padding: 10px;
            border-radius: 5px;
            text-align: left;
        }
	
		.section-header{
			padding: 20px, 35px;
			margin: -10px, -30px, 30px;
		}
		
		:disabled,
        input[type="text"]:disabled,
        input[type="date"]:disabled,
        input[type="number"]:disabled {
            background: white;
        }
        
        .formStyle{
        	display: inline-block;
        	margin-right: 10px;
        	margin-left: 5px;
        }
	</style>
</head>

<body>
	<c:import url="../common/headerAdmin.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>예약 관리</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item">예약 관리</div>
                    <div class="breadcrumb-item active"><a href="rvProductList.ad">예약 자산 목록</a></div>
				</div>
			</div>
			<c:url var="rvupdate" value="rvupdate.ad">
				<c:param name="page" value="${ page }"/>
			</c:url>

			<div class="section-body">
				<h2 class="section-title">예약 자산 수정</h2>
				<form action="${ rvupdate }" method="post">
					<div class="row">
						<div class="col-12 col-md-12 col-lg-12">
							<div class="card">
									<div class="card-body">
										<input type="hidden" name="pdNo" value="${ rp.pdNo }">
										<div class="form-group">
											<label>예약 자산 카테고리</label> <input type="text" name="pdCategory" class="form-control" value="${ rp.pdCategory }">
										</div>
										<div class="form-group">
											<label>예약 자산명</label> <input type="text" name="pdName" class="form-control" value="${ rp.pdName }">
										</div>
										<div class="form-group">
											<label>추가 일자</label> <input type="date" name="pdDate" class="form-control" id="addDate" value="${ rp.pdDate }">
										</div>
										<div class="form-group">
											<label class="d-block">사용 범위</label>
											<div class="form-check">
												<input class="form-check-input" type="checkbox" id="all" value="100">
												<label class="form-check-label" for="all">전체</label>
											</div>
											<c:set var="i" value="1"/>
											<c:forEach var="d" items="${ list }">
												<div class="form-check">
													<input class="form-check-input" type="checkbox" id="defaultCheck${ i }" name="department" value="${ d.dNo }"
														<c:forEach var="rr" items="${ rp.rvRange }">
															<c:if test="${ rr.pdDNo eq d.dNo }">
																checked
															</c:if>
														</c:forEach>
													>
													<label class="form-check-label" for="defaultCheck${ i }">${ d.dName }</label>
												</div>
												<c:set var="i" value="${ i + 1 }"/>
											</c:forEach>
										</div>
										<div class="form-group">
											<label>예약 가능 수량</label> <input type="number" name="pdCount" min="1" class="form-control" value="${ rp.pdCount }">
										</div>
									</div>
								<div class="card-footer text-right">
	                                <button class="btn btn-primary mr-1" type="submit">수정</button>
	                                <c:url var="rvdetail" value="rvpdetail.ad">
										<c:param name="pdNo" value="${ rp.pdNo }"/>
										<c:param name="page" value="${ page }"/>
									</c:url>
	                                <button class="btn btn-danger" type="button" onclick="location.href='${ rvdetail }'">취소</button>
	                            </div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</section>
	</div>
	<c:import url="../common/footer.jsp" />

	<script>
		// 전체 선택
		$(document).ready(function() {
			$("#all").click(function() {
				if($("#all").is(":checked")) $("input[name=department]").prop("checked", true);
				else $("input[name=department]").prop("checked", false);
			});
		
			$("input[name=department]").click(function() {
				var total = $("input[name=department]").length;
				var checked = $("input[name=department]:checked").length;
		
				if(total != checked) $("#all").prop("checked", false);
				else $("#all").prop("checked", true); 
			});
		});
	</script>
</body>

</html>