#!/bin/bash
chown www-data:www-data /app -R

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

if [ -n "$ADMIN_PASS" ]; then
    pass=`php -r '$salt="!KTMdg#^^I6Z!deIVR#SgpAI6qTN7oVl";$key="$ADMIN_PASS";$key=md5($salt.$key.$salt);$key=md5($salt.$key.$salt);$key=md5($salt.$key.$salt);echo $key;'`;sed -i  "s/2a05218c7aa0a6dbd370985d984627b8/$pass/g" /app/config.php
fi

if [ -n "$MAIL_ENABLE" ]; then
    sed -i "s/define(\"MAIL_ENABLE\", false)/define(\"MAIL_ENABLE\", true)/g" /app/config.php
    sed -i "s/smtp.xxx.com/$SMTP_SERVER/g" /app/config.php
    sed -i "s/xxx@xxx.com/$MAIL_USER/g" /app/config.php
    sed -i "s/xxxxxx/$MAIL_PASS/g" /app/config.php
    sed -i "s/xxxx@xxxx.com/$MAIL_RECV/g" /app/config.php
fi

source /etc/apache2/envvars
echo "====== log file : /var/log/apache2/* ======="
exec apache2 -D FOREGROUND