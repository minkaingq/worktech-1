<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>관리자 예약 자산 상세</title>
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
                    <div class="breadcrumb-item active"><a href="noticeList.ad">예약 자산 목록</a></div>
				</div>
			</div>

			<div class="section-body">
				<h2 class="section-title">예약 자산 상세</h2>
					<div class="row">
						<div class="col-12 col-md-12 col-lg-12">
							<div class="card">
								<form action="addRvProduct.ad" method="post">
									<div class="card-body">
										<div class="form-group">
											<label>예약 자산 카테고리</label> <input type="text" name="pdCategory" class="form-control" disabled value="${ rp.pdCategory }">
										</div>
										<div class="form-group">
											<label>예약 자산명</label> <input type="text" name="pdName" class="form-control" disabled value="${ rp.pdName }">
										</div>
										<div class="form-group">
											<label>추가 일자</label> <input type="date" name="pdDate" class="form-control" id="addDate" disabled value="${ rp.pdDate }">
										</div>
										<div class="form-group">
											<label class="d-block">사용 범위</label>
											<div class="inputData">
												<c:set var="i" value="0"/>
												<c:forEach var="d" items="${ rp.rvRange }">
													<label class="form-check-label">${ d.dName }<c:if test="${ i ne rp.rvRange.size() - 1 }">,</c:if></label>
													<c:set var="i" value="${ i + 1 }"/>
												</c:forEach>
											</div>
										</div>
										<div class="form-group">
											<label>예약 가능 수량</label> <input type="number" name="pdCount" min="1" class="form-control" disabled value="${ rp.pdCount }">
										</div>
									</div>
								</form>
								<div class="card-footer text-right">
									<c:url var="pdupView" value="rvupdateView.ad">
										<c:param name="pdNo" value="${ rp.pdNo }"/>
										<c:param name="page" value="${ page }"/>
									</c:url>
	                                <button class="btn btn-primary mr-1" type="button" onclick="location.href='${ pdupView }'">수정</button>
	                                
									<form action="rvProductDelete.ad" method="post" class="formStyle">
										<input type="hidden" name="pdNo" value="${ rp.pdNo }">
	                                	<button class="btn btn-danger" type="submit" onclick="return deleteRvProduct();">삭제</button>
	                                </form>
	                                <c:url var="rvplist" value="rvProductList.ad">
										<c:param name="page" value="${ page }"/>
									</c:url>
	                                <button class="btn btn-secondary" type="button" onclick="location.href='${ rvplist }'">목록으로</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	<c:import url="../common/footer.jsp" />

	<script>
		function deleteRvProduct() {
			var result = confirm('정말 삭제하시겠습니까?');
			
			if(!result){
				return false;
			}
			
		}
	</script>
</body>

</html>