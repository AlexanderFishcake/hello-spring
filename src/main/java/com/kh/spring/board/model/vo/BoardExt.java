package com.kh.spring.board.model.vo;


import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
//@ToString(callSuper = true) //tostring으로 board까지 보고싶으면 true로.
@NoArgsConstructor
public class BoardExt extends Board {
	
	private boolean hasAttachment;
	private List<Attachment> attachList;
	
}