# Linux Game

## 前言
為了解決線上課程中學員虛擬機可能會當機或損壞，
因此透過 docker 建立練習環境。
為增加練習性，因此埋了許多練習題目。

## Build
- `docker build -t linuxgame .`
  - 撰寫 Dockerfile 建立內容，並透過 docker build image
  
## Run
- `docker run -d -p 50000:22  --name gametest linuxgame`
  - 測試使用，將 22 port 轉向到 50000 port
  - 預設帳號 fei
  - 預設密碼 feifeiP@ssword!