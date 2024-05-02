package org.zerock.bookmarket.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {

  private String memberID;
  private String memberPW;
  private String memberName;
  private String phone;
  private String address;
  private String email;
  private LocalDate createDate;

}



