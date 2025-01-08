package com.alt.domain;

//import lombok.Getter;
//import lombok.ToString;

//@Getter
//@ToString
public class PageDTO {
	
	//교재와는 틀리게 pageingNumCnt를 이용하여 공식화 하여 작성한 소스입니다..참고 바랍니다..


	//화면에 전달되는 페이징 값들
	private int startPage;       //화면에 표시되는 시작 페이징 번호
	private int endPage;         //화면에 표시되는 끝 페이징 번호
	private boolean prev, next;  //이전 or 다음 버튼 표시 여부 결정 변수 (true : 표시됨, false : 표시안됨)
	private int total;           //전채 행 개수(get)
	private Criteria cri;        //현재 페이지번호, 행 개수
	private int pageingNumCnt;   //화면 하단에 표시할 기본 페이지 번호 개수(교재의 10에 대응)
	
	public PageDTO(Criteria cri, int total) {
		
		this.cri = cri;
		this.total = total;
		//this.pageingNumCnt = pageingNumCnt;
		this.pageingNumCnt = 10;
		
		//계산된 끝 페이징 번호
		//this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10;
		//(this.pageingNumCnt * 1.0)를 실수로 바꿔줘야합니다.
		this.endPage = (int) (Math.ceil(cri.getPageNum() / (this.pageingNumCnt * 1.0))) * this.pageingNumCnt;
		
		//this.startPage = this.endPage -9;
		this.startPage = this.endPage - (this.pageingNumCnt - 1);
		
		//전체 행 개수를 고려한 총 페이지 개수 (---> 마지막 페이지 번호)
		int realEnd = (int) (Math.ceil(total * 1.0 / cri.getAmount()));
		
		//계산된 끝 페이지 번호가 실제 총 마지막 페이지 번호보다 크면, endPage 값을 realEnd로 대체
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
		
	}
	
	//lombok 대신 get사용
	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean getPrev() {
		return prev;
	}

	public boolean getNext() {
		return next;
	}

	public int getTotal() {
		return total;
	}

	public Criteria getCri() {
		return cri;
	}

	public int getPageingNumCnt() {
		return pageingNumCnt;
	}

	
	
	
	//lombok 대신 toString사용
	@Override
	public String toString() {
		return "PageDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri=" + cri + ", pageingNumCnt=" + pageingNumCnt + "]";
	}

	
}
