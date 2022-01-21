<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no"
	name="viewport">
<title>개인 주소록 수정</title>

<!-- General CSS Files -->
<link rel="stylesheet"
	href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="resources/dist/assets/modules/fontawesome/css/all.min.css">

<!-- CSS Libraries -->

<!-- Template CSS -->
<link rel="stylesheet" href="resources/dist/assets/css/style.css">
<link rel="stylesheet" href="resources/dist/assets/css/components.css">
<!-- Start GA -->
<script async
	src="https://www.googletagmanager.com/gtag/js?id=UA-94034622-3"></script>
<script>
	window.dataLayer = window.dataLayer || [];
	function gtag() {
		dataLayer.push(arguments);
	}
	gtag('js', new Date());

	gtag('config', 'UA-94034622-3');
</script>
<!-- /END GA -->
</head>
<style>
.card {
	margin: 20px;
}

.dupDiv{
	visibility: hidden;
}

#dupMsg{
	font-weight: bold;
	color: #FF1616;
}

.required{
		color: #FF1616;
}
</style>
<body>
	<div class="card">
		<div class="card-header">
			<h4>개인 주소록 수정</h4>
		</div>
		<div class="card-body">
		<form name="form">
			<div class="form-group row">
				<label for="name" class="col-sm-3 col-form-label">이름 <span class="required">*</span></label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="adName" value="${ a.adName }">
				</div>
			</div>
			<div class="form-group row">
				<label for="phone" class="col-sm-3 col-form-label">전화번호 <span class="required">*</span></label>
				<div class="col-sm-9">
					<input type="tel" class="form-control" name="adPhone" value="${ a.adPhone }" onblur="checkDup()">
				</div>
			</div>
			<div class="form-group row">
				<label for="inputPassword3" class="col-sm-3 col-form-label">이메일 <span class="required">*</span></label>
				<div class="col-sm-9">
					<input type="email" class="form-control" name="adEmail" value="${ a.adEmail }" onblur="checkDup()">
				</div>
			</div>
			<div class="form-group row">
				<label for="company" class="col-sm-3 col-form-label">회사</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="adCompany" value="${ a.adCompany }">
				</div>
			</div>
			<div class="form-group row">
				<label for="department" class="col-sm-3 col-form-label">부서</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="adDept" value="${ a.adDept }">
				</div>
			</div>
			<div class="form-group row">
				<label for="job" class="col-sm-3 col-form-label">직책</label>
				<div class="col-sm-9">
					<input type="text" class="form-control" name="adJob" value="${ a.adJob }">
				</div>
			</div>
			<div class="text-center dupDiv">
					<span id="dupMsg">전화번호 또는 이메일이 일치하는 연락처가 이미 존재합니다</span>
				</div>
			<div class="card-footer text-center">
				<button class="btn btn-primary" type="button" onclick="updatepAd();">저장</button>
				<button class="btn btn-danger" type="button" onclick="closePopup()">취소</button>
			</div>
			<input type="hidden" name="adNo" value="${ a.adNo }">
		</form>
		</div>
	</div>

	<!-- General JS Scripts -->
	<script src="resources/dist/assets/modules/jquery.min.js"></script>
	<script src="resources/dist/assets/modules/popper.js"></script>
	<script src="resources/dist/assets/modules/tooltip.js"></script>
	<script
		src="resources/dist/assets/modules/bootstrap/js/bootstrap.min.js"></script>
	<script
		src="resources/dist/assets/modules/nicescroll/jquery.nicescroll.min.js"></script>
	<script src="resources/dist/assets/modules/moment.min.js"></script>
	<script src="resources/dist/assets/js/stisla.js"></script>

	<!-- JS Libraies -->

	<!-- Page Specific JS File -->

	<!-- Template JS File -->
	<script src="resources/dist/assets/js/scripts.js"></script>
	<script src="resources/dist/assets/js/custom.js"></script>
	
	<script>
		var filled = false;
		var adNo = "${ a.adNo }";
		
		function closePopup() {
			window.close();
		}
		
		// 전화번호/이메일 중복 여부 확인
		function checkDup() {
			var adPhone = $('input[name=adPhone]').val();
			var adEmail = $('input[name=adEmail]').val();
			
			$.ajax({
				url: 'checkpAdDup.ab',
				data: {phone:adPhone, email:adEmail, adNo:adNo},
				success: function(data){
					console.log(data);
					
					if(data > 0){
						$('.dupDiv').css('visibility', 'visible');
					} else {
						$('.dupDiv').css('visibility', 'hidden');
					}
				},
				error: function(data){
					console.log(data);
				}
			});
		}
		
		function updatepAd(){
			var adName = $('input[name=adName]').val();
			var adPhone = $('input[name=adPhone]').val();
			var adEmail = $('input[name=adEmail]').val();
			
			if(adName != '' && adPhone != '' && adEmail != ''){
				filled = true;
			} else {
				alert('이름, 전화번호, 이메일을 입력하세요');
			}
			
			// 전화번호/이메일 중복 여부 확인
			$.ajax({
				url: 'checkpAdDup.ab',
				data: {phone:adPhone, email:adEmail, adNo:adNo},
				success: function(data){
					console.log(data);
					
					if(data > 0){
						$('.dupDiv').css('visibility', 'visible');
					} else {
						$('.dupDiv').css('visibility', 'hidden');

						document.form.target = "pAdParent";
						document.form.action = "pAdbookUpdate.ab";
						document.form.method = "POST";
						document.form.submit();
						
						self.close();
					}
				},
				error: function(data){
					console.log(data);
				}
			});
		}
	</script>
</body>
</html>