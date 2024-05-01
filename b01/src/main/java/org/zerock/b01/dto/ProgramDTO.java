package org.zerock.b01.dto;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProgramDTO {

    private Integer no;

    private String title;

    private String text;

    private String subtext;

    private String schedule;
    private String img;
    private LocalDateTime regDate;
    private LocalDateTime modDate;
}
