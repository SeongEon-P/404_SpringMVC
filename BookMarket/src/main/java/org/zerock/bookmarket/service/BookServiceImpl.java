package org.zerock.bookmarket.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.apache.ibatis.annotations.Select;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.bookmarket.domain.BookVO;
import org.zerock.bookmarket.dto.BookDTO;
import org.zerock.bookmarket.mapper.BookMapper;

import java.util.List;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
@Log4j2
@Transactional
public class BookServiceImpl implements BookService {
    private final BookMapper bookMapper;
    private final ModelMapper modelMapper;



    @Override
    public void register(BookDTO bookDTO) {
        log.info(modelMapper);
        BookVO bookVO = modelMapper.map(bookDTO, BookVO.class);
        log.info(bookVO);
        bookMapper.addBook(bookVO);
    }

    @Override
    public List<BookDTO> listAll() {
        return bookMapper.selectAll().stream()
                .map(bookVO -> modelMapper.map(bookVO,BookDTO.class))
                .collect(Collectors.toList());
    }
}