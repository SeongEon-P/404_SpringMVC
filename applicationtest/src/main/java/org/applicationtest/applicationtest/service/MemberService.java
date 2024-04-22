package org.applicationtest.applicationtest.service;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.domain.MemberVO;
import org.modelmapper.ModelMapper;
import org.applicationtest.applicationtest.dao.MemberDAO;

import org.applicationtest.applicationtest.dto.MemberDTO;
import org.applicationtest.applicationtest.util.MapperUtil;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;

@Log4j2
public enum MemberService {
    INSTANCE;

    private MemberDAO dao = new MemberDAO();
    private ModelMapper modelMapper;


    // 회원 가입 서비스
    public void addMember(MemberDTO memberDTO) throws ServletException, IOException {
        dao.insertMember(memberDTO);
    }



    {modelMapper = MapperUtil.INSTANCE.get();}

    public MemberDTO login(String memberId, String memberPw)throws Exception {
        MemberVO vo = dao.getWithPassword(memberId, memberPw);

        MemberDTO memberDTO = modelMapper.map(vo, MemberDTO.class);

        return memberDTO;

    }



}
