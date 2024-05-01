package org.zerock.b01.service;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.zerock.b01.dto.BoardDTO;
import org.zerock.b01.dto.PageRequestDTO;
import org.zerock.b01.dto.PageResponseDTO;

@SpringBootTest
@Log4j2
public class MemberServiceTests {
  @Autowired
  private MemberService memberService;
  @Test
  public void testRegister() {
    log.info(memberService.getClass().getName());
    MemberDTO memberDTO = MemberDTO.builder()
            .memberId("test1")
            .memberPw("testpw")
            .name("123")
            .phone("1234")
            .email1("123@123.com")
            .email2("123@123.com")
            .gender("male")
            .agree("1")
            .build();
    Long bno = memberService.register(memberDTO);
    log.info(bno);
  }

  @Test
  public void testList(){
    PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
            .type("tcw")
            .keyword("1")
            .page(1)
            .size(10)
            .build();
    PageResponseDTO<BoardDTO> responseDTO = boardService.list(pageRequestDTO);
    log.info(responseDTO);
  }
}