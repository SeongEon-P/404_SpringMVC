package org.zerock.api01test.service;

import org.springframework.transaction.annotation.Transactional;
import org.zerock.api01test.dto.PageRequestDTO;
import org.zerock.api01test.dto.PageResponseDTO;
import org.zerock.api01test.dto.TodoDTO;

@Transactional
public interface TodoService {
  Long register(TodoDTO todoDTO);
  TodoDTO read(Long tno);
  PageResponseDTO<TodoDTO> list(PageRequestDTO pageRequestDTO);
  void modify(TodoDTO todoDTO);
  void remove(Long tno);
}
