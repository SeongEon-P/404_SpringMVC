package org.zerock.b01.domain;


import jakarta.persistence.*;
import lombok.*;


@Entity
// 댓글 게시글 조회시 인덱스 이용해서, 성능 개선.
@Table(name = "Reply", indexes = {
        @Index(name = "idx_reply_board_bno", columnList = "board_bno")
})
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString(exclude = "board")


public class Reply extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    // 댓글 번호, 자동 증가, 마리아 DB의 정책을 따르고
    private Long rno;

    // Reply : Many ->(to) Board : One, 단방향 참조,
    // 장점, 설정이 쉽고, 간단하다, 단점, 서로간에 참조가 안된다.
    // 조인 설정등을 이용해서, 해소할 예정.
    // fetch = FetchType.LAZY : 디비에 연결하는 부분을 늦게 하겠다.
    @ManyToOne(fetch = FetchType.LAZY)
    private Board board;
    private String replyText;
    private String replyer;
}

