-- Ãß°¡ ¿¬½À¹®Á¦
-- È¸¿ø µî±Þ Å×ÀÌºí
    CREATE TABLE MemberGradeTable(
    memberGradeCode VARCHAR2(2) CONSTRAINT memberGrCode_value_chk CHECK (memberGradeCode IN ('01', '02', '03', '04')) PRIMARY KEY,
    memberGradeName VARCHAR2(20) CONSTRAINT memberGrName_value_chk CHECK (memberGradeName IN ('Family', 'Gold', 'Vip', 'VVip'))
    );
    INSERT INTO MemberGradeTable VALUES ('01', 'Family');
    INSERT INTO MemberGradeTable VALUES ('02', 'Gold');
    INSERT INTO MemberGradeTable VALUES ('03', 'Vip');
    INSERT INTO MemberGradeTable VALUES ('04', 'VVip');
    
-----------------------------
-- ¾à°ü Å×ÀÌºí
    CREATE TABLE TermsTable(
    terms_Code VARCHAR2(2) CONSTRAINT terms_Code_chk CHECK (terms_Code IN ('01', '02')) PRIMARY KEY,
    terms_Name VARCHAR2(20) CONSTRAINT terms_Name_chk CHECK (terms_Name IN ('ÀÌ¿ë¾à°ü µ¿ÀÇ', '°³ÀÎÁ¤º¸ ¼öÁý ¹× ÀÌ¿ë µ¿ÀÇ', 'SMS ¼ö½Åµ¿ÀÇ', 'ÀÌ¸ÞÀÏ ¼ö½Å µ¿ÀÇ')) NOT NULL,
    terms_Detail VARCHAR2(1000) NOT NULL,
    necessityCheck  VARCHAR2(1) CONSTRAINT necessityChk_value_chk CHECK (necessityCheck IN ('Y', 'N')) NOT NULL    
    );
    
-----------------------------
-- È¸¿ø Å×ÀÌºí
-- ¼±»ý´ÔÀº NOT NULL ¼³Á¤À» À§¿¡ ´Ù ¸ô¾Æ¾¸
--member_id VARCHAR2(20) CONSTRAINT member_id_pk PRIMARY KEY,
--member_pw VARCHAR2(20) CONSTRAINT member_pw_nn NOT NULL, --ÀÌ·±½ÄÀ¸·Î À§¿¡ ¸ô¾Æ¾²°í, ¾Æ·¡¿¡´Â pk³ª not nullÀ» ¾È¾²½É
    
    CREATE TABLE MemberInfoTable(
    member_ID VARCHAR2(20)
    CONSTRAINT ID_alpha_num_chk CHECK (REGEXP_LIKE(member_ID, '^[a-z0-9]+$'))
    CONSTRAINT ID_no_space_chk CHECK (INSTR(member_ID, ' ') = 0) NOT NULL PRIMARY KEY,
    
--ÆÐ½º¿öµå, 3°¡Áö ´Ù ²À ¾²ÀÌ°Ô ÇÏµµ·Ï, ¼±»ý´Ô ÄÚµå
member_Password VARCHAR2(20) CONSTRAINT pwd_complexity_chk CHECK (
        (REGEXP_LIKE(member_Password, '[A-Za-z]+') --³¡¿¡+ ºÙÀº°Ç, ¸î±ÛÀÚµç »ó°ü¾ø´Ù´Â ¶æ
        AND REGEXP_LIKE(member_Password, '[0-9]') 
        AND REGEXP_LIKE(member_Password, '[~!@#$%^&*()+<>?:"\[\]]+')
        AND LENGTH(member_Password) BETWEEN 10 AND 16),        
  
    member_Name VARCHAR2(20) CONSTRAINT name_korean_only CHECK (REGEXP_LIKE(member_Name, '^[°¡-ÆR]+$'))
    CONSTRAINT Name_no_space_chk CHECK (INSTR(member_Name, ' ') = 0) NOT NULL,
    
    member_Tel VARCHAR2(20) CONSTRAINT Tel_format_chk CHECK (REGEXP_LIKE(member_Tel, '^(02|[0-9]{3})[0-9]{3,4}[0-9]{4}$')
    ) NOT NULL,
--    Tel VARCHAR2(20) CONSTRAINT Tel_format_chk CHECK (REGEXP_LIKE(Tel, '(02|(\d{3}))-(\d{3,4})-(\d{4})'))

    member_Birthdate date,
    
    member_Sex VARCHAR2(2) CONSTRAINT sex_chk CHECK (member_sex IN ('M', 'F')),    

    member_Email VARCHAR2(45),
    
    member_Address VARCHAR2(45),
    
    memberGradeCode VARCHAR2(2) CONSTRAINT fk_member_grade REFERENCES MemberGradeTable(memberGradeCode) NOT NULL
     );  
     
INSERT INTO MemberInfoTable
VALUES ('TEST01', 'TEST01', 'Å×½ºÆ®', '010-1234-5678', '2001/01/01', 'M', 'email@email.com', 'ºÎ»ê½Ã Áß±¸', '02');
-----------------------------
-- ¾à°ü µ¿ÀÇÀÌ·Â Å×ÀÌºí
    CREATE TABLE PolicyAgreeLogTable(
    terms_Code VARCHAR2(20) CONSTRAINT terms_ID_fk REFERENCES TermsTable(terms_Code) NOT NULL, 
    member_ID VARCHAR2(20)CONSTRAINT member_ID_fk REFERENCES MemberInfoTable(member_ID) NOT NULL,
    PRIMARY KEY(terms_Code, member_ID),
    agreeCheck  VARCHAR2(1) CONSTRAINT agree_ck CHECK (agreeCheck IN ('Y', 'N')) NOT NULL,
    agreeDate date CONSTRAINT agreeDate_nn NOT NULL
    );
-----------------------------
    CREATE TABLE MemberServiceLogTable(
    member_ID VARCHAR2(20)CONSTRAINT fk_ID_to_logTable REFERENCES MemberInfoTable(member_ID) NOT NULL PRIMARY KEY,
    
--    member_ID VARCHAR2(20)CONSTRAINT member_id_pk PRIMARY KEY,
--    CONSTRAINT member_id_fk FOREIGN KEY(member_id) REFERENCES member(member_ID)
    
    log_signInDate date CONSTRAINT log_signInDate_nn NOT NULL,
    log_pwChangeDate date CONSTRAINT log_pwChangeDate_nn  NOT NULL,
    log_memberGradeChangeDate date CONSTRAINT log_memberGradeChangeDate_nn NOT NULL,
    log_accessDate date CONSTRAINT log_accessDate_nn NOT NULL,
    log_accessCount NUMBER CONSTRAINT log_accessCount_nn NOT NULL,
    log_orderCount NUMBER,
    log_realPayCount NUMBER
    );
-----------------------------

DROP TABLE MemberInfoTable;
DROP TABLE MemberServiceLogTable;
DROP TABLE PolicyAgreeLogTable;
