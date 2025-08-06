---
layout: page
title: "Resume"
permalink: /resume/
sitemap: false  # (옵션) 검색 엔진에서 제외
---

<!-- 1. 이력서가 표시될 iframe 입니다. id를 지정하고, 내부 스크롤을 비활성화합니다. -->
<iframe id="resumeFrame" src="https://h-levi.addpotion.com/" style="width: 1px; min-width: 100%; border: none;" scrolling="no"></iframe>

<!-- 2. iframe의 높이를 동적으로 조절하는 라이브러리를 불러옵니다. -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/4.3.9/iframeResizer.min.js"></script>

<!-- 3. 라이브러리를 실행하여 #resumeFrame iframe의 높이를 자동으로 조절하도록 설정합니다. -->
<script>
  iFrameResize({
    log: false, // 개발 중 문제가 있을 때 true로 변경하면 콘솔에 로그가 표시됩니다.
    checkOrigin: false, // 다른 도메인(h-levi.addpotion.com)을 허용합니다.
    heightCalculationMethod: 'bodyScroll' // 콘텐츠 높이를 가장 정확하게 계산하는 방식 중 하나입니다.
  }, '#resumeFrame');
</script>

<p style="text-align: center; font-size: 0.9em; color: #666; margin-top: 20px;">
    이력서가 올바르게 표시되지 않거나 전체 화면으로 보려면 <a href="https://h-levi.addpotion.com/" target="_blank" rel="noopener noreferrer">여기</a>를 클릭하여 새 탭에서 열어주세요.
</p>
