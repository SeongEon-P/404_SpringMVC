package org.zerock.bookmarket.mapper;

import org.zerock.bookmarket.domain.MemberVO;
import org.zerock.bookmarket.dto.MemberDTO;


import java.util.List;

public interface MemberMapper {
  void join(MemberVO memberVO);
  MemberVO login(MemberDTO memberDTO);

}
