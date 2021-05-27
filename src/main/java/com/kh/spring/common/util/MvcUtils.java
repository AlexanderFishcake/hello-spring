package com.kh.spring.common.util;

public class MvcUtils {

	public static String getPageBar(int cpage, int limit, int totalContents, String url) {
		StringBuilder pageBar = new StringBuilder();
		int totalPage = (int)Math.ceil((double)totalContents/limit);
		int pageBarSize = 5;

		url = (url.indexOf("?") > -1 )? url+"&" : url+"?";

		int pageStart = (cpage-1)/pageBarSize*pageBarSize+1;
		int pageEnd = pageStart + pageBarSize - 1;
		
		//증감변수는 pageStart부터 시작
		int pageNo = pageStart;
		
		pageBar.append("<nav aria-label=\"Page navigation example\">\r\n"
				+ "		<ul class=\"pagination justify-content-center\">");
		//1. 이전
		if(pageNo ==1 ) {
			pageBar.append("<li class='page-item disabled'>");
		}
		else {
			pageBar.append("<li class='page-item'>");
		}
		pageBar.append("<a class='page-link' href='"+url+"cpage="+(pageNo-1)+"'/>Previous</a></li>");
		
		//2. pageNo
		while(pageNo <=pageEnd && pageNo <= totalPage) {
			if(pageNo == cpage) {
				//현재페이지 - 링크 비활성화
				pageBar.append("<li class='page-item active'><a class='page-link' >"+pageNo+"<span class='sr-only'>(current)</span></a></li>");
			}
			else {
				//링크 활성화
				pageBar.append("<li class='page-item'><a class='page-link' href='"+url+"cpage="+pageNo+"'>"+pageNo+"</a></li>");
			}
			pageNo++;
		}
		
		//3. 다음
		//마지막페이지가 포함된 페이지바인 경우
		if(pageNo>totalPage) {
			//다음버튼 비활성화
			pageBar.append("<li class='page-item disabled'>");
		}
		else {
			//다음버튼 활성화
			pageBar.append("<li class='page-item'>");
		}
		pageBar.append("<a class='page-link' href='"+url+"cpage="+(pageNo)+"'/>Next</a></li>");

		pageBar.append("</ul>\r\n"
				+ "	</nav>");
		
		return pageBar.toString();
	}
	

}
