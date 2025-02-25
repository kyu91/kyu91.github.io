---
layout: post
title: VPN, VPC, VPS 정리
date: 2024-07-22
categories:
  - Development
tags:
  - Network
  - VPN
description: 네트워크에 대한 기본 용어 정의
---
## 정의  

1. VPN(Virtual Private Network)
	- 번역하면 가상 사설 네트워크
	- 보통 웹에선 SSL VPN을 통해 사용자가 VPN을 통해 먼저 접속 하게 하고 암호화를 거친뒤 서버로 접속 하게 하는 역할을 한다.
2. VPC(Virtual Private Cloud)
	- 번역하면 가상 사설 클라우드
	- AWS의 EC2(클라우드 컴퓨터)는 각각의 리전(Region)을 갖고 이러한 떨어져있는 EC2들을 묶어 연결해주는 것을 VPC라고 한다.
3. VPS(Virtual Private Server)
	- 번역하면 가상 사설 서버
	- VPC와 비슷하게 보이겠으나, 차이는 클라우드 컴퓨터가 아닌 실제 컴퓨터를 하나의 가상 서버로 연결하는 것을 말한다.

## 용도 및 특징

1. VPN
	- 서버를 접근하는 네트워크를 가상으로 설정하여 사용자를 실제 서버 네트워크가 아닌 다른 네트워크로 돌리기 위해 사용한다.
	- 보안성이 없어 해당 네트워크 통신은 VPN 개설자가 보두 볼 수 있다.
2. VPC
	- AWS에서 많이 사용되는 개념으로 여러개의 EC2를 하나의 클라우드로 묶기 위해 사용된다.
3. VPS
	- AWS의 등장으로 요즘은 별로 사용하지 않는 개념이다.

## 배운점
VPC 와 VPS의 차이를 이해 하는데 어려웠다. 사실 지금 이해한 부분이 맞는지도 확실 하지 않다.
상세히 설명 해줄 수 있는 분이 있으면 좋겠다.