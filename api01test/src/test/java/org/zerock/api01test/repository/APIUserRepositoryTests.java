package org.zerock.api01test.repository;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.zerock.api01test.domain.APIUser;

import java.util.stream.IntStream;

@SpringBootTest
@Log4j2
public class APIUserRepositoryTests {
  @Autowired
  private APIUserRepository apiUserRepository;
  @Autowired
  private PasswordEncoder passwordEncoder;

  @Test
  public void testInserts(){
    IntStream.rangeClosed(1,100).forEach(i->{
      APIUser apiUser = APIUser.builder()
          .mid("apiuser"+i)
          .mpw(passwordEncoder.encode("1111"))
          .build();
      apiUserRepository.save(apiUser);
    });
  }
}