# frozen_string_literal: true

source "https://rubygems.org"


gem "html-proofer", "~> 5.0", group: :test

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.2.0", :platforms => [:mingw, :x64_mingw, :mswin]

gem "jekyll-theme-chirpy", "~> 7.2"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-sitemap"
  # RSS 생성기 플러그인은 이미 _plugins에 있으므로 추가 불필요
end
