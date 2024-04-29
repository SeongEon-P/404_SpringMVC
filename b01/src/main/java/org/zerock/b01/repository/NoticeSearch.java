package org.zerock.b01.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.zerock.b01.domain.Board;
import org.zerock.b01.domain.Notice;

public interface NoticeSearch {
  Page<Notice> search1(Pageable pageable);
  Page<Notice> searchAll(String[] types, String keyword, Pageable pageable);
}

