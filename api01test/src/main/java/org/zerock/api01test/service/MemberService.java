package org.zerock.api01test.service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.api01test.dto.APIUserDTO;
import org.zerock.api01test.dto.APIUserJoinDTO;
import org.zerock.api01test.dto.APIUserModifyDTO;

@Transactional
public interface MemberService {
    APIUserDTO read(String username);
    void modify(APIUserModifyDTO userDTO);
    void join(APIUserJoinDTO userDTO);
    void delete(String username);
}
