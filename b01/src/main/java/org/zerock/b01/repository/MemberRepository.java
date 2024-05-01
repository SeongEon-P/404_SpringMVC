package org.zerock.b01.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.zerock.b01.domain.Member;

public interface MemberRepository  extends JpaRepository<Member,String> {
    @Query(value = "SELECT member_id, member_pw, name, phone, email1, email2, gender, agree, moddate, regdate FROM member WHERE member_id = ?1 AND member_pw = ?2", nativeQuery = true)
    //WHERE member_id = ?1 AND member_pw = ?2 여기서 1,2는 밑에 Member findByIdAndPw(String id, String pw);의 순서를 말함
    Member findByIdAndPw(String id, String pw);
}