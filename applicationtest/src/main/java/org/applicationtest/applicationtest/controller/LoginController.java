package org.applicationtest.applicationtest.controller;

import lombok.extern.log4j.Log4j2;
import org.applicationtest.applicationtest.dto.MemberDTO;
import org.applicationtest.applicationtest.service.MemberService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
@Log4j2
public class LoginController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log.info("login get..................");
        req.getRequestDispatcher("/WEB-INF/tourist/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        log.info("login post..................");

        String memberId = req.getParameter("id");
        String memberPw = req.getParameter("pw");


        try {
            MemberDTO memberDTO = MemberService.INSTANCE.login(memberId, memberPw);
                HttpSession session = req.getSession();
                session.setAttribute("loginInfo", memberDTO);
                resp.sendRedirect("/");

        } catch (Exception e) {

            resp.sendRedirect("/login?result=error");
        }
    }
}


