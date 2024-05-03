package org.zerock.bookmarket.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.bookmarket.dto.BookDTO;
import org.zerock.bookmarket.service.BookService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.awt.print.Book;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/book")
@Log4j2
@RequiredArgsConstructor
public class BookController {
    private final BookService bookService;

    @GetMapping("/addBook")
    public String addBook(BookDTO bookDTO) {
        return "/book/addBook";
    }

    @PostMapping("/addBook")
    public String addBook(MultipartFile file, BookDTO bookDTO, RedirectAttributes redirectAttributes, BindingResult bindingResult) throws IOException {

        if(bindingResult.hasErrors()){
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            return "redirect:/book/addBook";
        }
        log.info("POST book register.......");
        //실제 파일 이름 출력
        log.info(file.getOriginalFilename());
        //파일의 크기
        log.info(file.getSize());
        //파일의 확장자
        log.info(file.getContentType());

        //파일 저장하는 매서드 : new File("파일을 저장할 경로//파일이름.확장자")
        file.transferTo(new File("C://files//" + file.getOriginalFilename()));

        bookDTO.setImgFileName(file.getOriginalFilename());
        log.info(bookDTO);
        bookService.register(bookDTO);
        return "redirect:/";
    }

    @GetMapping({"/books", "/editBook"})
    public void books(Model model) {
        model.addAttribute("books",bookService.listAll());
//        return "/book/books";
    }


    @GetMapping({"/book", "/updateBook"})
    public void book(String id, Model model) {
          model.addAttribute("book",bookService.readBook(id));
    }


//    @GetMapping({"/updateBook"})
//    public void book(String id, Model model) {
//        model.addAttribute("book",bookService.readBook(id));
//    }


    @PostMapping("/updateBook")
    public String updateBook(@Valid BookDTO book,
                         BindingResult bindingResult,
                         RedirectAttributes redirectAttributes, BookDTO bookDTO, MultipartFile file) throws IOException {
        if(bindingResult.hasErrors()){
            log.info("has errors.......");
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            redirectAttributes.addAttribute("id",book.getId());
            return "redirect:/book/updateBook";
        }
        file.transferTo(new File("C://files//" + file.getOriginalFilename()));
        bookDTO.setImgFileName(file.getOriginalFilename());
        bookService.soojungBook(book);
        // 페이지, 사이즈 정보를 화면에 전달하기.
        redirectAttributes.addAttribute("id",book.getId());
        return "redirect:/book/books";
    }

    @GetMapping("/delete")
    public String delete(String id, RedirectAttributes redirectAttributes) {
        log.info("-----------------delete-------------------");
        log.info("id:"+id);
        bookService.remove(id);

        // 페이지, 사이즈 정보를 화면에 전달하기.

        return "redirect:/book/editBook";
    }
}