<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no"
	name="viewport">
<title>메일 상세보기</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${contextPath}/resources/dist/css/adminlte.min.css">

<style>
.mailSR-info {
	font-size: 14px;
	color: gray;
/* 	vertical-align: middle; */
}

#favorites-icon {
	font-size: 14px;
}

.mail-icon {
	width: 20px;
}

.thispage, .thispage b {
	color: #007bff;
}

.table td, .table th {
	padding: .25rem;
	vertical-align: middle;
}

.table-striped tbody tr:nth-of-type(odd) {
	background-color: rgba(0, 0, 0, 0);
}

.table-hover tbody tr:hover {
	background-color: rgba(0, 0, 0, .075)
}

.table td:nth-child(1) {
	width: 4%;
}

.table td:nth-child(2) {
	width: 8%;
}

.table td:nth-child(3) {
	width: 18%;
}

.table td:nth-child(4) {
	width: 50%;
}

.table td:nth-child(5) {
	text-align: right;
}

.table td:nth-child(6) {
	width: 12%;
	text-align: right;
}

.fa-star {
	margin-right: 8px;
}

.fa-paperclip {
	margin-left: 10px;
}

.mailbox-name a {
	margin-left: 20px;
	text-decoration: none;
}

td {
	height: 35px;
}

.pagination {
	margin-top: 10px;
	margin-bottom: 10px;
}

.mailNo-hidden {
	display: none;
	width: 0px;
}

.mailbox-read-message {
	min-height: 400px;
}

.mailbox-read-info {
  border-bottom: 1px solid rgba(0, 0, 0, 0.125);
  padding: 10px;
}

.mailbox-read-info h3 {
  font-size: 20px;
  margin: 0;
}

.mailbox-read-info h5 {
  margin: 0;
  padding: 5px 0 0;
}

.mailbox-read-info{border-bottom:1px solid rgba(0,0,0,.125);padding:10px}
.mailbox-read-info h3{font-size:20px;margin:0}
.mailbox-read-info h5{margin:0;padding:5px 0 0}
.mailbox-read-time{color:#999;font-size:13px}
.mailbox-read-message{padding:10px}
.mailbox-attachments{padding-left:0;list-style:none}
.mailbox-attachments li{border:1px solid #eee;float:left;margin-bottom:10px;margin-right:10px;width:200px}
.mailbox-attachment-name{color:#666;font-weight:700}
.mailbox-attachment-icon,.mailbox-attachment-info,.mailbox-attachment-size{display:block}
.mailbox-attachment-info{background-color:#f8f9fa;padding:10px}
.mailbox-attachment-size{color:#999;font-size:12px}
</style>

</head>
<body>
	<jsp:include page="../common/headerUser.jsp"></jsp:include>

		<div class="main-content">
			<!-- Content Header (Page header) -->
			<section class="section">
				<div class="section-header">
					<h1>메일읽기</h1>
							<div class="section-header-breadcrumb"></div>
					
				</div>
				<div class="section-header-breadcrumb"></div>
				</div>
			<div class="section-body">
				<h2 class="section-title">메일함</h2>
				<p class="section-lead">메일 삭제, 중요메일 관리를 할 수 있습니다.</p>
				
		</section>
			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3">
						<div class="card">
							<div class="card-header">
								<h3 class="card-title">보관함</h3>
							</div>
							<div class="card-body p-0">
								<ul class="nav nav-pills flex-column">
									<li class="nav-item"><a href="alllist.mail" class="nav-link alllist">
											<i class="fas fa-envelope mail-icon"></i> 전체메일 
											<c:if test="${count != 0 && count ne null}">
												<span class="badge bg-primary float-right"> ${count} </span>
											</c:if>
									</a></li>
									<li class="nav-item active"><a href="receivelist.mail"
										class="nav-link receivelist"> <i class="far fa-envelope-open mail-icon"></i> 받은메일함 </a></li>
									<li class="nav-item"><a id="sendlist-li" href="sendlist.mail" class="nav-link sendlist">
						 			<i class="far fa-paper-plane mail-icon"></i> 보낸메일함 </span></a></li>
									<li class="nav-item"><a id="sendlist-li" href="checkReadTime.mail" class="nav-link sendlist">
						 			<i class="far fa-paper-plane mail-icon"></i> 수신확인 </span></a></li>
						
					
									<li class="nav-item"><a href="templist.mail" class="nav-link templist">
									<i class="far fa-file-alt mail-icon"></i> 임시보관함 </a></li>
									<li class="nav-item"><a href="favoriteslist.mail" class="nav-link favoriteslist"> 
									<i class="far fa-star favorites" id="favorites-icon"></i> 즐겨찾기 </a></li>
									<li class="nav-item"><a href="deletelist.mail" class="deletelist nav-link"> 
									<i class="far fa-trash-alt mail-icon"></i> 휴지통 </a></li>
								</ul>
							</div>
							<!-- /.card-body -->
						</div>
					</div>
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">${mail.etitle }</h3>

									<div class="card-tools">
										<div></div>
									</div>
								</div>
								<!-- /.card-header -->
								<div class="card-body p-0">
									<div class="mailbox-read-info">
										
										<h6>
											보낸 사람 : &lt;${mail.senderName }&gt; ${mail.mNo}@worktech.com
										</h6>
											<h6>
												&nbsp;받는 사람 :
												<c:if test="${mail.receiverName != null }">&lt;${mail.receiverName }&gt;</c:if>
												${mail.receiveEmp} <span
													class="mailbox-read-time float-right">
														<fmt:formatDate pattern="yyyy-MM-dd a HH:mm" value="${mail.sDate }"/>
													</span>
											</h6>
									</div>
									<!-- /.mailbox-read-info -->
									<div class="mailbox-controls with-border text-center">
										<div class="btn-group">
											<input type="hidden">
										</div>
									</div>
									<!-- 이메일 내용 -->
									<div class="mailbox-read-message">${mail.econtent}</div>

								</div>
								<!-- /.card-body -->
								<div class="card-footer bg-white">
									<ul
										class="mailbox-attachments d-flex align-items-stretch clearfix">
										<c:forEach var="mF" items="${mail.mailFileList }">
											<c:if test="${mF.mFileNo != 0}">
												<li><span class="mailbox-attachment-icon"><i
														class="far fa-file-pdf"></i></span>
														
													<div class="mailbox-attachment-info">
														<a href="${contextPath }/resources/mailUploadFiles/${mF.mChangeName}" 
														download="${mF.mOriginalName }"
														class="mailbox-attachment-name"><i
															class="fas fa-paperclip"></i> ${mF.mOriginalName }</a> <span
															class="mailbox-attachment-size clearfix mt-1"> 
<!-- 															<span>1,245KB</span>  -->
															<a 
																href="${contextPath }/resources/mailUploadFiles/${mF.mChangeName}" 
																download="${mF.mOriginalName }"
															class="btn btn-default btn-sm float-right"><i
																class="fas fa-cloud-download-alt"></i></a>
														</span>
													</div></li>
											</c:if>
										</c:forEach>
									</ul>

								</div>
								<!-- /.card-footer -->
								<div class="card-footer">
									<div class="float-right">
										<input type="hidden">
									</div>
									<button onclick="location.href='javascript:history.back();'" type="reset" class="btn btn-default">뒤로가기</button>
								</div>
								<!-- /.card-footer -->
								
								</div>
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		
		<jsp:include page="../common/footer.jsp"></jsp:include>
		



	<!-- Bootstrap 4 -->
	<script src="resources/dist/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="resources/dist/js/adminlte.min.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="resources/dist/js/demo.js"></script>

	
</body>
</html>
