package com.alt.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
@Setter
@Getter
public class Criteria {
	
  //현재 페이지 번호
  private int pageNum;
  //페이지당 출력할 레코드 갯수
  private int amount;
  //검색범위(searchScope :C : content, T: title, W: writer)
  private String type;
  //검색키워드
  private String keyword;
  
  public Criteria() {
    this(1, 10);
  }

  public Criteria(int pageNum, int amount) {
    this.pageNum = pageNum;
    this.amount = amount;
  }
  
  //지영
  //type필드의 TCW 값을 ["T", "C", "W"] 배열로 반환하는 메소드
  public String[] getTypeArr() {
	return type ==null ? new String[] {} : type.split("");
  }
  
  public String getListLink() {
	  UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
			  .queryParam("pageNum", this.pageNum)
			  .queryParam("amount", this.getAmount())
			  .queryParam("type", this.getType());
	  return builder.toUriString();
	  
  }
  
}
