<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판" name="title"/>
</jsp:include>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
/*글쓰기버튼*/
input#btn-add{float:right; margin: 0 0 15px;}
tr[data-no]{
	cursor: pointer; 
}
</style>
<script>
function goBoardForm(){
	location.href = "${pageContext.request.contextPath}/board/boardForm.do";
}
$(()=>{	
	$("tr[data-no]").click(e=>{
		//화살표함수 안에서는 this는 e.target이 아니다.
		console.log(e.target); //td태그클릭->부모tr로 이벤트 전파
		var $tr = $(e.target).parent();
		var no = $tr.data("no");
		location.href = "${pageContext.request.contextPath}/board/boardDetail.do?no="+no;
	});

    $("#searchTitle").autocomplete({
        source: function(request, response){
			//사용자입력값 전달 ajax 요청-> success함수 안에서 response호출
			$.ajax({
				url: "${pageContext.request.contextPath}/board/searchBoard.do",
				data: {
					searchTitle: request.term
				},
				success(data){
					console.log(data);
					const {list} = data;
					const arr = 
					list.map(({no,title}) =>{
						return{
							label: title,
							value: title,
							no
						}
					});
					console.log(arr);
					response(arr);
				},
				error: function(xhr,status,err){
					console.log(xhr,status,err);
					}
			})
		},
		select: function(event, selected){
    		  //console.log(event);
    		  //console.log(selected);
    		  const {item: {no}} = selected;
    		  location.href = "${pageContext.request.contextPath }/board/boardDetail.do?no="+no;
    	  },
    	  focus: function(event, focused){
    		  return false;
    	  },
    	  autoFocus: true //자동완성에 포커스두기
    	  ,minLength: 3 //자동완성 시작되는 문자열 길이
    	  
    });
	    
});
</script>
<section id="board-container" class="container">
	<input type="search" placeholder="제목 검색..." id="searchTitle" class="form-control col-sm-3 d-inline"/>
	<input type="button" value="글쓰기" id="btn-add" class="btn btn-outline-success" onclick="goBoardForm();"/>
	<table id="tbl-board" class="table table-striped table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>첨부파일</th> <!-- 첨부파일 있을 경우, /resources/images/file.png 표시 width: 16px-->
			<th>조회수</th>
		</tr>
		<c:forEach items="${boardList }" var="board">
		<tr data-no="${board.no}">
			<td>${board.no }</td>
			<td>${board.title }</td>
			<td>${board.memberId }</td>
			<td><fmt:formatDate value="${board.regDate }" pattern="yy-MM-dd" /></td>
			<td>
				<c:if test="${board.hasAttachment }">
				<img alt="" src="${pageContext.request.contextPath }/resources/images/file.png" width="16px">
				</c:if>
			</td>
			<td>${board.readCount }</td>
		</tr>
		</c:forEach>
	</table>
	<%-- pageBar --%>
	${pageBar }
</section> 
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
