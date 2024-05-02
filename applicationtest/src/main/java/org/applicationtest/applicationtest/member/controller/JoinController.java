package org.applicationtest.applicationtest.member.controller;

import org.applicationtest.applicationtest.member.dto.MemberDTO;
import org.applicationtest.applicationtest.member.service.MemberService;

import javax.servlet.DispatcherType;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/join")
public class JoinController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.getRequestDispatcher("/WEB-INF/views/join.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.setCharacterEncoding("UTF-8");
    MemberDTO memberDTO = MemberDTO.builder()
        .member_id(req.getParameter("member_id"))
        .member_pw(req.getParameter("member_pw"))
        .name(req.getParameter("name"))
        .phone(req.getParameter("phone"))
        .email1(req.getParameter("member_id"))
        .email2(req.getParameter("email2"))
        .gender(req.getParameter("gender"))

        .build();
    if(req.getParameter("agree").equals("on")){
      memberDTO.setAgree(true);
    }else{
      memberDTO.setAgree(false);
    }

    try{
      MemberService.INSTANCE.addMember(memberDTO);
    }catch(Exception e){
      e.printStackTrace();
    }
    resp.sendRedirect("/");
  }
}
