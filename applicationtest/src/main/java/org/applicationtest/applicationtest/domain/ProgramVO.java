package org.applicationtest.applicationtest.domain;


import lombok.*;

import java.time.LocalDate;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProgramVO {
    private int no;
    private String title;
    private String text;
    private String subtext;
    private String schedule;
    private String img;
    private LocalDate createDate;
}
