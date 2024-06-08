package org.zerock.api01test.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
  private String mid;
  private String mpw;
  private String name;
  private String email;
  private boolean agree;
}
