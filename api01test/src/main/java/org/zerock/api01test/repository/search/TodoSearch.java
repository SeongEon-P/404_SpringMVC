package org.zerock.api01test.repository.search;

import org.springframework.data.domain.Page;
import org.zerock.api01test.dto.PageRequestDTO;
import org.zerock.api01test.dto.TodoDTO;

public interface TodoSearch {
  Page<TodoDTO> list(PageRequestDTO pageRequestDTO);
}
