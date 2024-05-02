package org.applicationtest.applicationtest.member.controller;

import org.applicationtest.applicationtest.member.dto.MemberDTO;
import org.applicationtest.applicationtest.member.service.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/login")
public class LoginController extends HttpServlet {
  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    String memberID = req.getParameter("id");
    String memberPW = req.getParameter("pw");

    try{
      MemberDTO memberDTO = MemberService.INSTANCE.login(memberID,memberPW);
      HttpSession session = req.getSession();
      session.setAttribute("loginInfo", memberDTO);
      resp.sendRedirect("/");
    }catch(Exception e){
      e.printStackTrace();
    }
  }
}
