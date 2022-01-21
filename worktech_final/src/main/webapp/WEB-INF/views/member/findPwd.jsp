<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
  <title>임시 비밀번호 발급</title>
  <style>
   
/*    #but{ background:#536DFE; border-color:#536DFE; } */
   #brandbox{ display: table-cell; text-align : center; }
   	#brand {
	  
	  vertical-align: middle;
	  margin: 0 auto;  

	}

  </style>
  <!-- General CSS Files -->
  <link rel="stylesheet" href="resources/dist/assets/modules/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="resources/dist/assets/modules/fontawesome/css/all.min.css">

  <!-- CSS Libraries -->

  <!-- Template CSS -->
  <link rel="stylesheet" href="resources/dist/assets/css/style.css">
  <link rel="stylesheet" href="resources/dist/assets/css/components.css">
<!-- Start GA -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-94034622-3"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-94034622-3');
</script>
<!-- /END GA --></head>

<body>
<body>
  <div id="app">
    <section class="section">
      <div class="container mt-5">
        <div class="row">
          <div class="col-12 col-sm-8 offset-sm-2 col-md-6 offset-md-3 col-lg-6 offset-lg-3 col-xl-4 offset-xl-4" id="barndbox">
            <div class="login-brand" id="brand">
              <img src="resources/dist/assets/img/logo.png" alt="logo"  width="250">
<!--               <p class="MuiTypography-root jss4 MuiTypography-body1">WorkTech</p> -->
            </div>
            

            <div class="card card-primary">
              <div class="card-header"><h4>임시 비밀번호 발급</h4></div> <!-- 가운데 정렬 -->

              <div class="card-body">
                <p class="text-muted">등록된 사번과 개인 이메일을 입력해주세요.</p>
                <form method="POST" action="findPassword.me" id="findPwd">
                  <div class="form-group">
                    <label for="email">사번</label>
                    <input id="mNo" type="text" class="form-control" name="mNo" tabindex="1" required autofocus>
                    
				    <span class="invalid-feedback">존재하지 않는 사번입니다.</span>
				    <input type="hidden" id="idDuplicateCheck" value='0'>
                  </div>
                  
                  <div class="form-group">
                    <label for="email">개인 Email</label>
                    <input id="mEmail" type="email" class="form-control" name="mEmail" tabindex="1" required autofocus>
                  </div>

                  <div class="form-group">
<!--                     <button type="submit" class="btn btn-primary btn-lg btn-block" tabindex="4" id="but"> -->
<!--                       Forgot Password -->
<!--                     </button> -->
                    
                     <button type="submit" class="btn btn-primary btn-lg btn-block" tabindex="4" id="but" onclick="return validate();">
                      Forgot Password
                    </button>
                  </div>
                </form>
              </div>
            </div>
           
          </div>
        </div>
      </div>
    </section>
  </div>

  <!-- General JS Scripts -->
  <script src="resources/dist/assets/modules/jquery.min.js"></script>
  <script src="resources/dist/assets/modules/popper.js"></script>
  <script src="resources/dist/assets/modules/tooltip.js"></script>
  <script src="resources/dist/assets/modules/bootstrap/js/bootstrap.min.js"></script>
  <script src="resources/dist/assets/modules/nicescroll/jquery.nicescroll.min.js"></script>
  <script src="resources/dist/assets/modules/moment.min.js"></script>
  <script src="resources/dist/assets/js/stisla.js"></script>
  
  <!-- JS Libraies -->

  <!-- Page Specific JS File -->
  
  <!-- Template JS File -->
  <script src="resources/dist/assets/js/scripts.js"></script>
  <script src="resources/dist/assets/js/custom.js"></script>
  
  <script type="text/javascript">
	 // 사번 중복 확인
     $('#mNo').on('keyup', function(){
		var mNo = $(this).val().trim();

		if(mNo.length < 6){
			// 가이드가 안보이도록 숨기기
			$('.invalid-feedback').hide();
			$('#idDubplicateCheck').val(0);
				return; 
			}
			
				$.ajax({
					url : 'dupId.me',
					data : {mNo:mNo},
					success : function(data){
						console.log(data);
						data = data.trim();
						if(data == 'NoDup'){ // 중복X
							$('.invalid-feedback').show();
							$('#idDuplicateCheck').val(1);
							$("input[name=mNo]").attr("class", 'form-control is-invalid');
						} else if(data == 'Dup'){ // 중복o
							$('.invalid-feedback').hide();
							$('#idDuplicateCheck').val(0);
						}
						
					},
					error : function(data){
						console.log(data);
					}
				});
		});
    	  
      
		function validate(){
			if($('#idDuplicateCheck').val() == 1 ){
				alert('입력하신 사번이 없습니다. 다시 입력해주세요.');
				$('#mNo').focus();
				return false;
			} else {
				$('#findPwd').submit();
			}
			
		}
	
	</script>
	
</body>
</html>