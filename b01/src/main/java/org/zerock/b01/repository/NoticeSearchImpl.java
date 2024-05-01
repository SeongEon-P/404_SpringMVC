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
  public Page<Notice> searchAll(String keyword, Pageable pageable) {
    //querydsl로 생성된 qboard 설정
    QNotice notice = QNotice.notice;
    JPQLQuery<Notice> query = from(notice);

    BooleanBuilder booleanBuilder = new BooleanBuilder();
    if(keyword != null) {

      booleanBuilder.or(notice.title.contains(keyword));
      booleanBuilder.or(notice.content.contains(keyword));

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












