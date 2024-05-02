package org.zerock.bookmarket.service;

import org.zerock.bookmarket.domain.BookVO;
import org.zerock.bookmarket.dto.BookDTO;
import java.util.List;
import java.util.stream.Collectors;

public interface BookService {
    void register(BookDTO BookDTO);
    List<BookDTO> listAll();

}
