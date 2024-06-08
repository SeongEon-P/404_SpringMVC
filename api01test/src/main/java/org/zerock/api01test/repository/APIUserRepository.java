package org.zerock.api01test.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.zerock.api01test.domain.APIUser;

public interface APIUserRepository extends JpaRepository<APIUser, String> {
}
