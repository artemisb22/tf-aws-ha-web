#! /bin/bash
### HOST Initialization

echo "Start host initialization"
# Disable Selinux
setenforce 0
NAME=$(hostname -f)
# Install support tools
yum install -y nc wget httpd aws-cli

mkdir -p /var/www/html/web

sed -i 's/Listen 80/Listen 5000\nListen 6000/g' /etc/httpd/conf/httpd.conf

cat << EOF > /etc/httpd/conf.d/vh-web.conf
<VirtualHost *:5000>

  ServerName blabla.everc.com
  ServerAlias blabla.everc.com
  DocumentRoot /var/www/html/web
  ErrorLog /var/www/html/web/error.log
  CustomLog /var/www/html/web/access.log combined

</VirtualHost>
EOF

cat << EOF > /etc/httpd/conf.d/vh-web-health.conf
<VirtualHost *:6000>

  ServerName blabla.everc.com
  ServerAlias blabla.everc.com
  DocumentRoot /var/www/html/
</VirtualHost>
EOF

cat << EOF > /var/www/html/health.html
<html>

<head>
  <title>$NAME</title>
</head>

<body>
  <h1>This is $NAME</h1>
</body>
</html>

EOF

cp /var/www/html/health.html /var/www/html/web

chown -R apache:apache /var/www/html/*

chkconfig httpd on
service httpd start
