DROP TABLE terms_history;
DROP TABLE member_log;
DROP TABLE member;
DROP TABLE membership;
DROP TABLE terms;

--회원 등급 테이블
CREATE TABLE membership(
    membership_code VARCHAR(2) CONSTRAINT membership_code_ck
        CHECK(membership_code IN ('01','02','03','04')),
    membership_name VARCHAR(20) CONSTRAINT membership_name_ck
        CHECK(membership_name IN ('Family','Gold','Vip','VVip')),
    CONSTRAINT membership_code_pk PRIMARY KEY(membership_code)
);
INSERT INTO membership VALUES ('01','Family');
INSERT INTO membership VALUES ('02','Gold');
INSERT INTO membership VALUES ('03','Vip');
INSERT INTO membership VALUES ('04','VVip');

-- 약관 테이블
CREATE TABLE terms(
    terms_code VARCHAR(2) CONSTRAINT terms_code_pk PRIMARY KEY,
    terms_name VARCHAR(20) CONSTRAINT terms_name_ck
        CHECK(terms_name IN ('이용약관 동의','개인정보 수집 및 이용 동의','SMS 수신동의','이메일 수신동의')),
    terms_detail VARCHAR(1000) CONSTRAINT terms_detail_nn NOT NULL,
    terms_status VARCHAR(1) CONSTRAINT terms_status CHECK(terms_status IN ('Y','N')),
    CONSTRAINT terms_code_ck CHECK(terms_code IN ('01','02'))
);
--회원 테이블
CREATE TABLE member(
    member_id VARCHAR2(20) CONSTRAINT member_id_pk PRIMARY KEY,
    member_pw VARCHAR(20) CONSTRAINT member_pw_nn NOT NULL, 
    member_name VARCHAR2(20) CONSTRAINT member_name_nn NOT NULL,
    member_tel VARCHAR2(20) CONSTRAINT member_tel_nn NOT NULL,
    member_birthday DATE,
    member_gender VARCHAR2(2) CONSTRAINT member_gender_ck CHECK(member_gender IN ('M','F')),
    member_email VARCHAR2(45),
    member_address VARCHAR2(45),
    membership_code VARCHAR2(2) CONSTRAINT membership_code_nn NOT NULL,
    CONSTRAINT member_id_ck 
        CHECK(REGEXP_LIKE(member_id,'[a-zA-Z]+')
            AND REGEXP_LIKE(member_id,'[0-9]+')
            AND LENGTH(member_id) BETWEEN 4 AND 16
            AND member_id NOT LIKE '% %'),
    CONSTRAINT member_pw_CK 
        CHECK(REGEXP_LIKE(member_pw,'[a-zA-Z]+')
            AND REGEXP_LIKE(member_pw,'[0-9]+')
            AND REGEXP_LIKE(member_pw,'[~!@#$%^&*()+|<>?:"{}]+')
            AND LENGTH(member_pw) BETWEEN 10 AND 16
            AND member_pw NOT LIKE '% %'),
    CONSTRAINT member_name_ck CHECK(REGEXP_LIKE(member_name,'[가-힣]+') AND member_name NOT LIKE '% %'),
    CONSTRAINT member_tel_ck CHECK(REGEXP_LIKE(member_tel,'(02|(\d{3}))-(\d{3,4})-(\d{4})')),
    CONSTRAINT membership_code_fk FOREIGN KEY(membership_code) REFERENCES membership(membership_code)     
);
INSERT INTO member
VALUES ('TEST01', 'TEST01!@#$', '테스트','010-1234-5678','2001/01/01','M','email@email.com','부산광역시 부산진구','01');
INSERT INTO member
VALUES ('TEST02', 'TEST01!@#$', '테 스트','010-1234-5678','2001/01/01','M','email@email.com','부산광역시 부산진구','01');
--약관 동의이력 테이블
CREATE TABLE terms_history(
    terms_code VARCHAR2(20) CONSTRAINT terms_id_fk REFERENCES terms(terms_code),
    member_id VARCHAR2(20) CONSTRAINT member_id_fk REFERENCES member(member_id),
    th_consent VARCHAR2(1) CONSTRAINT th_consent_ck CHECK(th_consent IN ('Y','N')),
    th_consentdate DATE CONSTRAINT th_consentdate_nn NOT NULL,
    CONSTRAINT terms_history_pk PRIMARY KEY(terms_code,member_id)
);
--회원 서비스 로그 테이블
CREATE TABLE member_log(
    member_id VARCHAR2(20) CONSTRAINT member_log_pk PRIMARY KEY,
    log_join_date DATE CONSTRAINT log_joindate_nn NOT NULL,
    log_pw_date DATE CONSTRAINT log_pwdate_nn NOT NULL,
    log_terms_date DATE CONSTRAINT log_termsdate_nn NOT NULL,
    log_connect_date DATE CONSTRAINT log_connectdate_nn NOT NULL,
    log_connect_count NUMBER CONSTRAINT log_connectcount_nn NOT NULL,
    log_order_count NUMBER,
    log_payment_count NUMBER,
    CONSTRAINT member_log_fk FOREIGN KEY(member_id) REFERENCES member(member_id)
);















