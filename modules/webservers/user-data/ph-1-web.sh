#! /bin/bash
### HOST Initialization

echo "Start host initialization"
# Disable Selinux
setenforce 0

# Install support tools
yum install -y nc wget httpd
mkdir -p /var/www/html/web

sed -i 's/Listen 80/Listen 5000\nListen 6000/g' /etc/httpd/conf/httpd.conf

cat << EOF > /etc/httpd/conf.d/vh-web.conf
<VirtualHost *:5000>

  ServerName ${SERVICE-1}
  ServerAlias ${SERVICE-1}
  DocumentRoot /var/www/html/web
  ErrorLog /var/www/html/web/error.log
  CustomLog /var/www/html/web/access.log combined

</VirtualHost>
EOF

cat << EOF > /etc/httpd/conf.d/vh-web-health.conf
<VirtualHost *:6000>

  ServerName ${SERVICE-1}
  ServerAlias ${SERVICE-1}
  DocumentRoot /var/www/html/
</VirtualHost>
EOF

cat << EOF > /var/www/html/health.html
<html>

<head>
  <title>${SERVICE-1}</title>
</head>

<body>
  <h1>This is ${SERVICE-1}</h1>
</body>
</html>

EOF

cp /var/www/html/health.html /var/www/html/web

chown -R apache:apache /var/www/html/*

chkconfig httpd on
service httpd start