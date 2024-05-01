package org.zerock.b01.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.b01.service.ProgramService;

@Controller
@RequestMapping("/program")
@Log4j2
@RequiredArgsConstructor
public class ProgramController {
    // 의존성 주입
    private final ProgramService programService;
    @GetMapping("/list")
    // 데이터를 보내줘야해서 모델이 필요함
    public String list(Model model) {
        //"programList"이까지는 데이터 들고오는거, programService.selectAll()여기는 저장하는거라고 설명을 하시긴하셨음.
        model.addAttribute("programList", programService.selectAll());
        return "/ex/program";

    }

}
