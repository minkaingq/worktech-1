<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<style>
 	table { text-align : center; } 

/* 	span.guide{display: none; font-size: 12px; top: 12px; right: 10px;} */
/* 	span.ok{color: green;} */
/* 	span.error{color: red;} */
	

</style>

<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>관리자 사원 등록</title>
</head>

<body>
	<c:import url="../common/headerAdmin.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
			
			
				<h1>사원 등록</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="mList.me">사원 관리</a>
					</div>
					<div class="breadcrumb-item">사원 등록</div>
				</div>
			</div>
			
			<!-- 관리자 : 사원 등록 -->
			<div class="section-body">
				<h2 class="section-title">사원 등록</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
						
							<div class="card-body">
								<form action="minsert.me" method="post" id="joinForm">
				                    <div class="form-group">
				                    	<label>사번</label>
				                     	<input type="text" id="mNo" name="mNo" class="form-control" required placeholder="숫자 6자리를 입력해주세요">
				                     	<!-- 아이디 중복확인 ajax -->
				                     	<span class="valid-feedback">사용할 수 있는 사번입니다.</span>
				                     	<span class="invalid-feedback">사용할 수 없는 사번입니다.</span>
				                     	<input type="hidden" id="idDuplicateCheck" value='0'>
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>이름</label>
				                     	<input type="text" id="name" name="name" class="form-control" required>
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>회사</label>
				                     	<input type="text" id="company" name="company" class="form-control" value="KH" readonly style="background : white;">
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>부서</label>
				                      <select class="form-control" name="dNo" id="dNo" required="true">
				                        <option value="">부서를 선택해주세요</option>
				                        <!-- dNo : 부서번호 | dName : 부서이름 -->
				                        <c:forEach var="d" items="${ list }">
					                        <option value="${ d.dNo }">${ d.dName }</option>
<!-- 					                        <option value="2">영업부</option> -->
				                        </c:forEach>
				                      </select>
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>직급</label>
				                      <select class="form-control" name="jobGrade" id="jobGrade" required>
				                        <option value="">직급을 선택해주세요</option>
				                        <option value="사원" >사원</option>
										<option value="주임">주임</option>
										<option value="대리">대리</option>
										<option value="과장">과장</option>
										<option value="부장">부장</option>
										<option value="팀장">팀장</option>
										<option value="사장">사장</option>
				                      </select>
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>사내 Email</label>
				                      <input type="email" class="form-control" id="email" name="email" required>
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>개인 Email</label>
				                      <input type="email" class="form-control" id="mEmail" name="mEmail" required>
				                    </div>
	
				                  <div class="card-footer text-right">
				                  	<button class="btn btn-primary mr-1" onclick="return validate();">등록</button>
<!-- 				                  	<button class="btn btn-primary mr-1" type="submit">등록</button> -->
				                    <button class="btn btn-secondary" type="reset">취소</button>
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



	<script type="text/javascript">
	
	  /* 1. 아이디 검사 */

        // 중복확인
    	  $('#mNo').on('keyup', function(){
			var mNo = $(this).val().trim();
			var regExpId = /^[0-9]{6}$/; // 사번 유효성 검사  /^[\d]{6};
			
			
			if(mNo.length < 6){
				// 가이드가 안보이도록 숨기기
				$('.valid-feedback').hide();
				$('.invalid-feedback').hide();
				$('#idDubplicateCheck').val(0);
				
				return; 
			}
			
			// 정규표현식 유효성 검사
			if(!regExpId.test(document.getElementById("mNo").value)){

				alert("사번은 숫자 6자리만 입력이 가능합니다.");
				$('.invalid-feedback').show();
				$('.valid-feedback').hide();
				$('#idDuplicateCheck').val(0);
				document.getElementById("mNo").focus();

				return false;//전송(submit)이 되지 않게 한다.
			} else {
				$.ajax({
					url : 'dupId.me',
					data : {mNo:mNo},
					success : function(data){
						console.log(data);
						data = data.trim();
						if(data == 'NoDup'){
							$('.invalid-feedback').hide();
							$('.valid-feedback').show();
							$('#idDuplicateCheck').val(1);
							$("input[name=mNo]").attr("class", 'form-control is-valid');
						} else if(data == 'Dup'){
							$('.invalid-feedback').show();
							$('.valid-feedback').hide();
							$('#idDuplicateCheck').val(0);
							$("input[name=mNo]").attr("class", 'form-control is-invalid');
						}
						
					},
					error : function(data){
						console.log(data);
					}
				});
			
			}
		});
    	  
      
		function validate(){
			if($('#idDuplicateCheck').val() == 0 ){
				alert('사용가능한 사번을 입력해주세요');
				$('#mNo').focus();
				return false;
			} else {
				$('#joinForm').submit();
			}
			
			
		}
	
	</script>

</body>

</html>