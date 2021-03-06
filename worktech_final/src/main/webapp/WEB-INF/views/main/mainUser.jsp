


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>main</title>
<link href='resources/fullcalendar/lib/main.css' rel='stylesheet' />
<script src='resources/fullcalendar/lib/main.js'></script>
<script src="resources/fullcalendar/lib/locales-all.js"></script>
<script>

  document.addEventListener('DOMContentLoaded', function() {
    var srcCalendarEl = document.getElementById('source-calendar');

    var srcCalendar = new FullCalendar.Calendar(srcCalendarEl, {
      editable: true,
      businessHours: true,
      initialDate: new Date()
    });

    srcCalendar.render();
  });

</script>
<style>
   .memCard{
      display: flex;
      height: 150px;
   }
   
   #memImg{
      width: 90px;
   }
   
   .memItem{
      flex-basis: 33%;
       align-self: center;
   }
   
   #comTable{
      width: 100%;
      text-align: center;
   }
   
   #comTable td{
      border: none;
   }
   
   .comBtn{
      margin-right: 10%;
   }
   
   #tableCard{
      height: 330px;
   }
   
   .boardTable {
      width: 100%;
        border-collapse: collapse;
        background: white;
    }
    
    .boardTable th, td {
        border-bottom: 1px solid #e3e3e3;
       vertical-align: middle;
       text-align: center;
       font-size: 13px;
       height: 40px;
   }

    .boardTable th {
       border-bottom: none;
        background-color: rgba(0, 0, 0, 0.04);
       color: #666;
    }

   .boardBtn{
      border: none;
      border-bottom: 1px solid #e3e3e3;
      background: none;
   }
   
   .boardBtn:focus{
		outline: none;
   }
   
   .boardBtn:hover{
		cursor: pointer;
   }
   
   #searchIcon {
      padding: 15px;
   }
   
   #searchItem {
      margin-top: 12px;
   }
   
    body {
    margin: 20px 0 0 20px;
    font-size: 14px;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  }

  #source-calendar {
    float: left;
    width: 48%;
    margin: 0 0 20px 20px;
  }
  #userDiv {
    float: left;
    width: 45%;
    margin: 0 5% 20px 0;
  }
  
	 #userTable {
	  width: 100%;
	  border-collapse: collapse;
	  background: white;
	}
	 
	 #userTable th, td {
	     border-bottom: 1px solid #e3e3e3;
	    vertical-align: middle;
	    text-align: center;
	    font-size: 13px;
	    height: 40px;
	}
	
	#userTable th {
	   border-bottom: 1px solid #e3e3e3;
	   border-top: 1px solid #e3e3e3;
	    background-color: rgba(0, 0, 0, 0.04);
	   color: #666;
	}
  
  	#more{
  		float: right; display: inline-block;
  		margin-top: 3%;
  	}
  	
  	#more:hover {
		cursor: pointer;
		text-decoration-line : none;
	}
  
</style>

</head>
<body>

   <c:import url="common/headerUser.jsp" />
   
   <!-- Main Content -->
   <div class="main-content">
      <section class="section">
         <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-12">
               <div class="card">
                  <div class="card-body text-center memCard">
                     <div class="memItem">
                     	<c:if test="${ loginUser.profile.pUrl eq null }">
	                        <img alt="image" src="resources/dist/assets/img/avatar/avatar-4.png" class="rounded-circle" id="memImg">
                     	</c:if>
                     	<c:if test="${ loginUser.profile.pUrl ne null }">
	                        <img alt="image" src="resources/profileUploadFiles/${ loginUser.profile.pReName }" class="rounded-circle" id="memImg" width="90" height="90">
                     	</c:if>
                     </div>
                     <div class="memItem">
                        <h5>${ loginUser.name }</h5>
                        <label>${ loginUser.dName } ${ loginUser.jobGrade }</label>
                     </div>
                     <div class="memItem">
                        <h5>?????? ?????? ??????</h5>
                        <label>5???</label>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-12">
               <div class="card">
                  <div class="card-body memCard">
                     <table id="comTable" style="width: 100%; text-align: center; border: none;">
                        <tr>
                           <td style="width: 30%;"><h5 style="display: inline-block">?????? ??????</h5></td>
                           <td style="width: 50%;" id="nowTime"></td>
                           <td>
	                           <c:if test="${ empty qr || qr.file_name eq null }">
	                              <button class="btn btn-warning btn-sm comBtn" onclick="createQR()">QR?????? ??????</button>
	                           </c:if>
	                           <c:if test="${ !empty qr && qr.file_name ne null }">
	                              <button class="btn btn-primary btn-sm comBtn" onclick="popup()">QR?????? ??????</button>
	                           </c:if>
                           </td>
                        </tr>
                        <tr>
                            <td>?????? ??????</td>
                           <c:set var="today" value="<%= new java.util.Date() %>"/>
                           <fmt:formatDate value="${ today }" pattern="yyyy-MM-dd" var="nowDate"/>
                           <fmt:formatDate value="${ today }" pattern="HH:mm" var="nowTime"/>
                           <c:if test="${ empty co.goWork }">    
                          		<td id="test1">
                          	 	</td> 
                          	 	<td style="text-align: right;"><button class="btn btn-primary btn-sm comBtn" onclick="gowork()">????????????</button></td>
                           </c:if>
                          	<c:if test="${ !empty co.goWork }">             
                          		 <td id="gowork">
                          	 		<fmt:formatDate value="${ co.goWork }" pattern="HH:mm"/>
                          	 	</td> 
                          	 	<td style="text-align: right;"><button class="btn btn-primary btn-sm comBtn" onclick="gowork()" disabled>????????????</button></td>
                          	 </c:if>
                        </tr>
                        <tr>
                           <td>?????? ??????</td>
                         	  	<c:if test="${ empty co.leaveWork }">
                         	  		<c:choose>
                         	  			<c:when test= "${ empty co.goWork }">
	                         	  			<td id="test2">
	                          	 			<td style="text-align: right;"><button class="btn btn-primary btn-sm comBtn" onclick="leavework1()">????????????</button></td>
                         	  			</c:when>
                         	  			<c:when test= "${ !empty co.goWork }">
	                         	  			<td id="test2">
	                          	 			<td style="text-align: right;"><button class="btn btn-primary btn-sm comBtn" onclick="leavework2()">????????????</button></td>
                         	  			</c:when>
                         	  		</c:choose>
                          	 	</c:if>
                          	 	<c:if test="${ !empty co.leaveWork }">
                          	 	 <td id="leavework">
                          	 			<fmt:formatDate value="${ co.leaveWork }" pattern="HH:mm"/>
                          	 		<td style="text-align: right;"><button class="btn btn-primary btn-sm comBtn" onclick="leavework()" disabled>????????????</button></td>
                          	 	</td>
                          	 	</c:if>
                        </tr>
                     </table>
                  </div>
               </div>
            </div>
         </div>
         <div class="row">
            <div class="col-12">
               <div class="card">
                  <div class="card-body" id="tableCard">
                     <div>
                        <button class="boardBtn" id="noticeBtn" onclick="clickBtn(this);">????????????</button>&nbsp;
                        <button class="boardBtn" id="generalBtn" onclick="clickBtn(this);">?????? ?????????</button>&nbsp;
                        <button class="boardBtn" id="anonymousBtn" onclick="clickBtn(this);">?????? ?????????</button>
                     </div>
                     <br>
                     <div id="noticeBoard">
                        <table class="boardTable" id="noticeTable">
                                  <thead>
                                      <tr>
                                          <th style="width: 150px;">??? ??????</th>
                                          <th style="width: 450px;">??? ??????</th>
                                          <th style="width: 110px;">?????????</th>
                                          <th style="width: 170px;">?????????</th>
                                          <th style="width: 100px;">?????????</th>
                                      </tr>
                                  </thead>
                                  <tbody id="noticeBody">
                                  </tbody>
                              </table>
                           </div>
                           <div id="commonBoard">
							<table class="boardTable" id="commonTable">
	                            <thead>
	                                <tr>
	                                    <th style="width: 150px;">??? ??????</th>
	                                    <th style="width: 450px;">??? ??????</th>
	                                    <th style="width: 110px;">?????????</th>
	                                    <th style="width: 170px;">?????????</th>
	                                    <th style="width: 100px;">?????????</th>
	                                </tr>
	                            </thead>
	                            <tbody id="commonBody">
	                            </tbody>
	                        </table>
                        </div>
                           <div id="anonymousBoard">
                        <table class="boardTable">
                                  <thead>
                                      <tr>
                                          <th style="width: 150px;">??? ??????</th>
                                          <th style="width: 450px;">??? ??????</th>
                                          <th style="width: 110px;">?????????</th>
                                          <th style="width: 170px;">?????????</th>
                                          <th style="width: 100px;">?????????</th>
                                      </tr>
                                  </thead>
                                  <tbody>
                                      <tr>
                                          <td>1</td>
                                          <td>?????? ??? ?????????????</td>
                                          <td>?????????</td>
                                          <td>2021-12-19</td>
                                          <td>1</td>
                                      </tr>
                                      <tr>
                                          <td>2</td>
                                          <td>????????? ????????? ?????? ?????? ?????????</td>
                                          <td>?????????</td>
                                          <td>2021-12-19</td>
                                          <td>1</td>
                                      </tr>
                                      <tr>
                                          <td>3</td>
                                          <td>????????? ??????</td>
                                          <td>?????????</td>
                                          <td>2021-12-19</td>
                                          <td>1</td>
                                      </tr>
                                      <tr>
                                          <td>4</td>
                                          <td>????????? ??????</td>
                                          <td>?????????</td>
                                          <td>2021-12-19</td>
                                          <td>1</td>
                                      </tr>
                                      <tr>
                                          <td>5</td>
                                          <td>????????? ??????</td>
                                          <td>?????????</td>
                                          <td>2021-12-19</td>
                                          <td>1</td>
                                      </tr>
                                  </tbody>
                              </table>
                           </div>
                  </div>
               </div>
            </div>
         </div>
         
      </section>
      <div class="row">
            <div class="col-12">
               <div class="card">
                  <div class="card-body">
                  	<div id="userDiv">
                  		<h5 style="margin: 2% 0 4% 0; display: inline-block;">?????? ?????????</h5> 
                  		<a href="adbookList.ab" id="more">????????? <i class="fas fa-angle-right"></i></a>
	                  	<table class="table table-striped" id="userTable">
							<thead>
								<tr >
									<th style="font-size : 9pt;">??????</th>
									<th style="font-size : 9pt;">????????????</th>
									<th style="font-size : 9pt;">?????????</th>
									<th style="font-size : 9pt;">??????</th>
									<th style="font-size : 9pt;">??????</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="a" items="${ list }">
									<tr>
										<td style="font-size : 9pt;">${ a.name }</td>
										<td style="font-size : 9pt;">${ a.phone }</td>
										<td style="font-size : 9pt;">${ a.email }</td>
										<td style="font-size : 9pt;">${ a.dName }</td>
										<td style="font-size : 9pt;">${ a.jobGrade }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div id='source-calendar'></div>
				  </div>
				</div>
			</div>
		</div>
   
   </div>
   
<script>
		$(function(){
			$('#commonBoard').css('display', 'none');
			$('#anonymousBoard').css('display', 'none');
		});
		
		function clickBtn(btn) {
			if(btn.id == 'noticeBtn'){
				
				$.ajax({
					url: 'noticeRecentList.ad',
					dataType: 'json',
					success: function(data){
						$nTable = $('#noticeBody');
						$nTable.html('');
						console.log(data);
						for(var i in data){
							$tr = $('<tr>');
							$bNo = $('<td>').html(data[i].bNo);
							$bTitle = $('<td>').html(data[i].bTitle);
							$bWriter = $('<td>').html(data[i].name);
							$bDate = $('<td>').html(data[i].bDate);
							$bCount = $('<td>').html(data[i].bCount);
							
							$tr.append($bNo);
							$tr.append($bTitle);
							$tr.append($bWriter);
							$tr.append($bDate);
							$tr.append($bCount);
							
							$nTable.append($tr);
						}
						
					},
					error: function(data){
						console.log(data);
					}
				});
				
				$(btn).html('<b>????????????</b>');
				$('#generalBtn').html('?????? ?????????');
				$('#anonymousBtn').html('?????? ?????????');
				$('#noticeBoard').css('display', 'block');
				$('#commonBoard').css('display', 'none');
				$('#anonymousBoard').css('display', 'none');

			} else if(btn.id == 'generalBtn'){
				$.ajax({
					url: 'commonTopList.bo',
					dataType: 'json',
					success: function(data){
						console.log(data);
						
						$cTable = $('#commonBody');
						$cTable.html('');
						
						for(var i in data){
							$tr = $('<tr>');
							$bNo = $('<td>').html(data[i].bNo);
							$bTitle = $('<td>').html("[ " + data[i].categoryName + " ] " + data[i].bTitle);
							$bWriter = $('<td>').html(data[i].name);
							$bDate = $('<td>').html(data[i].bDate);
							$bCount = $('<td>').html(data[i].bCount);
							
							$tr.append($bNo);
							$tr.append($bTitle);
							$tr.append($bWriter);
							$tr.append($bDate);
							$tr.append($bCount);
							
							$cTable.append($tr);
						}
						
					},
					error: function(data){
						console.log(data);
					}
				});
				
				$(btn).html('<b>?????? ?????????</b>');
				$('#noticeBtn').html('????????????');
				$('#anonymousBtn').html('?????? ?????????');
				$('#noticeBoard').css('display', 'none');
				$('#commonBoard').css('display', 'block');
				$('#anonymousBoard').css('display', 'none');
			} else if(btn.id == 'anonymousBtn'){
				$(btn).html('<b>?????? ?????????</b>');
				$('#noticeBtn').html('????????????');
				$('#generalBtn').html('?????? ?????????');
				$('#noticeBoard').css('display', 'none');
				$('#commonBoard').css('display', 'none');
				$('#anonymousBoard').css('display', 'block');
			}
		}
		
		$(function(){
			$.ajax({
				url: 'noticeRecentList.ad',
				dataType: 'json',
				success: function(data){
					$nTable = $('#noticeBody');
					$nTable.html('');
					console.log(data);
					for(var i in data){
						$tr = $('<tr>');
						$bNo = $('<td>').html(data[i].bNo);
						$bTitle = $('<td>').html(data[i].bTitle);
						$bWriter = $('<td>').html(data[i].name);
						$bDate = $('<td>').html(data[i].bDate);
						$bCount = $('<td>').html(data[i].bCount);
						
						$tr.append($bNo);
						$tr.append($bTitle);
						$tr.append($bWriter);
						$tr.append($bDate);
						$tr.append($bCount);
						
						$nTable.append($tr);
					}
					
				},
				error: function(data){
					console.log(data);
				}
			});
		});
		
		// ????????? ?????? ???????????????, ?????? ?????????
		$(document).on({
			mouseenter: function() {
				$(this).parent().css({'background':'rgba(0, 0, 0, 0.04)', 'font-weight':'bold', 'cursor':'pointer'});
			},
			mouseout: function() {
				$(this).parent().css({'background':'white', 'font-weight':'normal'});
			},
			click: function() {
				var bNo = $(this).parent().children().eq(0).text();
				var tableID = $(this).closest('table').attr('id');
				
				if(tableID == 'noticeTable'){
					location.href= "ndetail.ad?bNo=" + bNo + '&page=1';
				} else if (tableID == 'commonTable'){
					// ?????? ????????? ????????? ?????? ??????
					location.href= "cdetail.bo?bNo=" + bNo;
				}
				
			}
		}, '.boardTable tbody td');
		
	</script>
    <script src="resources/dist/assets/vendors/js/vendor.bundle.base.js"></script>
    
        <script>
	       function nowTime(){
	    	   var today = new Date();
		 		var nowTime = document.getElementById('nowTime');
		 		var gowork = '${ co.goWork }';
		 		var h = today.getHours(); // date??? ??? ??????
		 		var m = today.getMinutes(); //date??? ??? ??????
				var goworkh = gowork.substring(11, 13); //?????? ????????? ??? ??????
				var goworkm = gowork.substring(14, 16); // ?????? ????????? ??? ??????
		 		
				
				// ????????? ?????? Number ???????????? ??????
		 		h = Number(h); 
		 		m = Number(m);
		 		goworkh = Number(goworkh);
		 		goworkm = Number(goworkm);
		 		
		 		gh = h-goworkh;
		 		gm = m-goworkm;

		 		nowTime.innerHTML = gh+"??????"+"&nbsp;"+"&nbsp;"+gm+"???";
		 		
		 		setTimeout('nowTime()', 1000); // 1????????? ????????? ??????
       }
	       
	       window.onload = function(){
		 		nowTime();
		 	};
       
       function dasi(i){
          if(i < 10) {
             i = "0" + i;
          };
          return i;
          // 10?????? ????????? ???????????? 0 ??????
       }
       
       
    </script>
    
     <script type="text/javascript">
       function popup(){
          var popup = window.open('qrSelect.co', 'QRCode', 'width=300px,height=300px,scrollbars=yes');
       }
       
       	function createQR() {
    	   alert("QR?????? ????????? ??????????????????.");
    	   location.href='qrMake.co';
		}
       	
       	function gowork() {
       		window.name = "mainPage";
       		var qrURL = window.open('qrcode.co', 'goToWork', 'width=500px,height=500px,scrollbars=yes');
//        		location.href='qrcode.co';
		}
       	
       	function leavework1() {
       		alert("?????? ?????? ????????? ????????????.");
		}
       	
       	function leavework2() {
       		var bool = confirm('?????? ?????????????????????????');
       		
       		if(bool){
       			location.href='leavework.co';
       		}
		}
       	
    </script>


  <script src="resources/vendors/chart.js/Chart.min.js"></script>

  <script src="resources/vendors/js/off-canvas.js"></script>
  <script src="resources/vendors/js/hoverable-collapse.js"></script>
  <script src="resources/vendors/js/template.js"></script>
  <script src="resources/vendors/js/todolist.js"></script>

  <script src="resources/vendors/js/dashboard.js"></script>

 
   <c:import url="common/footer.jsp" />
</body>
</html>