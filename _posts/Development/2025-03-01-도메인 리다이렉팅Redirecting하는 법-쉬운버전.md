---
layout: post
title: 도메인 리다이렉팅(Redirecting)하는 법
date: 2025-03-01
categories:
  - Development
tags:
  - Redirecting
  - Forwarding
  - Domain
description: 도메인을 바꾸면서 포워딩을 해보자(쉬움)
---

## 하게 된 계기
도메인을 바꾸고 싶었다.
블로그도 바꾸고 싶었다.
기존 블로그는 [Home | vuepress-theme-hope](https://theme-hope.vuejs.press) 를 사용하여 만든 블로그였다. 개인적으로는 정말 좋아했던 블로그였지만, 바꿔야 겠다라고 생각한 이유는 다음과 같다. 
1. 기본(?) #MarkDown 문법과 다른 부분들이 많음 → 블로그를 쓰는 것에 대한 허들이 높아짐
2. 기분 전환

## 블로그는 뭘로 바꿨는데?
[Jekyll](https://jekyllrb.com) 의 [Chirpy](https://chirpy.cotes.page) 테마를 사용하여 만들었다.
![image](도메인%20리다이렉팅Redirecting하는%20법-쉬운버전_attachments/9D5142CD-D4B9-4BE9-AD4A-DB2855967EFE.png)
> url을 넣을까 하다가 나의 변덕을 믿기에 사진으로 대체
기회가 되면, 해당 블로그를 세팅하는 후기도 작성 하겠다. (힘들었음...)

## 도메인 리다이렉팅 방법
우선 처음에는 도메인 관리 업체 ([호스팅케이알](https://www.hosting.kr)) 자체에서 해보려고 했다. 
도메인 관리에 가면 포워딩이라는 메뉴가 있는데, 내가 잘 못하고 있는지, 뭔지 모르겠지만, 실패했다. 
심지어 24시간 이상 걸릴 수 있다고 하여, 하루 넘게 기다리기도 했지만 안됐다. 
그래서 결국 클라우드플레어([Cloudflare](https://www.cloudflare.com/ko-kr/))를 사용 하기로 했다.

### 도메인 등록
1. 클라우드플레어 가입
2. 리다이렉팅을 시키려는 도메인 추가 → 나는 A도메인을 B도메인으로 리다이렉팅 시키고 싶었고, 클라우드플레어에는 **A도메인**을 등록 하면 된다. 
	![image](도메인%20리다이렉팅Redirecting하는%20법-쉬운버전_attachments/32EB8B89-C856-4378-B888-C5D31DF129B3.png)
3. 권장 하는대로 진행하고 무료플랜으로 진행.
4. 네임서버는 클라우드플레이어 네임서버로 변경했다.
5. 등록 완료

### DNS 레코드 세팅
1. A유형은 임의 IP(192.0.2.1)로 설정하면 된다.

### 규칙 → Page Rules 세팅
아래와 같이 세팅 했다.
![image](도메인%20리다이렉팅Redirecting하는%20법-쉬운버전_attachments/F7A7D632-51F8-4D3D-9356-E308467422E4.png)

## 확인
1. 도메인에 직접 접속 해보기,
2. `curl -I "도메인"` 명령어 사용하여 보기,
3. `curl -I "도메인"` 으로 볼때 `HTTP/1.1 301 Moved Permanently` 로 잘 나오는지,
4. `Location: "리다이렉팅 타겟 도메인"` 으로 잘 나오는지 확인 하면 된다.  

## 결론
호스팅케이알 해명하라