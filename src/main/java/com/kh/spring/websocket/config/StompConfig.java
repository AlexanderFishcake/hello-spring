package com.kh.spring.websocket.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

/**
 * Stomp가 기존 Websocket보다 뭐가 좋은가? 내부적으로는 websocket을 쓰지만..
 * 
 * - MessageBroker 방식 처리 a - broker - b
 * - publish 발행/subscribe 구독 패턴 처리
 * 		- 특정 url을 구독하는 subscriber에게 발행한 message를 전달
 *
 */
@Configuration
@EnableWebSocketMessageBroker
public class StompConfig implements WebSocketMessageBrokerConfigurer {
	
	/**
	 * client에서 최초 websocket 접속 url을 설정
	 */
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/stommmp")
				.withSockJS();
	}

	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		//1. SimpleBroker /coffee/maxim
		registry
			.enableSimpleBroker("/notice");
		//2. MessageHandler : /app/a --> @MessageMapping("/a")
		registry
			.setApplicationDestinationPrefixes("/admin");
	}
	

}
