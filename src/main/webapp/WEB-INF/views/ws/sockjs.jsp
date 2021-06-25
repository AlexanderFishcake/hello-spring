<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Sock.js" name="title"/>
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
<!-- sockjs-client js 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.2/sockjs.js" integrity="sha512-3/5zbNJKTwZiPFIUPL9Q6woFGvOluvYq2/rJ+C4sZUTXKhVoY3e6mSTf5RJG01lYX3atqeslmWTsxCXb147x2w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- 구형브라우저에서 ES6 최신문법 사용하기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.js" integrity="sha512-pBSlhNUvB+td6sjW1zmR6L7c7kVWR4octUPl4tfHmzO63424nxta8aLmficEcAAswQmRqTiToi63AazDurj/Sg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.12.1/polyfill.js" integrity="sha512-wixq/u8vbwoVM6yCmTHUNszWudaPpwf8pKxfG1NPUOBXTh1ntBx8sr/dJSbGTlZUqpcoPjaUmU1hlBB3oJlzFQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/babel">
/**
 * sock.js
 *
 * html5api websocket을 지원하지 않는 브라우저에서도 양방향 통신을 사용
 *
 * - http로 최초연결시도후, websock이 사용가능한 경우 ws protocol로 upgradde
 * - 구버전 브라우져의 경우, xhr-stream/xhr-polling 중 적합한 방향으로 양방향 통신 사용.
 */
const ws = new SockJS(`http://\${location.host}/spring/websooocket`);
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