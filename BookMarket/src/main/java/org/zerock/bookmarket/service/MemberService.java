package org.zerock.bookmarket.service;

import org.zerock.bookmarket.dto.MemberDTO;

public interface MemberService {
    void register(MemberDTO memberDTO);
    
    MemberDTO loginPage(MemberDTO memberDTO);

}