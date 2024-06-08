package org.zerock.api01test.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.zerock.api01test.dto.APIUserDTO;
import org.zerock.api01test.dto.APIUserJoinDTO;
import org.zerock.api01test.dto.APIUserModifyDTO;
import org.zerock.api01test.service.MemberService;

@RestController
@RequestMapping("/api/member")
@Log4j2
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }


//    @GetMapping("/join")  // 회원가입 페이지로 이동
//    public String joinForm() {
//        return "join";  // join.html 파일로 이동
//    }
    @CrossOrigin
    @PostMapping("/join")  // 회원가입 처리
    public String join(@RequestBody APIUserJoinDTO userDTO) {
        memberService.join(userDTO);
        return "redirect:/api/member/login";
    }

    @GetMapping("/modify")
    public String modifyForm(@AuthenticationPrincipal User user, Model model) {
        APIUserDTO userDTO = memberService.read(user.getUsername());
        model.addAttribute("mid", userDTO.getUsername());
        model.addAttribute("name", userDTO.getName());
        model.addAttribute("email", userDTO.getEmail());
        return "modify";
    }

    @PostMapping("/modify")
    public String modify(@AuthenticationPrincipal User user, @RequestBody APIUserModifyDTO userDTO) {
        userDTO.setMid(user.getUsername());
        memberService.modify(userDTO);
        return "redirect:/member/modify?success";
    }

    @DeleteMapping("/{username}")
    @ResponseBody
    public String delete(@PathVariable("username") String username) {
        memberService.delete(username);
        return "success";
    }

}


