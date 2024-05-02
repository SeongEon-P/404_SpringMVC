package org.applicationtest.applicationtest.notice.dto;

import lombok.Builder;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDate;

@Data
@Builder
@ToString
public class NoticeDTO {
  private int no;
  private String title;
  private String content;
  private int count;
  private LocalDate create_date;
}
