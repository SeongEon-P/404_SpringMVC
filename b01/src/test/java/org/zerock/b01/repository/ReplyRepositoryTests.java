package org.zerock.b01.repository;


import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.zerock.b01.domain.Board;
import org.zerock.b01.domain.Reply;

@SpringBootTest
@Log4j2

public class ReplyRepositoryTests {


    @Autowired
    private ReplyRepository replyRepository;

    @Test
    public void testInsert(){
        
        // 더미 데이터 예제
        Long bno = 100L;

        // Reply 클래스에 멤버로 사용될 더미 예제    
        Board board = Board.builder().bno(bno).build();
        
        // Reply 클래스 생성, 빌더 패턴으로
        Reply reply = Reply.builder()
                .board(board)
                .replyText("샘플 댓글")
                .replyer("박성언")
                .build();
            replyRepository.save(reply);
        
    }
}
