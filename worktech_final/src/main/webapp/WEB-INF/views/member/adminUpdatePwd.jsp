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
	<title>관리자 비밀번호 변경</title>
</head>

<body>
	<c:import url="../common/headerAdmin.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>관리자 비밀번호 변경</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="#">사원관리</a>
					</div>
					<div class="breadcrumb-item">관리자 비밀번호 변경</div>
				</div>
			</div>
			
			
			<div class="section-body">
				<h2 class="section-title">${ name } 비밀번호 변경</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
							<div class="card-body">
								
								 <div class="card card-primary">
						              <div class="card-header"><h4>비밀번호 변경</h4></div>
									  
						              <div class="card-body">
						                <form action="adminPwd.me" method="POST">
							                  <div class="form-group">
							                  	<!-- 관리자 사번 -->
										  		 <input type="hidden" id="mNo" value="${ mNo }" >		  
										  		                 
							                  	 <label for="password">현재 비밀번호</label>
							                     <input type="password" class="form-control" data-indicator="pwindicator" id="pwd" name="pwd" tabindex="2" required>
							                 	 <div id="pwindicator" class="pwindicator">
							                      	<div class="bar"></div>
							                      	<div class="label"></div>
							                    </div>
							                  </div>
							
							                  <div class="form-group">
							                    <label for="password">새로운 비밀번호</label>
							                     <input type="password" class="form-control pwstrength" data-indicator="pwindicator" id="pwd1" name="newPwd" tabindex="2" required>
							                 	 <div id="pwindicator" class="pwindicator">
							                      <div class="bar"></div>
							                      <div class="label"></div>
							                    </div>
							                  </div>
							
							                  <div class="form-group">
							                    <label for="password-confirm">비밀번호 확인</label>
							                    <input type="password" class="form-control pwstrength" tabindex="2" id="pwd2" name="newPwd" required>
							                 	
							                 	<span class="valid-feedback">비밀번호가 일치합니다.</span>
						                     	<span class="invalid-feedback">비밀번호가 일치하지 않습니다.</span>
						                     	<input type="hidden" id="idDuplicateCheck" value='0'>
							                 
							                  </div>
							
							                  <div class="form-group">
							                    <button type="submit" class="btn btn-primary btn-lg btn-block" tabindex="4" id="updatebtn">수정하기</button>
							                  </div>
						                </form>
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
	/*------------------------------ 새로운 비밀번호 일치 확인 ------------------------------*/
	
	$("#pwd2").focusout(function(){
		var pwd1=$("#pwd1").val(); 
		var pwd2=$("#pwd2").val(); 
		
		if(pwd1 != "" || pwd2 != ""){ 
			if(pwd1 == pwd2){ 
				$('.valid-feedback').show(); 
				$('.invalid-feedback').hide(); 
				$('#idDuplicateCheck').val(1);
				$("input[name=newPwd]").attr("class", 'form-control is-valid');
			}else{ 
				$('.valid-feedback').hide(); 
				$('.invalid-feedback').show(); 
				$('#idDuplicateCheck').val(0);
				$("input[name=newPwd]").attr("class", 'form-control is-invalid');
			} 
		} 
	}); 
	
	/*------------------------------ 전송 ------------------------------*/
	$('#updatebtn').click(function(){
		var pwd = $("#pwd").val(); // 이전 비밀번호
		var pwd1=$("#pwd1").val(); // 새로운 비밀번호
		var pwd2=$("#pwd2").val(); // 비밀번호 확인
		
		if(pwd1 != "" || pwd2 != ""){ 
			if(pwd1 == pwd2){ 
				return true;
			}else{ 
				alert("비밀번호가 일치하지 않습니다.");
				$('#pwd2').val('');
				$("#pwd2").focus();
				return false;
			} 
		} else {
			alert("변경할 비밀번호를 입력해주세요");
			return false;
		}
		
	});


</script>

</body>

</html>