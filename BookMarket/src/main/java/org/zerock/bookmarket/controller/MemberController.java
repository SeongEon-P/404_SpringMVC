package org.zerock.bookmarket.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.bookmarket.dto.MemberDTO;
import org.zerock.bookmarket.service.MemberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
@Log4j2
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;
    @GetMapping("/join")
    public String join(MemberDTO memberDTO) {
        return "/member/join";
    }

    @PostMapping("/join")
    public String addJoin(MemberDTO memberDTO, RedirectAttributes redirectAttributes, BindingResult bindingResult) {
        if(bindingResult.hasErrors()){
            log.info("has errors.......");
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            return "/member/join";
        }
        log.info(memberDTO);
        memberService.register(memberDTO);
        return "redirect:/";
    }

    @GetMapping("/login")
    public void login(MemberDTO memberDTO){
    }


    @PostMapping("/login")
    public String login(Model model, HttpServletRequest req, MemberDTO memberDTO, RedirectAttributes redirectAttributes) {
        try{
            MemberDTO loginInfo = memberService.loginPage(memberDTO);
            System.out.println(loginInfo);
            HttpSession session = req.getSession();
            session.setAttribute("loginInfo", loginInfo);
            return "redirect:/";

        }catch(Exception e){
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error","아이디와 비밀번호를 확인해주세요.");
            return "redirect:/member/login";
        }
    }


    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:/";
    }



}