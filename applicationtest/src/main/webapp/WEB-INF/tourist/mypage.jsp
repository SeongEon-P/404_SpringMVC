<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 24. 4. 17.
  Time: 오전 11:29
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <title> MYPAGE | 투어리스트인투어 </title>
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" href="css/common.css">
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/common.js"></script>
    <script src="js/jquery.smooth-scroll.min.js"></script>
    <!--[if lte IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/placeholders.min.js"></script>
    <![endif]-->
</head>

<body>
<ul class="skipnavi">
    <li><a href="#container">본문내용</a></li>
</ul>
<!-- wrap -->
<div id="wrap">

    <header id="header">
        <div class="header_area box_inner clear">
            <h1><a href="index.jsp">Tourist in tour</a></h1>
            <p class="openMOgnb"><a href="#"><b class="hdd">메뉴열기</b> <span></span><span></span><span></span></a></p>
            <!-- header_cont -->
            <div class="header_cont">
                <ul class="util clear">
                    <li><a href="mypage.jsp">마이페이지</a></li>
                    <li><a href="javascript:;">로그아웃</a></li>
                </ul>
                <nav>
                    <ul class="gnb clear">
                        <li><a href="javascript:;" class="openAll1">여행정보</a>
                            <div class="gnb_depth gnb_depth2_1">
                                <ul class="submenu_list">
                                    <li><a href="javascript:;">국내</a></li>
                                    <li><a href="javascript:;">해외</a></li>
                                </ul>
                            </div>
                        </li>
                        <li><a href="javascript:;" class="openAll2">고객센터</a>
                            <div class="gnb_depth gnb_depth2_2">
                                <ul class="submenu_list">
                                    <li><a href="../../notice_list.jsp">공지사항</a></li>
                                    <li><a href="javascript:;">문의하기</a></li>
                                </ul>
                            </div>
                        </li>
                        <li><a href="javascript:;" class="openAll3">상품투어</a>
                            <div class="gnb_depth gnb_depth2_3">
                                <ul class="submenu_list">
                                    <li><a href="../../program.jsp">프로그램 소개</a></li>
                                    <li><a href="javascript:;">여행자료</a></li>
                                </ul>
                            </div>
                        </li>
                        <li><a href="javascript:;" class="openAll4">티켓/가이드</a>
                            <div class="gnb_depth gnb_depth2_4">
                                <ul class="submenu_list">
                                    <li><a href="javascript:;">항공</a></li>
                                    <li><a href="javascript:;">호텔</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </nav>
                <p class="closePop"><a href="javascript:;">닫기</a></p>
            </div>
            <!-- //header_cont -->
        </div>
    </header>

    <div id="container">
        <!-- location_area -->
        <div class="location_area member">
            <div class="box_inner">
                <h2 class="tit_page">TOURIST <span class="in">in</span> TOUR</h2>
                <p class="location">MYPAGE <span class="path">/</span> 개인 정보 수정</p>
                <ul class="page_menu clear">
                    <li><a href="#" class="on">개인 정보 수정</a></li>
                </ul>
            </div>
        </div>
        <!-- //location_area -->

        <!-- bodytext_area -->
        <div class="bodytext_area box_inner">
            <!-- myinfo -->
            <dl class="myinfo">
                <dt>내 정보</dt>
                <dd>
                    <!-- appForm -->
                    <form action="#" class="regForm">
                        <fieldset>
                            <legend>내정보 입력 양식</legend>
                            <ul class="reg_list">
                                <li class="clear">
                                    <span class="tit_lbl">이름</span>
                                    <div class="reg_content">홍길동</div>
                                </li>
                                <li class="clear">
                                    <label class="tit_lbl">생년월일</label>
                                    <div class="reg_content">19910327</div>
                                </li>
                                <li class="clear">
                                    <span class="tit_lbl">성별</span>
                                    <div class="reg_content radio_area">
                                        <input type="radio" class="css-radio" id="mmm_lbl" name="gender" checked><label for="mmm_lbl">남</label>
                                        <input type="radio" class="css-radio" id="www_lbl" name="gender"><label for="www_lbl">여</label>
                                    </div>
                                </li>
                                <li class="clear">
                                    <span class="tit_lbl">주소</span>
                                    <div class="reg_content">서울시 종로구 인사동 111-35 오리엔트파빌리온 1024호</div>
                                </li>
                                <li class="clear">
                                    <span class="tit_lbl">핸드폰</span>
                                    <div class="reg_content">010-1234-1234</div>
                                </li>
                                <li class="clear">
                                    <span class="tit_lbl">SMS 수신동의</span>
                                    <div class="reg_content radio_area">
                                        <input type="radio" class="css-radio" id="smsyes_lbl" name="smsyesno" checked><label for="smsyes_lbl">허용</label>
                                        <input type="radio" class="css-radio" id="smsno_lbl" name="smsyesno"><label for="smsno_lbl">거부</label>
                                        <p class="info_line">(고객님의 편의를 위해 알림, 공지사항, 이벤트 등의 내용을 제공하고자 합니다.)</p>
                                    </div>
                                </li>
                                <li class="clear">
                                    <span class="tit_lbl">이메일</span>
                                    <div class="reg_content">hong2018@naver.com</div
