package org.applicationtest.applicationtest.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class ProgramDTO {
    private int no;
    private String title;
    private String text;
    private String subtext;
    private String schedule;
    private String img;
    private LocalDate createDate;
}

