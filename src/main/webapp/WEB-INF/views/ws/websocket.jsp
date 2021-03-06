<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="헬로우 스프으으으으링" name="title"/>
</jsp:include>
<div class="input-group mb-3">
    <input type="text" id="message" class="form-control" placeholder="Message">
    <div class="input-group-append" style="padding: 0px;">
     <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
</div>
</div>
<div>
    <ul class="list-group list-group-flush" id="data"></ul>
</div>
<script>
//페이지 접속시 서버로 websocket연결 시도
//const ws = new WebSocket("ws://localhost:9090/spring/websooocket");
const ws = new WebSocket(`ws://\${location.host}/spring/websooocket`);
const $data = $("#data");

ws.onopen = e => {
	console.log("onopen");
};

ws.onmessage = e => {
	console.log("onmessage : ", e);
	const {data} = e;
	$data.append("<li class='list-group-item'>"+ data +"</li>");
};
ws.onerror = e => {
	console.log("onclose : ", e);
};

const sendMessage = () => {
	const $message = $("#message");
	if($message.val()){
		ws.send($message.val());
		$message.val("").focus();
	}
};

$("#sendBtn").click(sendMessage);
$("#message").keyup(e => e.keyCode == 13 && sendMessage());
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>