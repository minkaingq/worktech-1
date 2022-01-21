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

<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>부서 등록</title>
</head>

<body>
	<c:import url="../common/headerAdmin.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>부서 등록</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="dList.ad">부서 관리</a>
					</div>
					<div class="breadcrumb-item">부서 등록</div>
				</div>
			</div>
			
			
			<div class="section-body">
				<h2 class="section-title">부서 등록</h2>
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
<!-- 							<div class="card-header"> -->
<!--                                 <h4 style="font-size: 20px;">부서 등록</h4> -->
<!--                             </div> -->
							<div class="card-body">
								<form action="dInsert.ad" method="post" id="insertDepForm">
				                    
				                    <div class="form-group">
				                    	<label>부서 이름</label>
				                     	<input type="text" id="dName" name="dName"  class="form-control" required>
				                     	<!-- 부서이름 중복확인 ajax -->
				                     	<span class="valid-feedback">사용할 수 있는 부서 이름입니다.</span>
				                     	<span class="invalid-feedback">사용할 수 없는 부서 이름입니다.</span>
				                     	<input type="hidden" id="idDuplicateCheck" value='0'>
				                    </div>
				                    
				                    <div class="form-group">
				                    	<label>등록 일자</label>
				                     	<input type="date" id="dDate" name="dDate" class="form-control" required>
				                    </div>
				                    
				                    <div class="form-group">
				                      <label>상위 부서</label>
				                      <select class="form-control" name="dParent" id="dParent" required>
				                        <c:forEach var="d" items="${ list }">
					                        <option value="${ d.dNo }">${ d.dName }</option>
				                        </c:forEach>
				                      </select>
				                    </div>
				                    
				                    
				                  <div class="card-footer text-right">
<!-- 				                    <button class="btn btn-primary mr-1" type="submit">등록</button> -->
				                    <button class="btn btn-primary mr-1" onclick="return validate();">등록</button>
				                    <button class="btn btn-danger" type="reset">취소</button>
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
		document.getElementById('dDate').value = new Date().toISOString().substring(0, 10);
		
		
		/*************** 부서 이름 검사 **************/

        // 중복확인
    	  $('#dName').on('keyup', function(){
			var dName = $(this).val().trim();
			
			if(dName.length < 3){
				// 가이드가 안보이도록 숨기기
				$('.valid-feedback').hide();
				$('.invalid-feedback').hide();
				$('#idDubplicateCheck').val(0);
				
				return; 
			}
			
			$.ajax({
				url : 'dupDName.ad',
				data : {dName:dName},
				success : function(data){
					console.log(data);
					data = data.trim();
					if(data == 'NoDup'){
						$('.invalid-feedback').hide();
						$('.valid-feedback').show();
						$('#idDuplicateCheck').val(1);
						$("input[name=dName]").attr("class", 'form-control is-valid');
					} else if(data == 'Dup'){
						$('.invalid-feedback').show();
						$('.valid-feedback').hide();
						$('#idDuplicateCheck').val(0);
						$("input[name=dName]").attr("class", 'form-control is-invalid');
					}
					
				},
				error : function(data){
					console.log(data);
				}
			});
		});
    	  
      
		function validate(){
			if($('#idDuplicateCheck').val() == 0 ){
				alert('사용가능한 부서 이름을 입력해주세요');
				$('#dName').focus();
				return false;
			} else {
				$('#insertDepForm').submit();
			}

		}
		
	</script>
</body>

</html>