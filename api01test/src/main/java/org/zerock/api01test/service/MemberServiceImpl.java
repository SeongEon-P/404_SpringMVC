package org.zerock.api01test.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.modelmapper.ModelMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.zerock.api01test.domain.APIUser;
import org.zerock.api01test.dto.APIUserDTO;
import org.zerock.api01test.dto.APIUserJoinDTO;
import org.zerock.api01test.dto.APIUserModifyDTO;
import org.zerock.api01test.repository.APIUserRepository;

import java.util.Optional;

@Service
@RequiredArgsConstructor
@Log4j2
public class MemberServiceImpl implements MemberService {
    private final APIUserRepository apiUserRepository;
    private final ModelMapper modelMapper;
    private final PasswordEncoder passwordEncoder;

    @Override
    public APIUserDTO read(String username) {
        Optional<APIUser> result = apiUserRepository.findById(username);
        APIUser apiUser = result.orElseThrow();
        return modelMapper.map(apiUser, APIUserDTO.class);
    }

    @Override
    public void modify(APIUserModifyDTO userModifyDTO) {
        Optional<APIUser> result = apiUserRepository.findById(userModifyDTO.getMid());
        APIUser apiUser = result.orElseThrow();
        apiUser.setMpw(passwordEncoder.encode(userModifyDTO.getMpw()));
        apiUserRepository.save(apiUser);
    }

    @Override
    public void join(APIUserJoinDTO userJoinDTO) {
        APIUser apiUser = modelMapper.map(userJoinDTO, APIUser.class);
        apiUser.setMpw(passwordEncoder.encode(userJoinDTO.getMpw()));
        apiUserRepository.save(apiUser);
    }

    @Override
    public void delete(String username) {
        apiUserRepository.deleteById(username);
    }

}
