package org.applicationtest.applicationtest.controller;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dao.MemberDAO;
import org.applicationtest.applicationtest.dto.MemberDTO;
import org.applicationtest.applicationtest.service.MemberService;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/join")
@Log4j2
public class JoinController extends HttpServlet {

    private MemberService memberService = MemberService.INSTANCE;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        log.info("join get-----------------");
        request.getRequestDispatcher("/WEB-INF/tourist/join.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        MemberDTO memberDTO = MemberDTO.builder()
                .memberId(req.getParameter("email1"))
                .memberPw(req.getParameter("member_pw"))
                .name(req.getParameter("name"))
                .phone(req.getParameter("phone"))
                .email1(req.getParameter("email1"))
                .email2(req.getParameter("email2"))
                .gender(req.getParameter("gender"))
                .agree("on".equals(req.getParameter("agree")))

                .build();


        try {
          memberService.addMember(memberDTO);
          log.info("회원가입이 완료되었습니다.");
          resp.sendRedirect("/");
        } catch (Exception e) {
            log.error("회원가입 처리 중 오류 발생", e);
        }

    }
}
