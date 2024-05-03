package org.zerock.bookmarket.domain;

import lombok.*;

import java.time.LocalDateTime;
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BookVO {
    private String id;
    private String name;
    private String description;
    private String category;
    private String author;
    private String publisher;
    private String releaseDate;
    private String pages;
    private String unitPrice;
    private String unitInStock;
    private String imgFileName;
    private String bcondition;
    private LocalDateTime createDate;
}
