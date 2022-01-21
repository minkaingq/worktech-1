<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>

<style>
 	table { text-align : center; width : 100%;} 
 	#titleImgArea{width:100px; height: 100px;}
</style>

<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- daum 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>사원 정보 수정</title>
</head>

<body>
	<c:import url="../common/headerAdmin.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>사원 정보 수정</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="mList.me">사원 관리</a>
					</div>
					<div class="breadcrumb-item">사원 정보 수정</div>
				</div>
			</div>
			
			
			<div class="section-body">
				<h2 class="section-title">김대리의 정보</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-body">
							
								<form action="AdminUdateMem.me" method="post" id="updateMemberForm">
				                    
				                    <!-- 사번&page hidden -->
				                    <input type="hidden" id="mNo" name="mNo" value="${ member.mNo }">
				                    <input type="hidden" id="page" name="page" value="${ page }">
				                    
				                    
				                    <!-- 프로필 이미지 영역 -->
					                 <!-- Basic avatar examples : https://picturepan2.github.io/spectre/components/avatars.html-->
						             <figure class="avatar avatar-xl" id="titleImgArea">
										<!-- pUrl이 비어있을때는 기본이미지 출력 -->
										<c:choose>									
		   									<c:when test="${ member.profile.pReName eq null }" >
		   										<img id="titleImg" src="resources/dist/assets/img/avatar/avatar-3.png" >
		   									</c:when>
		   									<c:otherwise>
		   										<img id="titleImg" src="resources/profileUploadFiles/${ member.profile.pReName }" >
		   									</c:otherwise>
										</c:choose>
									</figure>
									<br><br><br>
	
				                    <div class="form-group">
				                    	<label>사번</label>
				                     	<input type="text" id="id" name="m_no"  class="form-control" readonly style="background : white;" placeholder="${ member.mNo }">
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>이름</label>
				                     	<input type="text" id="name" name="name" class="form-control" style="background : white;" value="${ member.name }">
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>회사</label>
				                     	<input type="text" id="company" name="company" class="form-control" value="KH" readonly style="background : white;">
				                    </div>
				                    
				                    <div class="form-group">
				                       <label>부서</label>
				                      <select class="form-control" name="dNo" id="dNo" required="true">
				                        <option value="">부서를 선택해주세요</option>
				                        <c:forEach var="d" items="${ list }">
					                        <option value="${ d.dNo }" <c:if test="${ member.dName == d.dName }">selected</c:if> >${ d.dName }</option>
				                        </c:forEach>
				                      </select>
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>직급</label>
				                      <select class="form-control" name="jobGrade" id="jobGrade" required>
				                        <option value="">직급을 선택해주세요</option>
				                        <option value="사원" <c:if test="${ member.jobGrade == '사원' }">selected</c:if> >사원</option>
										<option value="주임" <c:if test="${ member.jobGrade == '주임' }">selected</c:if> >주임</option>
										<option value="대리" <c:if test="${ member.jobGrade == '대리' }">selected</c:if> >대리</option>
										<option value="과장" <c:if test="${ member.jobGrade == '과장' }">selected</c:if> >과장</option>
										<option value="부장" <c:if test="${ member.jobGrade == '부장' }">selected</c:if> >부장</option>
										<option value="팀장" <c:if test="${ member.jobGrade == '팀장' }">selected</c:if> >팀장</option>
										<option value="사장" <c:if test="${ member.jobGrade == '사장' }">selected</c:if> >사장</option>
				                      </select>
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>사내 Email</label>
				                      <input type="email" class="form-control" id="email" name="email" style="background : white;" placeholder="${ member.email }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>개인 Email</label>
				                      <input type="email" class="form-control" id="mEmail" name="mEmail" readonly style="background : white;" placeholder="${ member.mEmail }">
				                    </div>
				                  
				                  <div class="card-footer text-right">
				                    <button class="btn btn-primary mr-1" type="submit">수정하기</button>
				                    <button class="btn btn-danger" onclick="location.href='${mdetail.me}'">취소</button>
				                  </div>
								
								</form>
							</div>
							
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
	<c:import url="../common/footer.jsp" />

</body>

</html>