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

public class NoticeDTO {
    private int no;
    private String title;
    private String content;
    private int count;
    private LocalDate createDate;
}
