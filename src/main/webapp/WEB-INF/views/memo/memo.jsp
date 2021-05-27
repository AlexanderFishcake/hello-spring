<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="메모" name="title"/>
</jsp:include>

<style>
div#memo-container{width:60%; margin:0 auto;text-align:center;}
</style>
<div id="memo-container">
    <form action="${pageContext.request.contextPath}/memo/insertMemo.do" class="form-inline" method="post">
        <input type="text" class="form-control col-sm-10" name="memo" placeholder="메모" required/>&nbsp;
        <button class="btn btn-outline-success" type="submit" >저장</button>
    </form>
    <br />
    <!-- 메모목록 -->
	<table class="table">
	    <tr>
	      <th>번호</th>
	      <th>메모</th>
	      <th>날짜</th>
	      <th>삭제</th>
	    </tr>
	    <c:forEach items="${list }" var="memo">
	    <tr>
	      <td>${memo.no }</td>
	      <td>${memo.memo }</td>
	      <td><fmt:formatDate value="${memo.regDate }" pattern="yy/MM/dd HH:mm"/></td>
	      <td><button type="button" class="btn btn-outline-danger" onclick="memoDelete(${memo.no});">삭제</button></td>
		</tr>
	    </c:forEach>
	</table>
	<form action="${pageContext.request.contextPath}/memo/deleteMemo.do" method="get">
		<input type="hidden" name="no"/>
	</form>
	
</div>
<script>
function memoDelete(no){
	console.log("입력버튼번호 : "+no);
	
	var newForm = $('<form></form>'); //set attribute (form) 
	newForm.attr("name","newForm"); 
	newForm.attr("method","get"); 
	newForm.attr("action","${pageContext.request.contextPath}/memo/deleteMemo.do"); 
	
	newForm.append($('<input/>', {type: 'hidden', name: 'no', value:no })); 
	newForm.appendTo('body'); // submit form 
	newForm.submit();

}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
