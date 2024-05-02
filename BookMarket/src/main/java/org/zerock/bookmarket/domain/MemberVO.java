package org.zerock.bookmarket.domain;

import lombok.*;

import java.time.LocalDate;

@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberVO {
  // VO(Value Object) : 비즈니스 데이터를 처리하는 모델.
  // 실제 데이터 베이스에서 사용하는 정보를 전체를 다 받는 용도.
  private String memberID;
  private String memberPW;
  private String memberName;
  private String phone;
  private String address;
  private String email;
  private LocalDate createDate;

}








