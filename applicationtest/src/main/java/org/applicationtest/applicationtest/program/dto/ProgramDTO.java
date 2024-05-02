package org.applicationtest.applicationtest.program.dto;

import lombok.Builder;
import lombok.Data;
import lombok.ToString;

import java.time.LocalDate;

@Data
@Builder
@ToString
public class ProgramDTO {
  private int no;
  private String title;
  private String text;
  private String subtext;
  private String schedule;
  private String img;
  private LocalDate create_date;
}
