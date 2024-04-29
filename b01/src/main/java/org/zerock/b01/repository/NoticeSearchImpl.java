package org.zerock.b01.repository;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.JPQLQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.zerock.b01.domain.Board;
import org.zerock.b01.domain.Notice;
import org.zerock.b01.domain.QBoard;
import org.zerock.b01.domain.QNotice;

import java.util.List;

public class NoticeSearchImpl extends QuerydslRepositorySupport implements NoticeSearch {
  public NoticeSearchImpl() {
    super(Notice.class);
  }

  @Override
  public Page<Notice> search1(Pageable pageable) {
    //queryDSL을 이용한 객체 설정
    QNotice notice = QNotice.notice;
    JPQLQuery<Notice> query = from(notice);
    //JPQL을 사용한 WHERE 메서드로 조건식 추가
    query.where(notice.title.contains("1"));
    //pageable 설정
    this.getQuerydsl().applyPagination(pageable, query);
    //위에서 설정한 조건대로 데이터를 조회
    List<Notice> list = query.fetch();
    //페이지수, 총 행수, 총 페이지수 데이터 조회
    long count = query.fetchCount();
    System.out.println(list);
    return null;
  }

  @Override
  public Page<Notice> searchAll(String[] types, String keyword, Pageable pageable) {
    //querydsl로 생성된 qboard 설정
    QNotice notice = QNotice.notice;
    JPQLQuery<Notice> query = from(notice);
    //검색 조건인 types와 키워드가 존재하는 확인 if문
    if((types != null && types.length > 0) && (keyword != null)) {
      BooleanBuilder booleanBuilder = new BooleanBuilder();
      for(String type : types){
        switch(type){
          case "t":
            // OR title LIKE '%keyword%' : SQL작성
            booleanBuilder.or(notice.title.contains(keyword));
            break;
          case "c":
            // OR content LIKE '%keyword%' : SQL작성
            booleanBuilder.or(notice.content.contains(keyword));
            break;
          case "w":
//            // OR writer LIKE '%keyword%' : SQL작성
//            booleanBuilder.or(notice.writer.contains(keyword));
//            break;
        }
      }
      // 실행할 쿼리문에 types, keyword 조건절 추가
      query.where(booleanBuilder);
    }
    // AND no > 0 : WHERE 쿼리 추가
    query.where(notice.no.gt(0L));
    // ORDER BY no DESC limit 0,10 : 정렬 및 리미트 SQL추가
    this.getQuerydsl().applyPagination(pageable, query);
    // SQL 실행
    List<Notice> list = query.fetch();
    // count관련 SQL 실행
    long count = query.fetchCount();
    return new PageImpl<>(list,pageable,count);
  }
}












