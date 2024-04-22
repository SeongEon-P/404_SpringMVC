package org.applicationtest.applicationtest.controller;

import lombok.extern.log4j.Log4j2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
@Log4j2
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 로그아웃 로직을 doGet에서 처리
        logoutUser(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 로그아웃 로직을 doPost에서도 처리
        logoutUser(req, resp);
    }

    private void logoutUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false); // 세션이 없으면 null 반환
        if (session != null) {
            session.removeAttribute("loginInfo");
            session.invalidate(); // 세션 무효화
        }
        resp.sendRedirect("/"); // 홈 페이지로 리다이렉트
    }

}
