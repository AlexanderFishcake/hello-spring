package com.kh.spring.memo.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.memo.model.dao.MemoDao;
import com.kh.spring.memo.model.vo.Memo;

import lombok.extern.slf4j.Slf4j;

/**
 * 의존주입받은 객체는 우리가 작성한 
 * MemoController, MemoServiceImpl, MemoDaoImpl타입 객체가 아닌
 * proxy객체이다.
 * 
 * 1. jdk 동적proxy - interface구현체
 * 2. cglib - interface구현체가 아닌 경우
 *
 */
@Service
@Slf4j
public class MemoServiceImpl implements MemoService {
	
	@Autowired
	private MemoDao memoDao;

	@Override
	public int insertMemo(Memo memo) {
		return memoDao.insertMemo(memo);
	}

	@Override
	public List<Memo> selectMemoList() {
		//log.debug("dao = {}",memoDao);
		return memoDao.selectMemoList();
	}

	@Override
	public int deleteMemo(int no) {
		return memoDao.deleteMemo(no);
	}

}
