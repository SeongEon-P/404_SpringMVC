package org.applicationtest.applicationtest.domain;

import lombok.*;

import java.sql.Date;
import java.time.LocalDate;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class NoticeVO {
    private int no;
    private String title;
    private String content;
    private int count;
    private LocalDate createDate;

}
