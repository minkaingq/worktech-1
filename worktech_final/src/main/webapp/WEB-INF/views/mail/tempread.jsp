<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메일보내기</title>

<!-- Google Font: Source Sans Pro -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="${contextPath}/resources/dist/css/adminlte.min.css">
<!-- summernote -->
<link rel="stylesheet"
	href="${contextPath}/resources/plugins/summernote/summernote-bs4.min.css">

<style>

.thispage, .thispage b, .thispage i {
	color: #007bff;
}


.mailsubtitle-flex-container {
	display: flex;
	justify-content: space-between;
}

.mailsubtitle-right {
	width: 87%;
}

.mailsubtitle-left {
	height: calc(2.25rem + 2px);
	align-self: center;
}

#chart {
	height: 30px;
	margin-top: 4px;
	align-self: center;
	background-color: rgba(128, 128, 128, 0.11);
	border-color: rgba(0, 0, 0, 0.125);
}

.mail-icon {
	width: 20px;
}

.table-sm {
	/* 	border: 1px; solid; rgb(128, 128, 128); */
	width: 420.875px;
	border-radius: 4px;
	border: 1px solid rgb(222, 226, 230);
}

.table-sm th {
	background-color: rgb(248, 249, 250);
}

.table-sm td {
	align-items: center;
}
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

.ui-autocomplete {
	max-height: 350px;
	overflow-y: auto;
	/* prevent horizontal scrollbar */
	overflow-x: hidden; -->
	border: 10px solid black;
}

.ui-autocomplete {
	position: absolute;
	top: 100%;
	left: 0;
	z-index: 1000;
	float: left;
	display: none;
	padding: 0;
	margin: 0;
	list-style: none;
	background-color: #ffffff;
	border-color: #ccc;
	border-color: rgba(0, 0, 0, 0.2);
	border-style: solid;
	border-width: 10px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	-webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	-moz-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
	-webkit-background-clip: padding-box;
	-moz-background-clip: padding;
	background-clip: padding-box;
	*border-right-width: 2px;
	*border-bottom-width: 2px;
}

.ui-menu-item > a.ui-corner-all {
    display: block;
    clear: both;
    font-weight: normal;
    line-height: 18px;
    color: #555555;
    white-space: nowrap;
    text-decoration: none;
}


.ui-state-hover, .ui-state-active {
    color: #ffffff;
    text-decoration: none;
    border-radius: 0px;
    -webkit-border-radius: 0px;
    -moz-border-radius: 0px;
    background-image: none;
}

.ui-widget.ui-widget-content {
    border: 2px solid #c5c5c5;
    border-radius: 4px;
    width: 433px; !important;
}

.ui-menu-item .ui-menu-item-wrapper.ui-state-active {
	border: 2px solid #007BFF !important; 
    background: #007BFF !important;
    font-weight: bold !important;
    color: #ffffff !important;
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
	<div>
		<jsp:include page="../common/headerUser.jsp"></jsp:include>

		<!-- Content Wrapper. Contains page content -->
		<div class="main-content">
			<section class="section">
				<div class="section-header">
					<div class="row mb-2">
							<h1>메일 임시저장읽기</h1>
							<div class="section-header-breadcrumb"></div>
					</div>
				</div>
			
					
			<div class="section-body">
				<h2 class="section-title">메일함</h2>
				<p class="section-lead">메일 삭제, 중요메일 관리를 할 수 있습니다.</p>
				</section>
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
									<h3 class="card-title">새 메일 쓰기</h3>
								</div>
								<!-- /.card-header -->
								<form method="post" id="form-mailsend"
									enctype="Multipart/form-data">
									<div class="card-body">
										<input type="hidden" value="${loginUser.mNo}"
											name="senderMailId" /> 
<%-- 											<input type="hidden" value="${loginUser.Name}" name=senderName /> --%>
											 <input type="hidden" value="${mail.mailNo}" name=mailNo />

										<div class="mailsubtitle-flex-container">
											<div class="mailsubtitle-left">
												<b>받는 사람</b>
											</div>

											<div class="form-group mailsubtitle-right">
												<input type="email" id="email"
												  	class="form-control mail-subtitle" placeholder="받는 이"
													name="receiveEmp" value="${mail.receiveEmp }">
											</div>
										</div>
										<div class="mailsubtitle-flex-container">
											<div class="mailsubtitle-left">
												<b>제목</b>
											</div>
											<div class="form-group mailsubtitle-right">
												<input class="form-control" placeholder="제목" name="etitle" id="title"
													value="${mail.etitle }">
											</div>
										</div>
										<div class="form-group">
											<textarea id="compose-textarea"
												class="form-control mail-subtitle" name="econtent">${mail.econtent }
					                 	   </textarea>
										</div>
										<div class="form-group">
											<div class="btn btn-default btn-file" id="btn-upload">
												<i class="fas fa-paperclip"> 파일 첨부 <input
													multiple="multiple" id="uploadfileinput" type="file"
													name="uploadFile"></i>
											</div>
										</div>
										<table class="table table-hover table-sm">
											<tr>
												<th colspan=2>첨부된 파일</th>
											</tr>
											<c:forEach var="mF" items="${mail.mailFileList }">
												<c:if test="${!empty mF.mChangeName}">
													<tr>
														<td>${mF.mOriginalName }</td>
														<td><button type="button" id="${mF.mFileNo }"
																class="close">
																<span aria-hidden="true">×</span><span class="sr-only">Close</span>
															</button></td>
													</tr>
												</c:if>
												<c:if test="${empty mF.mChangeName}">
													<tr>
														<td>첨부된 파일이 없습니다.</td>
													</tr>
												</c:if>
											</c:forEach>
										</table>
									</div>
									<!-- /.card-body -->
									<div class="card-footer">
										<div class="float-right">
											<button type="submit" id="tmpInsert-btn"
												class="btn btn-default">
												<i class="fas fa-pencil-alt"></i> 임시 저장
											</button>
											<button type="button" id="sendMail-btn"
												class="btn btn-primary">
												<i class="far fa-envelope"></i> 보내기
											</button>
										</div>
									<button onclick="location.href='javascript:history.back();'" type="reset" class="btn btn-default">
										<i class="fas fa-times"></i> 취소
									</button>
									</div>
								</form>
								<!-- /.card-footer -->
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

	<!-- jQuery -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- Bootstrap 4 -->
	<script
		src="${contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
	<!-- AdminLTE App -->
	<script src="${contextPath}/resources/dist/js/adminlte.min.js"></script>
	<!-- Summernote -->
	<script
		src="${contextPath}/resources/plugins/summernote/summernote-bs4.min.js"></script>
	<script
		src="${contextPath}/resources/plugins/summernote/lang/summernote-ko-KR.js"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="${contextPath}/resources/dist/js/demo.js"></script>
	<!-- Page specific script -->
	<script>
		$(function() {
			//Add text editor
			$('#compose-textarea').summernote({
				lang : "ko-KR",
				height : 400,
			});

			$('.close').click(function() {
				if (!window.confirm("정말 삭제하시겠습니까?")) {
					return;
				}
				var $tagId = $(this).attr('id');
				var $container = $(this).closest('tr');

				$.ajax({ // 파일 삭제
					url : 'fileDeleteAjax.mail',
					data : {
						mFileNo : $tagId
					},
					success : function(data) {
						console.log(data);

						if (data == 'success') {
							$container.hide();
						}
					}
				});
			});
			
			var empEmail;
			// 자동완성
            $("#email").autocomplete({
                source : function( request, response ) {
                     $.ajax({
                            url: 'searchemp.mail',
                            dataType: "json",
                            data: {keyword: $('#email').val()},
                            success: function(data) {
                                //서버에서 json 데이터 response 후 목록에 추가
                                console.log(data)
                                response(
                                    $.map(data, function(item) {    //json[i] 번째 에 있는게 item .
                                        return {
                                            value: item.empName +" (" + item.empPosition +")",    //UI 에서 보여지는 글자, 실제 검색어랑 비교 대상
											test: item.empNo + "@workhome.com"
                                        }
                                    })
                                );
                            }
                       });
                    },    // source 는 자동 완성 대상
                select : function(event, ui) {    //아이템 선택시
					console.log(ui.item.test);
                	console.log($('#email').val());
                	empEmail = ui.item.test;
                    
                },
                focus : function(event, ui) {    
                    return false;//한글 에러 잡기용도로 사용됨
                },
                minLength: 1,// 최소 글자수
                autoFocus: true, //첫번째 항목 자동 포커스 기본값 false
                classes: {    
                    "ui-autocomplete": "highlight"
                },
                close : function(event){    //자동완성창 닫아질때 호출
                	$('#email').val(empEmail);

                    console.log(event);
                }
            }).autocomplete( "instance" )._renderItem = function( ul, item ) {    // UI를 마음대로 변경하는 부분
                  return $( "<li>" )    //기본 tag가 li로 되어 있음 
                  .append("<div>" + item.value + "</div>")    //여기에다가 원하는 모양의 HTML을 만들면 UI가 원하는 모양으로 변함.
                  .appendTo( ul );
           }
		});
		
		
		$('#tmpInsert-btn').on("click", function() {
			$('#form-mailsend').attr("action", "tmpUpdate.mail").submit();
		});

		$('#sendMail-btn').on("click", function() {
			if (validate() != false) {
				$('#form-mailsend').attr("action", "mailInsert.mail").submit();
			}
		});

		function validate() {
			var email = document.getElementById('email').value;
			var title = document.getElementById('title').value;
			var content = document.getElementById('compose-textarea').value;

			var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			if (email == '' || email.length == 0) {
				alert('이메일을 입력해주세요.');
				document.getElementById('email').focus();
				return false;
			} else if (title == '' || title.length == 0) {
				alert('제목을 입력해주세요.');
				document.getElementById('title').focus();
				return false;
			} else if (content == '' || content.length == 0) {
				alert('내용을 입력해주세요.')
				document.getElementById('compose-textarea').focus();
				return false;
			} else if (!regExp.test(email)) {
				alert('올바른 이메일 주소를 입력해주세요.')
				document.getElementById('email').focus();
				return false;
			}
		}
	</script>
</body>
</html>
