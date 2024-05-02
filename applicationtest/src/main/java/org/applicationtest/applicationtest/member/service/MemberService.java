package org.applicationtest.applicationtest.member.service;

import org.applicationtest.applicationtest.member.dao.MemberDAO;
import org.applicationtest.applicationtest.member.dto.MemberDTO;

public enum MemberService {
  INSTANCE;
  private MemberDAO memberDAO = new MemberDAO();
  public MemberDTO login(String id, String pw) throws Exception {
    MemberDTO memberDTO = memberDAO.login(id, pw);
    return memberDTO;
  }
  public void addMember(MemberDTO memberDTO) throws Exception {
    memberDAO.insertMember(memberDTO);
  }
}
