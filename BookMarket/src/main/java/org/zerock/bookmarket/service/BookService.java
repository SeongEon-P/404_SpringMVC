package org.zerock.bookmarket.service;

import org.zerock.bookmarket.domain.BookVO;
import org.zerock.bookmarket.dto.BookDTO;
import java.util.List;
import java.util.stream.Collectors;

public interface BookService {
    void register(BookDTO bookDTO);
    List<BookDTO> listAll();
    BookDTO readBook(String id);

    List<BookDTO> modifyBook();
    void soojungBook(BookDTO bookDTO);

    void remove(String id);
}
