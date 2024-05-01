package org.zerock.b01.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.zerock.b01.domain.Program;

// JpaRepository<Program, Integer> 여기에서 Integer이 부분은 id가 들어가는 부분. primary key 같은 거인듯
public interface ProgramRepository extends JpaRepository<Program, Integer> {

}
