<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>새 결재 진행</title>
	
	<!-- jstree -->
	<link rel="stylesheet" href="resources/dist/themes/default/style.min.css" />
	
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
        }
        	
		.section-header{
			padding: 20px, 35px;
			margin: -10px, -30px, 30px;
		}
		
		.container {
		  margin-top: 20px;
		}
		
		:disabled,
        input[type="text"]:disabled,
        input[type="date"]:disabled,
        input[type="number"]:disabled {
            background: #fdfdff;
        }		
		
	    .filebox .upload-name {
            display: inline-block;
            height: 40px;
            padding: 0 45px;
            vertical-align: middle;
            border: 1px solid #dff5fa;
            width: 86%;
            color: #999999;
            border-radius: 3px;
            background-color: #ffffff00;
        }
        
        .filebox label {
            color: #fff;
        }
        
        .filebox input[type="file"] {
            position: absolute;
            width: 0;
            height: 0;
            padding: 0;
            overflow: hidden;
            border: 0;
        }
            
	</style>
</head>

<body>
<c:import url="../common/headerUser.jsp" />
	<!-- Main Content -->
	<div class="main-content">
		<section class="section">
			<div class="section-header">
				<h1>결재 작성</h1>
				<div class="section-header-breadcrumb">
					<div class="breadcrumb-item active"><a href="#">전자 결재</a></div>
					<div class="breadcrumb-item">새 결재 작성</div>
				</div>
    		</div>
			
			<div class="section-body">
				<form action="appinsert.ap" method="post" enctype="Multipart/form-data">
				<div class="row">
					<div class="col-12 col-md-12 col-lg-12">
						<div class="card">
						<div class="card-header">
							<h4>새 결재 작성</h4>
						</div>
						
						<div class="card-body">
							<div class="form-group row mb-4">
								<label class="col-form-label text-md-right col-12 col-md-3 col-lg-3">문서 제목</label>
								<div class="col-sm-12 col-md-7">
									<input type="text" class="form-control" name="appTitle" value="">
								</div>
                    		</div>
							<div class="form-group row mb-4">
								<label class="col-form-label text-md-right col-12 col-md-3 col-lg-3">결재 작성자</label>
								<div class="col-sm-12 col-md-7">
		                            <input type="text" class="form-control" disabled value="${ loginUser.name } ${loginUser.jobGrade} ">
		                            <input type="hidden" name="appWriter" value="${ loginUser.mNo }">
	                            </div>
                    		</div>       
                    		             		
	                    	<div class="form-group row mb-4">
	                      		<label class="col-form-label text-md-right col-12 col-md-3 col-lg-3">문서 첨부</label>
	                      		<div class="col-sm-12 col-md-7 ">
	                        		<input type="text" class="upload-name form-control" id="uploadName" value="" disabled>
	                      		</div>
	                      		<div class="filebox">
	                      		<label class="btn btn-info" for="file">문서선택</label>
	                      		<input type="file" name="uploadAppFile" id="file" class="ex_file" multiple="multiple" accept=".xlsx"> 
	                      		</div>
	                    	</div>   
	                    	    	
	                    	<div class="form-group row mb-4">
	                      		<label class="col-form-label text-md-right col-12 col-md-3 col-lg-3">결재선</label>
	                      		<div class="col-sm-12 col-md-7">
	                      			<input type="text" class="form-control" id="appLiMemberName" name="appLiMemberName">
	                       			<input type="hidden" class="form-control" id="appLiMember" name="appLiMember">
	                     		</div>
	                     		<button type="button" class="btn btn-info" data-toggle="modal" data-target="#appLine">찾기</button>
	                    	</div>
	                    	<div class="form-group row mb-4">
	                      		<label class="col-form-label text-md-right col-12 col-md-3 col-lg-3">수신참조</label>
	                      		<div class="col-sm-12 col-md-7">
	                      			<input type="text" class="form-control" id="appRefMemberName" name="appRefMemberName">
	                       			<input type="hidden" class="form-control" id="appRefMember" name="appRefMember">
	                     		</div>
	                     		<button type="button" class="btn btn-info" data-toggle="modal" data-target="#appLine2">찾기</button>
	                    	</div>
							<div class="col-sm-12 col-md-12">
								<textarea name="appContent" id="summernote" class="summernote" style="display: none;"></textarea>
								<div class="note-editor note-frame card">
								<div class="note-dropzone">  
									<div class="note-dropzone-message"></div>
								</div>
								<div class="note-toolbar-wrapper" style="height: 73px;">
									<div class="note-toolbar card-header" style="position: relative; top: 0px; width: 100%;">
										<div class="note-btn-group btn-group note-style">
											<div class="note-btn-group btn-group">
												<button type="button" class="note-btn btn btn-light btn-sm dropdown-toggle" tabindex="-1" data-toggle="dropdown" title="" data-original-title="Style">
													<i class="note-icon-magic"></i>
												</button>
												<div class="dropdown-menu dropdown-style">
													<a class="dropdown-item" href="#" data-value="p"><p>Normal</p></a>
													<a class="dropdown-item" href="#" data-value="blockquote"><blockquote class="blockquote">Blockquote</blockquote></a>
													<a class="dropdown-item" href="#" data-value="pre"><pre>Code</pre></a>
													<a class="dropdown-item" href="#" data-value="h1"><h1>Header 1</h1></a>
													<a class="dropdown-item" href="#" data-value="h2"><h2>Header 2</h2></a>
													<a class="dropdown-item" href="#" data-value="h3"><h3>Header 3</h3></a>
													<a class="dropdown-item" href="#" data-value="h4"><h4>Header 4</h4></a>
													<a class="dropdown-item" href="#" data-value="h5"><h5>Header 5</h5></a>
													<a class="dropdown-item" href="#" data-value="h6"><h6>Header 6</h6></a>
												</div>
											</div>
										</div>
										<div class="note-btn-group btn-group note-font">
											<button type="button" class="note-btn btn btn-light btn-sm note-btn-bold" tabindex="-1" title="" data-original-title="Bold (CTRL+B)"><i class="note-icon-bold"></i></button>
											<button type="button" class="note-btn btn btn-light btn-sm note-btn-underline" tabindex="-1" title="" data-original-title="Underline (CTRL+U)"><i class="note-icon-underline"></i></button>
											<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Remove Font Style (CTRL+\)"><i class="note-icon-eraser"></i></button>
										</div>
										<div class="note-btn-group btn-group note-fontname">
											<div class="note-btn-group btn-group">
												<button type="button" class="note-btn btn btn-light btn-sm dropdown-toggle" tabindex="-1" data-toggle="dropdown" title="" data-original-title="Font Family">
													<span class="note-current-fontname" style="font-family: &quot;Segoe UI&quot;;">Segoe UI</span>
												</button>
												<div class="dropdown-menu note-check dropdown-fontname">
													<a class="dropdown-item" href="#" data-value="Arial"><i class="note-icon-menu-check"></i> <span style="font-family: 'Arial'">Arial</span></a>
													<a class="dropdown-item" href="#" data-value="Arial Black"><i class="note-icon-menu-check"></i> <span style="font-family: 'Arial Black'">Arial Black</span></a>
													<a class="dropdown-item" href="#" data-value="Comic Sans MS"><i class="note-icon-menu-check"></i> <span style="font-family: 'Comic Sans MS'">Comic Sans MS</span></a>
													<a class="dropdown-item" href="#" data-value="Courier New"><i class="note-icon-menu-check"></i> <span style="font-family: 'Courier New'">Courier New</span></a>
													<a class="dropdown-item" href="#" data-value="Helvetica"><i class="note-icon-menu-check"></i> <span style="font-family: 'Helvetica'">Helvetica</span></a>
													<a class="dropdown-item" href="#" data-value="Impact"><i class="note-icon-menu-check"></i> <span style="font-family: 'Impact'">Impact</span></a>
													<a class="dropdown-item" href="#" data-value="Tahoma"><i class="note-icon-menu-check"></i> <span style="font-family: 'Tahoma'">Tahoma</span></a>
													<a class="dropdown-item" href="#" data-value="Times New Roman"><i class="note-icon-menu-check"></i> <span style="font-family: 'Times New Roman'">Times New Roman</span></a>
													<a class="dropdown-item" href="#" data-value="Verdana"><i class="note-icon-menu-check"></i> <span style="font-family: 'Verdana'">Verdana</span></a>
													<a class="dropdown-item checked" href="#" data-value="Segoe UI"><i class="note-icon-menu-check"></i> <span style="font-family: 'Segoe UI'">Segoe UI</span></a>
													<a class="dropdown-item" href="#" data-value="arial"><i class="note-icon-menu-check"></i> <span style="font-family: 'arial'">arial</span></a>
												</div>
											</div>
										</div>
										<div class="note-btn-group btn-group note-color">
											<div class="note-btn-group btn-group note-color">
												<button type="button" class="note-btn btn btn-light btn-sm note-current-color-button" tabindex="-1" title="" data-original-title="Recent Color" data-backcolor="#FFFF00"><i class="note-icon-font note-recent-color" style="background-color: rgb(255, 255, 0);"></i></button>
												<button type="button" class="note-btn btn btn-light btn-sm dropdown-toggle" tabindex="-1" data-toggle="dropdown" title="" data-original-title="More Color"></button>
													<div class="dropdown-menu">
														<div class="note-palette">  
															<div class="note-palette-title">Background Color</div>
															<div>    
																<button type="button" class="note-color-reset btn btn-light" data-event="backColor" data-value="inherit">Transparent    </button>  
															</div>  
															<div class="note-holder" data-event="backColor">
																<div class="note-color-palette">
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#000000" data-event="backColor" data-value="#000000" title="" data-toggle="button" tabindex="-1" data-original-title="#000000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#424242" data-event="backColor" data-value="#424242" title="" data-toggle="button" tabindex="-1" data-original-title="#424242"></button>
																		<button type="button" class="note-color-btn" style="background-color:#636363" data-event="backColor" data-value="#636363" title="" data-toggle="button" tabindex="-1" data-original-title="#636363"></button>
																		<button type="button" class="note-color-btn" style="background-color:#9C9C94" data-event="backColor" data-value="#9C9C94" title="" data-toggle="button" tabindex="-1" data-original-title="#9C9C94"></button>
																		<button type="button" class="note-color-btn" style="background-color:#CEC6CE" data-event="backColor" data-value="#CEC6CE" title="" data-toggle="button" tabindex="-1" data-original-title="#CEC6CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#EFEFEF" data-event="backColor" data-value="#EFEFEF" title="" data-toggle="button" tabindex="-1" data-original-title="#EFEFEF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#F7F7F7" data-event="backColor" data-value="#F7F7F7" title="" data-toggle="button" tabindex="-1" data-original-title="#F7F7F7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFFFFF" data-event="backColor" data-value="#FFFFFF" title="" data-toggle="button" tabindex="-1" data-original-title="#FFFFFF"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#FF0000" data-event="backColor" data-value="#FF0000" title="" data-toggle="button" tabindex="-1" data-original-title="#FF0000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FF9C00" data-event="backColor" data-value="#FF9C00" title="" data-toggle="button" tabindex="-1" data-original-title="#FF9C00"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFFF00" data-event="backColor" data-value="#FFFF00" title="" data-toggle="button" tabindex="-1" data-original-title="#FFFF00"></button>
																		<button type="button" class="note-color-btn" style="background-color:#00FF00" data-event="backColor" data-value="#00FF00" title="" data-toggle="button" tabindex="-1" data-original-title="#00FF00"></button>
																		<button type="button" class="note-color-btn" style="background-color:#00FFFF" data-event="backColor" data-value="#00FFFF" title="" data-toggle="button" tabindex="-1" data-original-title="#00FFFF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#0000FF" data-event="backColor" data-value="#0000FF" title="" data-toggle="button" tabindex="-1" data-original-title="#0000FF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#9C00FF" data-event="backColor" data-value="#9C00FF" title="" data-toggle="button" tabindex="-1" data-original-title="#9C00FF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FF00FF" data-event="backColor" data-value="#FF00FF" title="" data-toggle="button" tabindex="-1" data-original-title="#FF00FF"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#F7C6CE" data-event="backColor" data-value="#F7C6CE" title="" data-toggle="button" tabindex="-1" data-original-title="#F7C6CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFE7CE" data-event="backColor" data-value="#FFE7CE" title="" data-toggle="button" tabindex="-1" data-original-title="#FFE7CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFEFC6" data-event="backColor" data-value="#FFEFC6" title="" data-toggle="button" tabindex="-1" data-original-title="#FFEFC6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#D6EFD6" data-event="backColor" data-value="#D6EFD6" title="" data-toggle="button" tabindex="-1" data-original-title="#D6EFD6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#CEDEE7" data-event="backColor" data-value="#CEDEE7" title="" data-toggle="button" tabindex="-1" data-original-title="#CEDEE7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#CEE7F7" data-event="backColor" data-value="#CEE7F7" title="" data-toggle="button" tabindex="-1" data-original-title="#CEE7F7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#D6D6E7" data-event="backColor" data-value="#D6D6E7" title="" data-toggle="button" tabindex="-1" data-original-title="#D6D6E7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#E7D6DE" data-event="backColor" data-value="#E7D6DE" title="" data-toggle="button" tabindex="-1" data-original-title="#E7D6DE"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#E79C9C" data-event="backColor" data-value="#E79C9C" title="" data-toggle="button" tabindex="-1" data-original-title="#E79C9C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFC69C" data-event="backColor" data-value="#FFC69C" title="" data-toggle="button" tabindex="-1" data-original-title="#FFC69C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFE79C" data-event="backColor" data-value="#FFE79C" title="" data-toggle="button" tabindex="-1" data-original-title="#FFE79C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#B5D6A5" data-event="backColor" data-value="#B5D6A5" title="" data-toggle="button" tabindex="-1" data-original-title="#B5D6A5"></button>
																		<button type="button" class="note-color-btn" style="background-color:#A5C6CE" data-event="backColor" data-value="#A5C6CE" title="" data-toggle="button" tabindex="-1" data-original-title="#A5C6CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#9CC6EF" data-event="backColor" data-value="#9CC6EF" title="" data-toggle="button" tabindex="-1" data-original-title="#9CC6EF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#B5A5D6" data-event="backColor" data-value="#B5A5D6" title="" data-toggle="button" tabindex="-1" data-original-title="#B5A5D6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#D6A5BD" data-event="backColor" data-value="#D6A5BD" title="" data-toggle="button" tabindex="-1" data-original-title="#D6A5BD"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#E76363" data-event="backColor" data-value="#E76363" title="" data-toggle="button" tabindex="-1" data-original-title="#E76363"></button>
																		<button type="button" class="note-color-btn" style="background-color:#F7AD6B" data-event="backColor" data-value="#F7AD6B" title="" data-toggle="button" tabindex="-1" data-original-title="#F7AD6B"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFD663" data-event="backColor" data-value="#FFD663" title="" data-toggle="button" tabindex="-1" data-original-title="#FFD663"></button>
																		<button type="button" class="note-color-btn" style="background-color:#94BD7B" data-event="backColor" data-value="#94BD7B" title="" data-toggle="button" tabindex="-1" data-original-title="#94BD7B"></button>
																		<button type="button" class="note-color-btn" style="background-color:#73A5AD" data-event="backColor" data-value="#73A5AD" title="" data-toggle="button" tabindex="-1" data-original-title="#73A5AD"></button>
																		<button type="button" class="note-color-btn" style="background-color:#6BADDE" data-event="backColor" data-value="#6BADDE" title="" data-toggle="button" tabindex="-1" data-original-title="#6BADDE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#8C7BC6" data-event="backColor" data-value="#8C7BC6" title="" data-toggle="button" tabindex="-1" data-original-title="#8C7BC6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#C67BA5" data-event="backColor" data-value="#C67BA5" title="" data-toggle="button" tabindex="-1" data-original-title="#C67BA5"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#CE0000" data-event="backColor" data-value="#CE0000" title="" data-toggle="button" tabindex="-1" data-original-title="#CE0000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#E79439" data-event="backColor" data-value="#E79439" title="" data-toggle="button" tabindex="-1" data-original-title="#E79439"></button>
																		<button type="button" class="note-color-btn" style="background-color:#EFC631" data-event="backColor" data-value="#EFC631" title="" data-toggle="button" tabindex="-1" data-original-title="#EFC631"></button>
																		<button type="button" class="note-color-btn" style="background-color:#6BA54A" data-event="backColor" data-value="#6BA54A" title="" data-toggle="button" tabindex="-1" data-original-title="#6BA54A"></button>
																		<button type="button" class="note-color-btn" style="background-color:#4A7B8C" data-event="backColor" data-value="#4A7B8C" title="" data-toggle="button" tabindex="-1" data-original-title="#4A7B8C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#3984C6" data-event="backColor" data-value="#3984C6" title="" data-toggle="button" tabindex="-1" data-original-title="#3984C6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#634AA5" data-event="backColor" data-value="#634AA5" title="" data-toggle="button" tabindex="-1" data-original-title="#634AA5"></button>
																		<button type="button" class="note-color-btn" style="background-color:#A54A7B" data-event="backColor" data-value="#A54A7B" title="" data-toggle="button" tabindex="-1" data-original-title="#A54A7B"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#9C0000" data-event="backColor" data-value="#9C0000" title="" data-toggle="button" tabindex="-1" data-original-title="#9C0000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#B56308" data-event="backColor" data-value="#B56308" title="" data-toggle="button" tabindex="-1" data-original-title="#B56308"></button>
																		<button type="button" class="note-color-btn" style="background-color:#BD9400" data-event="backColor" data-value="#BD9400" title="" data-toggle="button" tabindex="-1" data-original-title="#BD9400"></button>
																		<button type="button" class="note-color-btn" style="background-color:#397B21" data-event="backColor" data-value="#397B21" title="" data-toggle="button" tabindex="-1" data-original-title="#397B21"></button>
																		<button type="button" class="note-color-btn" style="background-color:#104A5A" data-event="backColor" data-value="#104A5A" title="" data-toggle="button" tabindex="-1" data-original-title="#104A5A"></button>
																		<button type="button" class="note-color-btn" style="background-color:#085294" data-event="backColor" data-value="#085294" title="" data-toggle="button" tabindex="-1" data-original-title="#085294"></button>
																		<button type="button" class="note-color-btn" style="background-color:#311873" data-event="backColor" data-value="#311873" title="" data-toggle="button" tabindex="-1" data-original-title="#311873"></button>
																		<button type="button" class="note-color-btn" style="background-color:#731842" data-event="backColor" data-value="#731842" title="" data-toggle="button" tabindex="-1" data-original-title="#731842"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#630000" data-event="backColor" data-value="#630000" title="" data-toggle="button" tabindex="-1" data-original-title="#630000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#7B3900" data-event="backColor" data-value="#7B3900" title="" data-toggle="button" tabindex="-1" data-original-title="#7B3900"></button>
																		<button type="button" class="note-color-btn" style="background-color:#846300" data-event="backColor" data-value="#846300" title="" data-toggle="button" tabindex="-1" data-original-title="#846300"></button>
																		<button type="button" class="note-color-btn" style="background-color:#295218" data-event="backColor" data-value="#295218" title="" data-toggle="button" tabindex="-1" data-original-title="#295218"></button>
																		<button type="button" class="note-color-btn" style="background-color:#083139" data-event="backColor" data-value="#083139" title="" data-toggle="button" tabindex="-1" data-original-title="#083139"></button>
																		<button type="button" class="note-color-btn" style="background-color:#003163" data-event="backColor" data-value="#003163" title="" data-toggle="button" tabindex="-1" data-original-title="#003163"></button>
																		<button type="button" class="note-color-btn" style="background-color:#21104A" data-event="backColor" data-value="#21104A" title="" data-toggle="button" tabindex="-1" data-original-title="#21104A"></button>
																		<button type="button" class="note-color-btn" style="background-color:#4A1031" data-event="backColor" data-value="#4A1031" title="" data-toggle="button" tabindex="-1" data-original-title="#4A1031"></button>
																	</div>
																</div>
															</div>
														</div>
														<div class="note-palette">  
															<div class="note-palette-title">Foreground Color</div>  
															<div>    
																<button type="button" class="note-color-reset btn btn-light" data-event="removeFormat" data-value="foreColor">Reset to default    </button>
															</div>  
															<div class="note-holder" data-event="foreColor">
																<div class="note-color-palette">
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#000000" data-event="foreColor" data-value="#000000" title="" data-toggle="button" tabindex="-1" data-original-title="#000000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#424242" data-event="foreColor" data-value="#424242" title="" data-toggle="button" tabindex="-1" data-original-title="#424242"></button>
																		<button type="button" class="note-color-btn" style="background-color:#636363" data-event="foreColor" data-value="#636363" title="" data-toggle="button" tabindex="-1" data-original-title="#636363"></button>
																		<button type="button" class="note-color-btn" style="background-color:#9C9C94" data-event="foreColor" data-value="#9C9C94" title="" data-toggle="button" tabindex="-1" data-original-title="#9C9C94"></button>
																		<button type="button" class="note-color-btn" style="background-color:#CEC6CE" data-event="foreColor" data-value="#CEC6CE" title="" data-toggle="button" tabindex="-1" data-original-title="#CEC6CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#EFEFEF" data-event="foreColor" data-value="#EFEFEF" title="" data-toggle="button" tabindex="-1" data-original-title="#EFEFEF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#F7F7F7" data-event="foreColor" data-value="#F7F7F7" title="" data-toggle="button" tabindex="-1" data-original-title="#F7F7F7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFFFFF" data-event="foreColor" data-value="#FFFFFF" title="" data-toggle="button" tabindex="-1" data-original-title="#FFFFFF"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#FF0000" data-event="foreColor" data-value="#FF0000" title="" data-toggle="button" tabindex="-1" data-original-title="#FF0000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FF9C00" data-event="foreColor" data-value="#FF9C00" title="" data-toggle="button" tabindex="-1" data-original-title="#FF9C00"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFFF00" data-event="foreColor" data-value="#FFFF00" title="" data-toggle="button" tabindex="-1" data-original-title="#FFFF00"></button>
																		<button type="button" class="note-color-btn" style="background-color:#00FF00" data-event="foreColor" data-value="#00FF00" title="" data-toggle="button" tabindex="-1" data-original-title="#00FF00"></button>
																		<button type="button" class="note-color-btn" style="background-color:#00FFFF" data-event="foreColor" data-value="#00FFFF" title="" data-toggle="button" tabindex="-1" data-original-title="#00FFFF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#0000FF" data-event="foreColor" data-value="#0000FF" title="" data-toggle="button" tabindex="-1" data-original-title="#0000FF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#9C00FF" data-event="foreColor" data-value="#9C00FF" title="" data-toggle="button" tabindex="-1" data-original-title="#9C00FF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FF00FF" data-event="foreColor" data-value="#FF00FF" title="" data-toggle="button" tabindex="-1" data-original-title="#FF00FF"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#F7C6CE" data-event="foreColor" data-value="#F7C6CE" title="" data-toggle="button" tabindex="-1" data-original-title="#F7C6CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFE7CE" data-event="foreColor" data-value="#FFE7CE" title="" data-toggle="button" tabindex="-1" data-original-title="#FFE7CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFEFC6" data-event="foreColor" data-value="#FFEFC6" title="" data-toggle="button" tabindex="-1" data-original-title="#FFEFC6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#D6EFD6" data-event="foreColor" data-value="#D6EFD6" title="" data-toggle="button" tabindex="-1" data-original-title="#D6EFD6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#CEDEE7" data-event="foreColor" data-value="#CEDEE7" title="" data-toggle="button" tabindex="-1" data-original-title="#CEDEE7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#CEE7F7" data-event="foreColor" data-value="#CEE7F7" title="" data-toggle="button" tabindex="-1" data-original-title="#CEE7F7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#D6D6E7" data-event="foreColor" data-value="#D6D6E7" title="" data-toggle="button" tabindex="-1" data-original-title="#D6D6E7"></button>
																		<button type="button" class="note-color-btn" style="background-color:#E7D6DE" data-event="foreColor" data-value="#E7D6DE" title="" data-toggle="button" tabindex="-1" data-original-title="#E7D6DE"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#E79C9C" data-event="foreColor" data-value="#E79C9C" title="" data-toggle="button" tabindex="-1" data-original-title="#E79C9C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFC69C" data-event="foreColor" data-value="#FFC69C" title="" data-toggle="button" tabindex="-1" data-original-title="#FFC69C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFE79C" data-event="foreColor" data-value="#FFE79C" title="" data-toggle="button" tabindex="-1" data-original-title="#FFE79C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#B5D6A5" data-event="foreColor" data-value="#B5D6A5" title="" data-toggle="button" tabindex="-1" data-original-title="#B5D6A5"></button>
																		<button type="button" class="note-color-btn" style="background-color:#A5C6CE" data-event="foreColor" data-value="#A5C6CE" title="" data-toggle="button" tabindex="-1" data-original-title="#A5C6CE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#9CC6EF" data-event="foreColor" data-value="#9CC6EF" title="" data-toggle="button" tabindex="-1" data-original-title="#9CC6EF"></button>
																		<button type="button" class="note-color-btn" style="background-color:#B5A5D6" data-event="foreColor" data-value="#B5A5D6" title="" data-toggle="button" tabindex="-1" data-original-title="#B5A5D6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#D6A5BD" data-event="foreColor" data-value="#D6A5BD" title="" data-toggle="button" tabindex="-1" data-original-title="#D6A5BD"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#E76363" data-event="foreColor" data-value="#E76363" title="" data-toggle="button" tabindex="-1" data-original-title="#E76363"></button>
																		<button type="button" class="note-color-btn" style="background-color:#F7AD6B" data-event="foreColor" data-value="#F7AD6B" title="" data-toggle="button" tabindex="-1" data-original-title="#F7AD6B"></button>
																		<button type="button" class="note-color-btn" style="background-color:#FFD663" data-event="foreColor" data-value="#FFD663" title="" data-toggle="button" tabindex="-1" data-original-title="#FFD663"></button>
																		<button type="button" class="note-color-btn" style="background-color:#94BD7B" data-event="foreColor" data-value="#94BD7B" title="" data-toggle="button" tabindex="-1" data-original-title="#94BD7B"></button>
																		<button type="button" class="note-color-btn" style="background-color:#73A5AD" data-event="foreColor" data-value="#73A5AD" title="" data-toggle="button" tabindex="-1" data-original-title="#73A5AD"></button>
																		<button type="button" class="note-color-btn" style="background-color:#6BADDE" data-event="foreColor" data-value="#6BADDE" title="" data-toggle="button" tabindex="-1" data-original-title="#6BADDE"></button>
																		<button type="button" class="note-color-btn" style="background-color:#8C7BC6" data-event="foreColor" data-value="#8C7BC6" title="" data-toggle="button" tabindex="-1" data-original-title="#8C7BC6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#C67BA5" data-event="foreColor" data-value="#C67BA5" title="" data-toggle="button" tabindex="-1" data-original-title="#C67BA5"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#CE0000" data-event="foreColor" data-value="#CE0000" title="" data-toggle="button" tabindex="-1" data-original-title="#CE0000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#E79439" data-event="foreColor" data-value="#E79439" title="" data-toggle="button" tabindex="-1" data-original-title="#E79439"></button>
																		<button type="button" class="note-color-btn" style="background-color:#EFC631" data-event="foreColor" data-value="#EFC631" title="" data-toggle="button" tabindex="-1" data-original-title="#EFC631"></button>
																		<button type="button" class="note-color-btn" style="background-color:#6BA54A" data-event="foreColor" data-value="#6BA54A" title="" data-toggle="button" tabindex="-1" data-original-title="#6BA54A"></button>
																		<button type="button" class="note-color-btn" style="background-color:#4A7B8C" data-event="foreColor" data-value="#4A7B8C" title="" data-toggle="button" tabindex="-1" data-original-title="#4A7B8C"></button>
																		<button type="button" class="note-color-btn" style="background-color:#3984C6" data-event="foreColor" data-value="#3984C6" title="" data-toggle="button" tabindex="-1" data-original-title="#3984C6"></button>
																		<button type="button" class="note-color-btn" style="background-color:#634AA5" data-event="foreColor" data-value="#634AA5" title="" data-toggle="button" tabindex="-1" data-original-title="#634AA5"></button>
																		<button type="button" class="note-color-btn" style="background-color:#A54A7B" data-event="foreColor" data-value="#A54A7B" title="" data-toggle="button" tabindex="-1" data-original-title="#A54A7B"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#9C0000" data-event="foreColor" data-value="#9C0000" title="" data-toggle="button" tabindex="-1" data-original-title="#9C0000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#B56308" data-event="foreColor" data-value="#B56308" title="" data-toggle="button" tabindex="-1" data-original-title="#B56308"></button>
																		<button type="button" class="note-color-btn" style="background-color:#BD9400" data-event="foreColor" data-value="#BD9400" title="" data-toggle="button" tabindex="-1" data-original-title="#BD9400"></button>
																		<button type="button" class="note-color-btn" style="background-color:#397B21" data-event="foreColor" data-value="#397B21" title="" data-toggle="button" tabindex="-1" data-original-title="#397B21"></button>
																		<button type="button" class="note-color-btn" style="background-color:#104A5A" data-event="foreColor" data-value="#104A5A" title="" data-toggle="button" tabindex="-1" data-original-title="#104A5A"></button>
																		<button type="button" class="note-color-btn" style="background-color:#085294" data-event="foreColor" data-value="#085294" title="" data-toggle="button" tabindex="-1" data-original-title="#085294"></button>
																		<button type="button" class="note-color-btn" style="background-color:#311873" data-event="foreColor" data-value="#311873" title="" data-toggle="button" tabindex="-1" data-original-title="#311873"></button>
																		<button type="button" class="note-color-btn" style="background-color:#731842" data-event="foreColor" data-value="#731842" title="" data-toggle="button" tabindex="-1" data-original-title="#731842"></button>
																	</div>
																	<div class="note-color-row">
																		<button type="button" class="note-color-btn" style="background-color:#630000" data-event="foreColor" data-value="#630000" title="" data-toggle="button" tabindex="-1" data-original-title="#630000"></button>
																		<button type="button" class="note-color-btn" style="background-color:#7B3900" data-event="foreColor" data-value="#7B3900" title="" data-toggle="button" tabindex="-1" data-original-title="#7B3900"></button>
																		<button type="button" class="note-color-btn" style="background-color:#846300" data-event="foreColor" data-value="#846300" title="" data-toggle="button" tabindex="-1" data-original-title="#846300"></button>
																		<button type="button" class="note-color-btn" style="background-color:#295218" data-event="foreColor" data-value="#295218" title="" data-toggle="button" tabindex="-1" data-original-title="#295218"></button>
																		<button type="button" class="note-color-btn" style="background-color:#083139" data-event="foreColor" data-value="#083139" title="" data-toggle="button" tabindex="-1" data-original-title="#083139"></button>
																		<button type="button" class="note-color-btn" style="background-color:#003163" data-event="foreColor" data-value="#003163" title="" data-toggle="button" tabindex="-1" data-original-title="#003163"></button>
																		<button type="button" class="note-color-btn" style="background-color:#21104A" data-event="foreColor" data-value="#21104A" title="" data-toggle="button" tabindex="-1" data-original-title="#21104A"></button>
																		<button type="button" class="note-color-btn" style="background-color:#4A1031" data-event="foreColor" data-value="#4A1031" title="" data-toggle="button" tabindex="-1" data-original-title="#4A1031"></button>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div class="note-btn-group btn-group note-para">
												<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Unordered list (CTRL+SHIFT+NUM7)"><i class="note-icon-unorderedlist"></i></button>
												<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Ordered list (CTRL+SHIFT+NUM8)"><i class="note-icon-orderedlist"></i></button>
												<div class="note-btn-group btn-group">
													<button type="button" class="note-btn btn btn-light btn-sm dropdown-toggle" tabindex="-1" data-toggle="dropdown" title="" data-original-title="Paragraph"><i class="note-icon-align-left"></i></button>
													<div class="dropdown-menu">
														<div class="note-btn-group btn-group note-align">
															<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Align left (CTRL+SHIFT+L)"><i class="note-icon-align-left"></i></button>
															<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Align center (CTRL+SHIFT+E)"><i class="note-icon-align-center"></i></button>
															<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Align right (CTRL+SHIFT+R)"><i class="note-icon-align-right"></i></button>
															<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Justify full (CTRL+SHIFT+J)"><i class="note-icon-align-justify"></i></button>
														</div>
														<div class="note-btn-group btn-group note-list">
															<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Outdent (CTRL+[)"><i class="note-icon-align-outdent"></i></button>
															<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Indent (CTRL+])"><i class="note-icon-align-indent"></i></button>
														</div>
													</div>
												</div>
											</div>
											<div class="note-btn-group btn-group note-table">
												<div class="note-btn-group btn-group">
													<button type="button" class="note-btn btn btn-light btn-sm dropdown-toggle" tabindex="-1" data-toggle="dropdown" title="" data-original-title="Table"><i class="note-icon-table"></i></button>
													<div class="dropdown-menu note-table">
														<div class="note-dimension-picker">  
															<div class="note-dimension-picker-mousecatcher" data-event="insertTable" data-value="1x1" style="width: 10em; height: 10em;"></div>  
															<div class="note-dimension-picker-highlighted"></div>  
															<div class="note-dimension-picker-unhighlighted"></div>
														</div>
														<div class="note-dimension-display">1 x 1</div>
													</div>
												</div>
											</div>
											<div class="note-btn-group btn-group note-insert">
												<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Link (CTRL+K)"><i class="note-icon-link"></i></button>
												<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Picture"><i class="note-icon-picture"></i></button>
												<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1" title="" data-original-title="Video"><i class="note-icon-video"></i></button>
											</div>
											<div class="note-btn-group btn-group note-view">
												<button type="button" class="note-btn btn btn-light btn-sm btn-fullscreen" tabindex="-1"><i class="note-icon-arrows-alt"></i></button>
												<button type="button" class="note-btn btn btn-light btn-sm btn-codeview" tabindex="-1"><i class="note-icon-code"></i></button>
												<button type="button" class="note-btn btn btn-light btn-sm" tabindex="-1"><i class="note-icon-question"></i></button>
											</div>
										</div>
									</div>
									<div class="note-editing-area">
										<div class="note-handle">
											<div class="note-control-selection">
												<div class="note-control-selection-bg"></div>
												<div class="note-control-holder note-control-nw"></div>
												<div class="note-control-holder note-control-ne"></div>
												<div class="note-control-holder note-control-sw"></div>
												<div class="note-control-sizing note-control-se"></div>
												<div class="note-control-selection-info"></div>
											</div>
										</div>
										<div class="note-editable card-block" contenteditable="true" style="min-height: 250px;"><p><br></p></div>
									</div>
									<div class="note-statusbar" name="appContent">  
										<div class="note-resizebar">    
										<div class="note-icon-bar"></div>    
										<div class="note-icon-bar"></div>    
										<div class="note-icon-bar"></div>  
									</div>
								</div>
							</div>
							</div>
	                     </div>						                    	
	                        <div class="card-footer text-right">
	                        	<button class="btn btn-primary mr-1" type="submit">저장</button>
	                        	<c:url var="clist" value="approvalmain.ap"/>
	                        	<button class="btn btn-danger" type="reset" onclick="location.href='${ clist }'">취소</button>
	                        </div>
                  		</div>                  		
					</div>
				</div>
			</form>
			</div>
		</section> 
	</div>
	
	<c:import url="../common/footer.jsp" />
	
 	<div class="modal fade" id="appLine" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">결재선 지정</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          		</div>
				<div class="modal-body">
					<div class="container">
						<div class="row">
				            <div id="appline-tree" class="well col-sm-3"></div>
			 	            <div id="appline-result" class="col-sm-6">결재자</div> 
		          		</div>
		          	</div>
		        </div>
		        <div class="modal-footer">
		        	<button type="button" class="btn btn-default" data-dismiss="modal" id="save">선택</button>
		          	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		        </div>
			</div>
		</div>
	</div>
	
 	<div class="modal fade" id="appLine2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">결재선 지정</h4>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          		</div>
				<div class="modal-body">
					<div class="container">
						<div class="row">
				            <div id="appline-tree2" class="well col-sm-3"></div>
			 	            <div id="appline-result3" class="col-sm-6">결재자</div> 
		          		</div>
		          	</div>
		        </div>
		        <div class="modal-footer">
		        	<button type="button" class="btn btn-default" data-dismiss="modal" id="save">선택</button>
		          	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		        </div>
			</div>
		</div>
	</div>	
	
  	<!-- jstree -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
	<script src="resources/dist/libs/jquery.js"></script>
	<script src="resources/dist/jstree.min.js"></script>
	
	<!-- JS Libraies -->
	<script src="resources/dist/assets/modules/summernote/summernote-bs4.js"></script>
	<script src="resources/dist/assets/modules/codemirror/lib/codemirror.js"></script>
	<script src="resources/dist/assets/modules/codemirror/mode/javascript/javascript.js"></script>
	<script src="resources/dist/assets/modules/jquery-selectric/jquery.selectric.min.js"></script>	
	
		
	<script>
	
//  결재자 지정
	var jsonData = [
		{
			id  : 100,
			text : "경영지원부",
			state : {
			selected  : false
		},
		children    : [
			{
				id  : 2,
				text : "OOO 팀장",
				icon : "resources/dist/themes/default/member.png",
				state : {
				selected  : false
				},  
			},
			{
				id  : 3,
				text : "XXX 대리",
				icon : "resources/dist/themes/default/member.png",
				state : {
				selected  : false
	        	},  
	      	}
	    ]
		
		}, 
		{
			id: 200,
		    text : "전략기획부",
	    	state : {
	     	selected : false
		},
	    	children : [
				{
					id  : 111111,
					text : "이시우 사원",
					icon : "resources/dist/themes/default/member.png",
					state : {
					selected  : false
					},  
				},
				{
					id  : 222222,
					text : "김도윤 주임",
					icon : "resources/dist/themes/default/member.png",
					state : {
					selected  : false
		        	},  
		      	}
	    	]
		},
		
		{
		    id  : 300,
		    text : "인사부",
		    state : {
			selected  : false
		},
			children    : [
			{
				id  : 6,
		        text : "",
		        state : {
				selected  : false
		        },  
			},
			{
		        id  : 7,
		        text : "Sub Folder 2",
		        state : {
		        selected  : false
		        },  
			}
			]
		}, 
		
		{
			id: 400,
		    text : "기술영업부",
		    state : {
		    selected : false
		},
		    children : [
				{
					id  : 333333,
					text : "조민준 사원",
					icon : "resources/dist/themes/default/member.png",
					state : {
					selected  : false
					},  
				},
				{
					id  : 444444,
					text : "박준우 대리",
					icon : "resources/dist/themes/default/member.png",
					state : {
					selected  : false
		        	},  
		      	}
		    ]
		},
		
		{
			id: 500,
			text : "개발부",
			state : {
			selected : false
		},
			children : []
		},
		{
			id  : 600,
			text : "디자인부",
			state : {
			selected  : false
			},
				children    : [
				{
					id  : 10,
					text : "Sub Folder 1",
					state : {
					selected  : false
					},  
				},
				{
					id  : 11,
					text : "Sub Folder 2",
					state : {
					selected  : false
					},  
				}
				]
		}, 
		
		{
			id: 700,
		    text : "고객관리부",
		    state : {
		    selected : false
		},
		    children : []
		},
		
		{
			id: 800,
			text : "품질관리부",
			state : {
			selected : false
		},
			children : [
				{
					id  : 555555,
					text : "하지호 과장",
					icon : "resources/dist/themes/default/member.png",
					state : {
					selected  : false
					},  
				},
				{
					id  : 666666,
					text : "김지아 부장",
					icon : "resources/dist/themes/default/member.png",
					state : {
					selected  : false
		        	},  
		      	},
				{
					id  : 777777,
					text : "이지유 팀장",
					icon : "resources/dist/themes/default/member.png",
					state : {
					selected  : false
		        	},  
		      	}
			]
		},
		{
			id  : 900,
			text : "미주영업부",
			state : {
			selected  : false
			},
				children    : [
				{
					id  : 16,
					text : "Sub Folder 1",
					state : {
					selected  : false
					},  
				},
				{
					id  : 17,
					text : "Sub Folder 2",
					state : {
					selected  : false
					},  
				}
				]
		}, 
		
	];

	$('#appline-tree')
	  .on('changed.jstree', function (e, data) {
	    var objNode = data.instance.get_node(data.selected);
	    $('#appline-result').html('결재자: <br/><strong>' + objNode.text+'</strong>');
	    $('#appLiMemberName').val(objNode.text);
	    $('input[name=appLiMemberName]').val(objNode.text);
 	    $('input[name=appLiMember]').val(objNode.id); 
	  })
	  .jstree({
	  core: {
	    data: jsonData
	  }
	});
	
	$('#appline-tree2')
	  .on('changed.jstree', function (e, data) {
	    var objNode = data.instance.get_node(data.selected);
	    $('#appline-result3').html('수신/참조자: <br/><strong>' + objNode.text+'</strong>');
	    $('#appRefMemberName').val(objNode.text);
	    $('input[name=appRefMemberName]').val(objNode.text);
 	    $('input[name=appRefMember]').val(objNode.id); 
	  })
	  .jstree({
	  core: {
	    data: jsonData
	  }
	});
	  
    $(function () {
        var now = new Date();
        var year = now.getFullYear();
        var month = now.getMonth() + 1;
        var date = now.getDate();
        $('input[name=bDate]').val(year + '-' + month + '-' + date);
    });	
    
    $("#file").on('change', readInputFile);

    // 파일 업로드
    function readInputFile(e) {
        var fileInput = document.getElementsByClassName("ex_file");
        var name = document.getElementById("uploadName").value;
        var area = document.getElementById("uploadName");

        var sel_files = [];

        sel_files = [];

        var files = e.target.files;
        var fileArr = Array.prototype.slice.call(files);

        fileArr.forEach(function (f) {
            if (files.length < 4) {
                sel_files.push(f);
                var reader = new FileReader();
                reader.readAsDataURL(f);
                area.value = "";

                for (var i = 0; i < fileInput.length; i++) {
                    if (fileInput[i].files.length > 0) {
                        for (var j = 0; j < fileInput[i].files.length; j++) {
                            if (j == 0) {
                                area.value += fileInput[i].files[j].name;
                            } else {
                                area.value += ", " + fileInput[i].files[j].name;
                            }
                        }
                    }
                }
            }
        })
        if (files.length > 4) {
            alert("파일은 최대 3개까지 업로드 가능합니다.");
        }
    }
  </script>
  

 
	
</body>
</html>