<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<!-- bootstrap css -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">

<!-- 사용자작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" />
<script>
$(()=>{
	$("#loginModal")
		.modal()
		.on('hide.bs.modal', e => {
			//console.log(e);
			//location.href = '${header.referer}';
			//referer가 비어있거나, 이전 페이지가 로그인페이지였다면 다음 페이지는 인덱스다/아니면 referer다.
			/*referer가 비어있었다면, 다음 페이지는 인덱스다.
			이전페이지가 로그인페이지였다면,
			1. referer=devList, next=null 인 경우
			2. referer=login, next=devList 인 경우
			즉 referer!=null && next!=null 인 경우 href=next
			*/
			//location.href = '${empty header.referer || fn:contains(header.referer, 'member/memberLogin.do') ? pageContext.request.contextPath : header.referer}';
			if(${empty header.referer }){//바로 접근했을 경우
				location.href =	'${pageContext.request.contextPath}';
			}else{//이전 페이지가 존재할 경우
				if(${fn:contains(header.referer, 'member/memberLogin.do')}){//이전 페이지가 login페이지였다면
					//next==null이면 referer에 이전페이지 존재. next!=null이면 next에 이전페이지 존재.
					//location.href = '${empty next ? header.referer : next}'; 
					location.href = '${empty next ? pageContext.request.contextPath : next}'; 
				}
				else{//이전페이지가 login이 아니라면
					location.href = '${header.referer}';
				}
			}
		});
	$(".modal").on("shown.bs.modal", function () {
		$("input[name=id]").focus();
		});
		<%--출처: https://shxrecord.tistory.com/191 [첫 발]--%>
})

</script>

</head>
<body>
${common.adminEmail }
${common.adminPhone }
	<!-- Modal시작 -->
	<!-- https://getbootstrap.com/docs/4.1/components/modal/#live-demo -->
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
		aria-labelledby="loginModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="loginModalLabel">로그인</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<!--로그인폼 -->
				<!-- https://getbootstrap.com/docs/4.1/components/forms/#overview -->
				<form
					action="${pageContext.request.contextPath}/member/memberLogin.do"
					method="post">
					<div class="modal-body">
						<c:if test="${not empty msg}">
						<div class="alert alert-warning alert-dismissible fade show" role="alert">
						  <strong>${msg}</strong>
						  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
						    <span aria-hidden="true">&times;</span>
						  </button>
						</div>
						</c:if>

						<input type="text" class="form-control" name="id"
							placeholder="아이디" value="honggd" required> <br /> <input
							type="password" class="form-control" name="password"
							placeholder="비밀번호" value="1234" required>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-outline-success">로그인</button>
						<button type="button" class="btn btn-outline-success" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Modal 끝-->
</body>
</html>