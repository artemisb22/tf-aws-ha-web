#! /bin/bash
### HOST Initialization

echo "Start host initialization"
# Disable Selinux
setenforce 0

# Install support tools
yum install -y nc wget httpd aws-cli

TAG_NAME="Service"
INSTANCE_ID="`wget -qO- http://instance-data/latest/meta-data/instance-id`"
REGION="`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
TAG_VALUE="`aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=$TAG_NAME" --region $REGION --output=text | cut -f5`"

mkdir -p /var/www/html/web

sed -i 's/Listen 80/Listen 5000\nListen 6000/g' /etc/httpd/conf/httpd.conf

cat << EOF > /etc/httpd/conf.d/vh-web.conf
<VirtualHost *:5000>
  ServerName $TAG_NAME
  ServerAlias $TAG_NAME
  DocumentRoot /var/www/html/web
  ErrorLog /var/www/html/web/error.log
  CustomLog /var/www/html/web/access.log combined
</VirtualHost>
EOF

cat << EOF > /etc/httpd/conf.d/vh-web-health.conf
<VirtualHost *:6000>
  ServerName $TAG_NAME
  ServerAlias $TAG_NAME
  DocumentRoot /var/www/html/
</VirtualHost>
EOF

cat << EOF > /var/www/html/health.html
<html>
<head>
  <title>$TAG_NAME</title>
</head>
<body>
  <h1>This is $TAG_NAME</h1>
</body>
</html>
EOF

cp /var/www/html/health.html /var/www/html/web

chown -R apache:apache /var/www/html/*

chkconfig httpd on
service httpd start
