package org.zerock.bookmarket.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Size;
import java.time.LocalDateTime;



@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class BookDTO {

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

