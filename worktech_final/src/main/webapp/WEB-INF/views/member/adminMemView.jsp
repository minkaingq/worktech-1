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
	<title>사원정보 확인</title>
</head>

<body>
	<c:import url="../common/headerAdmin.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>사원 정보 확인</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="mList.me">사원관리</a>
					</div>
					<div class="breadcrumb-item">사원 정보 확인</div>
				</div>
			</div>
			
			
			<div class="section-body">
				<h2 class="section-title">${ member.name }의 정보</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-body">
								<form action="adminUpdateMem.me" method="post" id="detailForm">
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
				                    
				                    <!-- 사번&page hidden -->
				                    <input type="hidden" id="mNo" name="mNo" value="${ member.mNo }">
				                    <input type="hidden" id="page" name="page" value="${ page }">
				                    
				                    <div class="form-group">
				                    	<label>사번</label>
				                     	<input type="text" id="m_no" name="m_no"  class="form-control" readonly style="background : white;" value="${ member.mNo }">
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>이름</label>
				                     	<input type="text" id="name" name="name" class="form-control" readonly style="background : white;" value="${ member.name }">
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>회사</label>
				                     	<input type="text" id="company" name="company" class="form-control" value="KH" readonly style="background : white;">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>부서</label>
				                      <input type="text" id="d_name" name="d_name" class="form-control" readonly style="background : white;" value="${ member.dName }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>직급</label>
				                      <input type="text" id="job_grade" name="job_grade" class="form-control" readonly style="background : white;" value="${ member.jobGrade }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>사내 Email</label>
				                      <input type="email" class="form-control" id="email" name="email" readonly style="background : white;" value="${ member.email }">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>개인 Email</label>
				                      <input type="email" class="form-control" id="mEmail" name="mEmail" readonly style="background : white;" value="${ member.mEmail }">
				                    </div>
				                       
				                  <div class="card-footer text-right">
<!-- 				                    <button class="btn btn-primary mr-1" type="button" id="updatePwd">비밀정보 변경</button> -->
				                    <button class="btn btn-primary mr-1" type="submit" >사원 정보 변경</button>
				                    <button class="btn btn-danger" type="button" id="delete">사원 삭제</button>&nbsp;
				                  	<button class="btn btn-secondary" type="button" onclick="location.href='mList.me'">목록으로 돌아가기</button>
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
	/*------------------------------ 사원 삭제 ------------------------------*/
	$('#delete').click(function(){
		var bool = confirm("정말 삭제하시겠습니까?");
		if(bool){
			$('#detailForm').attr('action', 'delete.me');
			$('#detailForm').submit();
		} else {
			location.reload;
		}
	});
		
	/*------------------------------ 관리자 : 사원 비밀번호 변경 ------------------------------*/
	$('#updatePwd').click(function(){
		
		$('#detailForm').attr('action', 'updateMemPwdView.me');
		$('#detailForm').submit();
	
	});
</script>
	
</body>

</html>