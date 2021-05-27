package com.kh.spring.common.aop.test;

public class FooImpl implements Foo {

	@Override
	public void sayHello() {
		System.out.println("hellllllllllllo");
	}

	@Override
	public String getName() {
		return "foooooooo";
	}

}
