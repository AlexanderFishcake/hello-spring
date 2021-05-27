package com.kh.spring.demo.model.dao;

import java.util.List;

import com.kh.spring.demo.model.vo.Dev;

public interface DemoDao {

	int insertDev(Dev dev);

	List<Dev> selectDevList();

	Dev selectDev(int no);

	int updateDev(Dev dev);

	int deleteDev(int no);

}
