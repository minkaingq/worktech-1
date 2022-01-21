<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>결재 상세보기</title>

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
                <h1>전자 결재</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active">
                        <a href="#">전자 결재</a>
                    </div>
                    <div class="breadcrumb-item">결재 상세보기</div>
                </div>
            </div>

            <div class="section-body">
                <h2 class="section-title">결재 정보</h2>
                <div class="row">
                    <div class="col-12 col-md-12 col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group">
                                    <label>결재 제목</label>
                                    <input type="text" class="form-control" id="bTitle" disabled value="${ app.appTitle }">
                                </div>
                                <div class="form-group half-col left-item">
                                    <label>기안자</label>
                                    <input type="text" class="form-control" disabled value="${ app.mName } ${ app.jobGrade }">
                                </div>
                                <div class="form-group half-col">
                                    <label>결재 작성일</label>
                                    <input type="date" class="form-control" disabled value="${ app.appDate }">
                                </div>
                                <div class="form-group half-col left-item">
                                    <label>결재자</label>
                                    <input type="text" class="form-control" id="appLiMember" disabled value="${ app.appLiMemberName }">
                                </div>
                                <div class="form-group half-col">
                                    <label>수신참조</label>
                                    <input type="text" class="form-control" id="appRefMember" disabled value="${ app.appRefMemberName }">
                                </div>                                                                
                                <div class="form-group">
                                    <label>작성 내용</label>
                                    <div class="inputData">
                                    	<c:out value="${ app.appContent }" escapeXml="false" />
                                    </div>
                                </div>
                            <div class="form-group">
                               		<label>문서 양식</label>
                                	<div class="input-group-icon mt-10 filebox inputFile">
                                		<c:if test="${ !empty app.fileList.get(0).getFormName() }">
		                                    <c:forEach var="form" items="${ app.fileList }">
		                                    	<i class="fas fa-save"></i>
		                                    	<a href="resources/buploadFiles/${ form.getFormRname() }" download="${ form.getFormName() }">
													${ form.getFormName() }
												</a>
												<br>
											</c:forEach>
										</c:if>
										<c:if test="${ empty app.fileList.get(0).getFormName() }">
											문서 양식이 존재하지 않습니다.
										</c:if>
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer text-right">
                            	
                            	<c:if test="${ (loginUser.mNo eq app.appWriter) || (loginUser.mGrade eq 'ADMIN') }">
		                            <c:url var="appupView" value="appupdateView.ap">
										<c:param name="appNo" value="${ app.appNo }"/>
										<c:param name="page" value="${ page }"/>
									</c:url>
									
	                                <button class="btn btn-primary mr-1" type="button" onclick="location.href='${ appupView }'">수정</button>
	                                
									<form action="approvalDelete.ap" method="post" class="formStyle">
										<input type="hidden" name="appNo" value="${ app.appNo }">
	                                	<button class="btn btn-danger" type="submit" onclick="return deleteApproval();">삭제</button>
	                                </form>
								</c:if>
								
                            	<c:if test="${ (loginUser.mNo eq app.appLiMember)}">
		                            <c:url var="approvalapp" value="approvalApp.ap">
										<c:param name="appNo" value="${ app.appNo }"/>
									</c:url>
									
	                                <button class="btn btn-primary mr-1" type="button" onclick="location.href='${ approvalapp }'">결재 승인</button>
	                                
		                            <c:url var="approvalreturn" value="approvalReturn.ap">
										<c:param name="appNo" value="${ app.appNo }"/>
									</c:url>
									
	                                <button class="btn btn-danger" type="button" onclick="location.href='${ approvalreturn }'">결재 승인</button>
	                                
								</c:if>								
								
                                <button class="btn btn-secondary" type="button" onclick="location.href='${ clist }'">목록으로</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <c:import url="../common/footer.jsp" />
    <script src="resources/dist/assets/modules/summernote/summernote-bs4.js"></script>
    <script src="resources/dist/assets/modules/codemirror/lib/codemirror.js"></script>
    <script src="resources/dist/assets/modules/codemirror/mode/javascript/javascript.js"></script>
    <script src="resources/dist/assets/modules/jquery-selectric/jquery.selectric.min.js"></script>

	<script>
		function deleteApproval() {
			var result = confirm('정말 삭제하시겠습니까?');
			
			if(!result){
				return false;
			}
			
		}
	</script>
</body>
</html>