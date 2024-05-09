package org.zerock.b01.controller;


import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.log4j.Log4j2;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.b01.dto.upload.UploadFileDTO;
import org.zerock.b01.dto.upload.UploadResultDTO;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@RestController
@Log4j2
public class UpDownController {

    @Value("${org.zerock.upload.path}")
    private String uploadPath;

    @Tag(name = "Upload POST2", description = "POST 방식으로 파일 등록")
    @PostMapping(value = "/upload2", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String upload2(MultipartFile file) {

        log.info(file);
        if (!file.isEmpty()) {
            String originalName = file.getOriginalFilename();
            log.info(originalName);
            String uuid = UUID.randomUUID().toString();
            Path savePath = Paths.get(uploadPath, uuid + "_" + originalName);

            try {
                file.transferTo(savePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Tag(name = "remove 파일", description = "DELETE 방식으로 첨부파일 조회")
    @DeleteMapping("/remove/{fileName}")
    public Map<String,Boolean> removeFile(@PathVariable String fileName){
        Resource resource = new FileSystemResource(uploadPath + File.separator + fileName);

        String resourceName = resource.getFilename();
        Map<String,Boolean> resultMap = new HashMap<>();
        boolean removed = false;
        try {
            String contentType = Files.probeContentType(resource.getFile().toPath());
            removed = resource.getFile().delete();
            
            if(contentType.startsWith("image")){
                File thumbnailFile = new File(uploadPath+File.separator+ "s_" +fileName);
                thumbnailFile.delete();
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        resultMap.put("result",removed);
        return resultMap;
    }


    @Tag(name = "view 파일", description = "GET방식으로 첨부파일 조회")
    @GetMapping("/view/{fileName}")
    public ResponseEntity<Resource> viewFileGET(@PathVariable String fileName){
        // 파일 받아오기("C:\\upload\\aaa.jpg")
        Resource resource = new FileSystemResource(uploadPath + File.separator + fileName);

        String resourceName = resource.getFilename();
        //headers를 try안과 밖에서 모두 사용하기 위해 밖에 선언
        HttpHeaders headers = new HttpHeaders();

        try {
            //이미지 파일의 Content-Type을 설정 : image/jpeg
            headers.add("Content-Type", Files.probeContentType(resource.getFile().toPath()));
        } catch (Exception e) {
            //에러 발생시 에러 스테이터스 전달 = 500에러 코드 실행시 에러
            return ResponseEntity.internalServerError().build();
        }
        //정상 실행 시 파일과 정상 스테이터스 전달 200 : 정상 실행
        return ResponseEntity.ok().headers(headers).body(resource);
    }

    @Tag(name = "Upload POST", description = "POST 방식으로 파일 등록")
    @PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public List<UploadResultDTO> upload(UploadFileDTO uploadFileDTO) {
        log.info(uploadFileDTO);
        //파일이 있을 경우만 실행하도록 만들어주는 if문
        if (uploadFileDTO.getFiles() != null) {
            //반환값을 저장할 변수를 설정
            final List<UploadResultDTO> list = new ArrayList<>();

            //파일의 개수 만큼 반복하여 파일을 저장하도록 하는 반복문
            uploadFileDTO.getFiles().forEach(multipartFile -> {
                //원본 파일의 이름을 변수에 저장
                String originalName = multipartFile.getOriginalFilename();
                log.info(originalName);
                //UUID:중복되지 않는 아이디를 변수에 저장, 파일이름이 겹치지 않도록 파일이름에 추가하여 설정
                String uuid = UUID.randomUUID().toString();
                //파일이 저장되는 경로와 파일 이름을 함께 설정하는 코드
                Path savePath = Paths.get(uploadPath, uuid + "_" + originalName);

                boolean image = false;
                try {
                    //파일을 저장하는 transferTo(new File()이나 Path를 매개변수로 써야함)
                    multipartFile.transferTo(savePath);
                    //저장한 파일의 이미지인지 아닌지 확인하는 if문
                    if(Files.probeContentType(savePath).startsWith("image")) {
                        image = true; //image가 false이면 getLink에서 원본 이미지, 반대면 썸네일 이미지
                        //썸네일 파일의 경로 및 파일이름 설정
                        File thumbFile = new File(uploadPath, "s_" + uuid+ "_" + originalName);
                        //썸네일 파일을 생성하여 저장(원본파일, 썸네일파일, 가로 픽셀, 세로 픽셀)
                        Thumbnailator.createThumbnail(savePath.toFile(), thumbFile, 800,800);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
                //UploadResultDTO에 uuid, 파일이름, img여부 세가지를 저장하여 (postman 프로그램에) 반환
                list.add(UploadResultDTO.builder()
                        .uuid(uuid).
                        fileName(originalName)
                        .img(image)
                        .build()
                );
            });
            return list;
        }
        return null;
    }
}
