package org.zerock.b01.domain;

import jakarta.persistence.*;
import lombok.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString(exclude = "imageSet")
public class Board extends BaseEntity{
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long bno;
  @Column(length = 500, nullable = false)
  private String title;
  @Column(length = 2000, nullable = false)
  private String content;
  @Column(length = 50, nullable = false)
  private String writer;




  public void change(String title, String content){
    this.title = title;
    this.content = content;
  }

  @OneToMany(mappedBy = "board") //BoardImage의 board변수
  @Builder.Default
  //HashSet의 특징은 중복되지 않고, 순서가 없음. 중복되면 삭제됨
  private Set<BoardImage> imageSet = new HashSet<>();
  
}


