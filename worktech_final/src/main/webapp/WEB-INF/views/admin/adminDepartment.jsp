<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<style> 
	
	h4.section-title {
		top: -13px;
		display: inline;
	}
	
	h4.section-title:hover{
		cursor: pointer;
		color: #67d4ef;
	}
	
/* 	table{text-align : center;} */
	
	 table {
            border-collapse: collapse;
            background: white;
        }

        table th {
            border-bottom: 1px solid #e3e3e3;
            text-align: center;
            font-size: 15px;
        }

        table td {
            border-bottom: 1px solid #e3e3e3;
            text-align: center;
            font-size: 15px;
        }
	
/* 	#depTree{ float: right; text-align: right;} */
	
	#a{ float: right; }
</style>
<head>
	<script src="resources/js/jquery-3.6.0.min.js"></script>
	
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
	<title>관리자 부서 관리</title>
</head>
<body>
	<c:import url="../common/headerAdmin.jsp" />

	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>부서 관리</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active">
						<a href="dList.ad">부서 관리</a>
					</div>
					<div class="breadcrumb-item">부서 목록</div>
				</div>
			</div>
			
			
			<div class="section-body">
<!-- 			<h2 class="section-title">부서 목록</h2> -->
	            <div class="row">

					<!-- 부서 목록 -->
					<div class="col-12">
<!-- 					<div class="col-12 col-md-6 col-lg-6"> -->
						<div class="card">
							<div class="card-header">
                                <c:url var="adDepList" value="dList.ad"/>
								<h4 style="font-size: 20px;" class="section-title" onclick="location.href='${ adDepList }'">부서 목록</h4>
	                    		
<!--                                 <h4 style="font-size: 20px;">부서 목록</h4> -->
                                
                                <div class="card-header-form">
                                	<a href="#" onclick="treeOpen();" class="btn btn-icon icon-left btn-primary" id="depTree"><i class="fas fa-users"> 부서 구조</i></a>     
                            	</div>
                            </div>
		                  	<div class="card-body">
		                  		
		                    	<div class="table-responsive">
<!-- 									<table class="table table-striped"> -->
									<table class="table" id="tb">
										<thead>
										<tr>
											<th style="width: 100px; height: 45px;">부서 코드</th>
											<th style="width: 150px;">부서 명</th>
						                    <th style="width: 150px;">구성원 수</th>
						                    <th style="width: 150px;">등록 일자</th>
						                    <th style="width: 150px;">관리</th>
										</tr>
										</thead>
						                <tbody>
							                <c:forEach var="d" items="${ list }" varStatus="vs">	
								            	<tr>
													<td style="height: 45px;">${ d.dNo }</td>
													<td>${ d.dName }</td>
		 						                	<td>${ countList[vs.index] }</td>
		 						                	<td>${ d.dDate }</td>
								                	<td>
									                	<button class="btn btn-secondary">삭제</button>
								                	</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
		                        	<!-- 버튼 -->
			                        <div class="card-footer text-right">								
										<button class="btn btn-primary mr-1" onclick="location.href='addDep.ad'">부서 등록</button>   	
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
	
	<script type="text/javascript">
	/*------------------------------ 부서 삭제 ------------------------------*/
	$('.btn-secondary').click(function(){
		var dNo = $(this).parent().parent().children().eq(0).text();
		console.log(dNo);
		var bool = confirm("정말 삭제하시겠습니까?");
			
		if(bool){
			$.ajax({
				url : 'deleteDep.ad',
				data : {dNo:dNo},
				success : function(data){
					console.log(data);
					location.reload();
				},
				error : function(data){
					console.log(data);
				}
			});
		}
	});

	/*------------------------------ 트리구조 페이지로 이동 ------------------------------*/
	
	function treeOpen() {
		window.open('deTree.ad', '부서 구조', 'width=500px, height=500px, resizable=no, toolbar=1');
	}

  </script>

</body>
</html>