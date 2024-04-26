package org.zerock.b01.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.zerock.b01.domain.Notice;

public interface NoticeRepository extends JpaRepository<Notice,Long> { //DAO처럼 database와 연결할때 사용하는게 레포지토리
}
