# XSS数据接收平台（无SQL版）
[![Build Status](https://travis-ci.org/zer0i3/BlueLotus_XSSReceiver.svg?branch=master)](https://travis-ci.org/zer0i3/BlueLotus_XSSReceiver)

为方便从image部署进行了修改，从环境变量获取后台密码与邮箱设置

Demo:

```
version: '3'
services:
  xss-receiver:
    image: zer0i3/xss-receiver
    restart: always
    ports:
      - 80:80
    environment:
      ALLOW_OVERRIDE: 1
      SMTP_SERVER: smtp.xxxx.com
      ADMIN_PASS: xxxx
      MAIL_ENABLE: 1
      MAIL_USER: xxx@xxx.xxx
      MAIL_PASS: xxxxx
      MAIL_RECV: xxx@xxx.xxx
    volumes:
      - xss:/app/myjs
volumes:
  xss:
```

配合`nginx-proxy`和`letsencrypt-nginx-proxy-companion`食用更佳

----------

原项目介绍请参见：[项目介绍](https://github.com/firesunCN/BlueLotus_XSSReceiver)