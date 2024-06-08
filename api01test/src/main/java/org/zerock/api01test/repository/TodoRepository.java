package org.zerock.api01test.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.zerock.api01test.domain.Todo;
import org.zerock.api01test.repository.search.TodoSearch;

public interface TodoRepository extends JpaRepository<Todo, Long>, TodoSearch {
}
