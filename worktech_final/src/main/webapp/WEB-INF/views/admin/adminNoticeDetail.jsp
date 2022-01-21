<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>공지사항 상세</title>

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
                <h1>공지사항 게시판</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item">게시판 관리</div>
                    <div class="breadcrumb-item active"><a href="noticeList.ad">공지사항 게시판</a></div>
                </div>
            </div>

            <div class="section-body">
                <h2 class="section-title">공지사항 상세</h2>
                <div class="row">
                    <div class="col-12 col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <label>글 제목</label>
                                    <input type="text" class="form-control" id="bTitle" disabled
                                        value="${ b.bTitle }">
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
                                    <textarea class="summernote" >
                                    	${ b.bContent }
                                    </textarea>
                                </div>
                            <div class="form-group">
                               		<label>첨부 파일</label>
                                	<div class="input-group-icon mt-10 filebox inputFile">
                                		<c:if test="${ !empty b.fileList.get(0).getfName() }">
		                                    <c:forEach var="f" items="${ b.fileList }">
		                                    	<i class="fas fa-save"></i>
		                                    	<a href="resources/buploadFiles/${ f.fRname }" download="${ f.fName }">
													${ f.fName }
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
	                            <c:if test="${ loginUser.mGrade eq 'ADMIN' }">
		                            <c:url var="nupView" value="nupdateView.ad">
										<c:param name="bNo" value="${ b.bNo }"/>
										<c:param name="page" value="${ page }"/>
										<c:param name="upd" value="Y"/>
									</c:url>
	                                <button class="btn btn-primary mr-1" type="button" onclick="location.href='${ nupView }'">수정</button>
	                                
									<form action="noticeDelete.ad" method="post" class="formStyle">
										<input type="hidden" name="bNo" value="${ b.bNo }">
	                                	<button class="btn btn-danger" type="submit" onclick="return deleteNotice();">삭제</button>
	                                </form>
	                            </c:if>
                                <c:if test="${ !empty searchValue }">
	                                <c:url var="nlist" value="searchNotice.ad">
	                                	<c:param name="page" value="${ page }"/>
	                                	<c:param name="searchCondition" value="${ searchCondition }"/>
										<c:param name="searchValue" value="${ searchValue }"/>
										<c:param name="boardLimit" value="${ boardLimit }"/>
									</c:url>
                                </c:if>
                                <c:if test="${ empty searchValue }">
	                                <c:url var="nlist" value="noticeList.ad">
										<c:param name="page" value="${ page }"/>
										<c:param name="boardLimit" value="${ boardLimit }"/>
									</c:url>
                                </c:if>
                                <button class="btn btn-secondary" type="button" onclick="location.href='${ nlist }'">목록으로</button>
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
		$(function() {
			var critical = '${ b.bCritical }';
			if(critical.trim() == "IMPORTANT"){
				$('#bTitle').css({'color':'red', 'font-weight':'900'});
			}
		});
		
		function deleteNotice() {
			var result = confirm('정말 삭제하시겠습니까?');
			
			if(!result){
				return false;
			}
			
		}
	</script>
</body>

</html>