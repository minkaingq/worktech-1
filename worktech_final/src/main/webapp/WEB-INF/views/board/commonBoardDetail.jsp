<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>일반 게시판 상세</title>

    <!-- CSS Libraries -->
    <link rel="stylesheet" href="resources/dist/assets/modules/summernote/summernote-bs4.css">
    <link rel="stylesheet" href="resources/dist/assets/modules/codemirror/lib/codemirror.css">
    <link rel="stylesheet" href="resources/dist/assets/modules/codemirror/theme/duotone-dark.css">
    <link rel="stylesheet" href="resources/dist/assets/modules/jquery-selectric/selectric.css">

    <style>
        .inputData {
            border: 1px #dff5fa solid;
            padding: 10px;
            border-radius: 5px;
            text-align: left;
            height: 500px;
        }
        
        .inputFile {
            padding: 10px;
            border-radius: 5px;
            text-align: left;
        }

        .half-col {
            display: inline-block;
            width: 49%;
        }

        .left-item {
            margin-right: 19px;
        }

        :disabled,
        input[type="text"]:disabled,
        input[type="date"]:disabled,
        input[type="number"]:disabled {
            background: white;
        }
        
        .formStyle{
        	display: inline-block;
        	margin-right: 10px;
        	margin-left: 5px;
        }

        #replyBox{
        	resize: none;
        }
        
        #rTable{
        	width: 100%;
        	border-collapse: collapse;
        }
        
        #rTable td{
        	padding: 12px;
        	border-top: 1px solid #dff5fa;
        	border-bottom: 1px solid #dff5fa;
        }
        
        i[name='rDeleteBtn']:hover{
        	cursor: pointer;
        }
    </style>
</head>

<body>
    <c:if test="${ loginUser.mGrade eq 'USER' }">
		<c:import url="../common/headerUser.jsp" />
	</c:if>
    <c:if test="${ loginUser.mGrade eq 'ADMIN' }">
    	<c:import url="../common/headerAdmin.jsp" />
    </c:if>
    
    <!-- Main Content -->
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>일반 게시판</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active">
                        <a href="#">게시판</a>
                    </div>
                    <div class="breadcrumb-item">일반 게시판</div>
                </div>
            </div>

            <div class="section-body">
                <h2 class="section-title">일반 게시판 상세</h2>
                <div class="row">
                    <div class="col-12 col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <label>글 제목</label>
                                    <input type="text" class="form-control" id="bTitle" disabled value="[ ${b.categoryName} ] ${ b.bTitle }">
                                </div>
                                <div class="form-group half-col left-item">
                                    <label>작성자</label>
                                    <input type="text" class="form-control" disabled value="${ b.name }">
                                </div>
                                <div class="form-group half-col">
                                    <label>작성일</label>
                                    <input type="date" class="form-control" disabled value="${ b.bDate }">
                                </div>
                                <div class="form-group">
                                    <label>조회수</label>
                                    <input type="number" class="form-control" name="bCount" disabled value="${ b.bCount }">
                                </div>
                                <div class="form-group">
                                    <label>작성 내용</label>
                                    <div class="summernote">
                                    	${ b.bContent }
                                    </div>
                                </div>
                            <div class="form-group">
                               		<label>첨부 파일</label>
                                	<div class="input-group-icon mt-10 filebox inputFile">
                                		<c:if test="${ !empty b.fileList.get(0).getfName() }">
		                                    <c:forEach var="f" items="${ b.fileList }">
		                                    	<i class="fas fa-save"></i>
		                                    	<a href="resources/buploadFiles/${ f.getfRname() }" download="${ f.getfName() }">
													${ f.getfName() }
												</a>
												<br>
											</c:forEach>
										</c:if>
										<c:if test="${ empty b.fileList.get(0).getfName() }">
											첨부파일이 존재하지 않습니다.
										</c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer text-right">
                            	
                            	<c:if test="${ (loginUser.mNo eq b.bWriter) || (loginUser.mGrade eq 'ADMIN') }">
		                            <c:url var="cupView" value="cupdateView.bo">
										<c:param name="bNo" value="${ b.bNo }"/>
										<c:param name="page" value="${ page }"/>
										<c:param name="upd" value="Y"/>
									</c:url>
									
	                                <button class="btn btn-primary mr-1" type="button" onclick="location.href='${ cupView }'">수정</button>
	                                
									<form action="commonDelete.bo" method="post" class="formStyle">
										<input type="hidden" name="bNo" value="${ b.bNo }">
	                                	<button class="btn btn-danger" type="submit" onclick="return deleteCommonBoard();">삭제</button>
	                                </form>
								</c:if>
								
								<c:if test="${ null eq searchCategory }">
									<c:url var="clist" value="commonList.bo">
										<c:if test="${ page ne null }">
											<c:param name="page" value="${ page }"/>
										</c:if>
										<c:if test="${ category ne null }">
											<c:param name="category" value="${ category }"/>
										</c:if>
									</c:url>
								</c:if>
								<c:if test="${ null ne searchCategory }">
									<c:url var="clist" value="searchCommon.bo">
										<c:if test="${ page ne null }">
											<c:param name="page" value="${ page }"/>
										</c:if>
										<c:if test="${ category ne null }">
											<c:param name="category" value="${ category }"/>
										</c:if>
										<c:param name="searchCategory" value="${ searchCategory }"/>
										<c:param name="searchValue" value="${ searchValue }"/>
									</c:url>
								</c:if>
                                <button class="btn btn-secondary" type="button" onclick="location.href='${ clist }'">목록으로</button>
                            </div>
                            <div class="card-footer form-group">
                            	<label id="rCount"></label>
                           		<table id="rTable" width="100%"></table>
                           		<br>
                            	<div class="text-right">
	                            	<textarea class="form-control" id="replyBox"></textarea><br>
	                            	<button class="btn btn-primary mr-1" id="replyBtn">등록</button>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <c:import url="../common/footer.jsp" />
    <script src="resources/dist/assets/modules/summernote/summernote-detail.js"></script>
    <script src="resources/dist/assets/modules/codemirror/lib/codemirror.js"></script>
    <script src="resources/dist/assets/modules/codemirror/mode/javascript/javascript.js"></script>
    <script src="resources/dist/assets/modules/jquery-selectric/jquery.selectric.min.js"></script>

	<script>
		// 게시글 삭제 확인
		function deleteCommonBoard() {
			var result = confirm('정말 삭제하시겠습니까?');
			
			if(!result){
				return false;
			}
			
		}
		
		// 댓글 등록 ajax
		$('#replyBtn').on('click', function(){
			var rContent = $('#replyBox').val();
			var rWriter = '${ loginUser.mNo}'; // 댓글 작성자의 사번
			var bNo = '${ b.bNo }';
			
			var rName = '${ loginUser.name }'; // 알림으로 보내기 위한 댓글 작성자의 이름
			var bWriter = '${ b.bWriter }';
			var bTitle = '${ b.bTitle}';
			
			$.ajax({
				url: 'addCommonReply.bo',
				data: {rName:rWriter, rContent:rContent, bNo:bNo},
				success: function(data){
					console.log(data);
					
					getReplyList();
					$('#replyBox').val('');
					
					let socketMsg = "cReply," + bWriter + "," + data + "," + rName + "," + bNo + "," + bTitle;
					socket.send(socketMsg);
				},
				error: function(data){
					console.log(data);
				}
			});
		});
		
		// 댓글 목록 불러오기 ajax
		function getReplyList() {
			var bNo = ${b.bNo};
			
			$.ajax({
				url: 'commonReplyList.bo',
				data: {bNo:bNo},
				dataType: 'json',
				success: function(data){
					var $rTable  = $('#rTable');
					$rTable.html('');
					
					$('#rCount').text('댓글 (' + data.length + '개)');
					
					var $tr;
					var $name;
					var $content;
					var $date;
					
					if(data.length > 0){
						for(var i in data){
							$tr = $('<tr>');
							$rNo = $('<td>').html('<input type="hidden" name="rNo" value="' + data[i].rNo + '">');
							$name = $('<td width="15%" style="text-align: center;">').html('<b>' + data[i].name + '</b>');
							$content = $('<td width="65%">').text(data[i].rContent);
							$date = $('<td width="15%" style="text-align: center;">').text(data[i].rDate);
							$deleteBtn = $('<td width="5%">').html('<i class="fas fa-times" name="rDeleteBtn"></i>');
							
							$tr.append($rNo);
							$tr.append($name);
							$tr.append($content);
							$tr.append($date);
							$tr.append($deleteBtn);
							
							$rTable.append($tr);
						}
					} else {
						$tr = $('<tr>');
						$content = $('<td colspan="3" style="border: none;">').text("댓글이 없습니다.");
						
						$tr.append($content);
						$rTable.append($tr);
					}
				},
				error: function(data){
					console.log(data);
				}
			});
		}
		
		// 화면 로드 시 댓글 목록 불러오기 ajax
		$(function(){
			getReplyList();
			
// 			setInterval(function(){
// 				getReplyList();
// 			}, 7000);
		});
		
		var bNo = '${ b.bNo }';
		
		// 댓글 삭제 ajax
		$(document).on("click", "i[name='rDeleteBtn']", function(){
			var rNo = $(this).parent().parent().children().eq(0).children().val();
			
			$.ajax({
				url: 'deleteCommonReply.bo',
				data: {bNo:bNo, rNo:rNo},
				success: function(data){
					if(data.trim() == 'success'){
						getReplyList();
					}
				},
				error: function(data){
					console.log(data);
				}
			});
		});
	</script>
</body>
</html>