package com.kh.spring.websocket.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebsocketConfig implements WebSocketConfigurer{
	
	@Autowired
	WebsocketHandler websocketHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		//client의 const ws = new Websocket("ws://localhost:9090/spring/websooocket"); 대응
		registry
			.addHandler(websocketHandler, "/websooocket")
			.withSockJS();	//server side에도 sockjs 적용
		
	}

}
