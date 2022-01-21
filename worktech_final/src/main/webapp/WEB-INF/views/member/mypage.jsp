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
	<title>나의 정보 수정</title>
</head>

<body>
	<c:import url="../common/headerUser.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>마이페이지</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="${ myPage.me }">마이페이지</a>
					</div>
					<div class="breadcrumb-item">나의 정보 보기</div>
				</div>
			</div>
			
			
			<div class="section-body">
				<h2 class="section-title">${ loginUser.name }의 정보</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-body">
								<form  action="detailMyPage.me" method="post" id="myPageForm">
				                     <!-- 프로필 이미지 영역 -->
					                 <!-- Basic avatar examples : https://picturepan2.github.io/spectre/components/avatars.html-->
						             <figure class="avatar avatar-xl" id="titleImgArea">
										<!-- pUrl이 비어있을때는 기본이미지 출력 -->
										<c:choose>									
		   									<c:when test="${ loginUser.profile.pReName eq null }" >
		   										<img id="titleImg" src="resources/dist/assets/img/avatar/avatar-3.png" >
		   									</c:when>
		   									<c:otherwise>
		   										<img id="titleImg" src="resources/profileUploadFiles/${ loginUser.profile.pReName }" >
		   									</c:otherwise>
										</c:choose>
									</figure>
									<br><br><br>
     
				                    <div class="form-group">
				                    	<label>사번</label>
				                     	<input type="text" id="mNo" name="mNo"  class="form-control" readonly style="background : white;" value="${ loginUser.mNo }">
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>이름</label>
				                     	<input type="text" id="name" name="name" class="form-control" readonly style="background : white;" value="${ loginUser.name }">
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>회사</label>
				                     	<input type="text" id="company" name="company" class="form-control" value="KH" readonly style="background : white;">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>부서</label>
				                      <input type="text" id="dName" name="dName" class="form-control" value="영업부" readonly style="background : white;" value="${ loginUser.dName }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>직급</label>
				                      <input type="text" id="jobGrade" name="jobGrade" class="form-control" value="대리" readonly style="background : white;" value="${ loginUser.jobGrade }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>사내 Email</label>
				                      <input type="email" class="form-control" id="email" name="email" readonly style="background : white;" value="${ loginUser.email }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>개인 Email</label>
				                      <input type="email" class="form-control" id="mEmail" name="mEmail" readonly style="background : white;" value="${ loginUser.mEmail }">
				                    </div>
				                       
				                    
				                    <div class="form-group">
				                      <label>전화번호</label>
				                      <input type="tel" class="form-control" id="phone" name="phone" readonly style="background : white;" value="${ loginUser.phone }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>생년월일</label>
				                      <c:choose>									
		   									<c:when test="${ loginUser.birthDay == '1922-01-01' }" >
		   										<input type="text" class="form-control" id="birthDay" name="birthDay" readonly style="background : white;" value="">
		   									</c:when>
		   									<c:otherwise>
		   										<input type="text" class="form-control" id="birthDay" name="birthDay" readonly style="background : white;" value="${ loginUser.birthDay }">
		   									</c:otherwise>
										</c:choose>
				            		</div>
				                    
				                    
				                    <div class="form-group">
				                      <label>주소</label>
				                       <c:choose>									
		   									<c:when test="${ loginUser.address == '///' }" >
		   										<input type="text" class="form-control" id="address" name="address" readonly style="background : white;" >
				                   
		   									</c:when>
		   									<c:otherwise>
		   										 <input type="text" class="form-control" id="address" name="address" readonly style="background : white;" value="${ loginUser.address }">
		   									</c:otherwise>
										</c:choose>
				                   
				                    </div>
				                   
				                   <div class="card-footer text-right">
				                    <button class="btn btn-primary mr-1" id="updatePwd">비밀번호 변경</button>
				                    <button class="btn btn-primary mr-1" onclick="location.href='detailMyPage.me'">내 정보 변경</button>
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

<script>
	/*------------------------------ 비밀번호 변경 페이지로 이동 ------------------------------*/
	$('#updatePwd').click(function(){
		
		$('#myPageForm').attr('action', 'updatePwdView.me');
		$('#myPageForm').submit();
	
	});
	 
	 
	 
	 
	 
	 
	 
</script>
	
</body>

</html>