#! /bin/bash
### HOST Initialization

echo "Start host initialization"

# Disable Selinux
setenforce 0

# Install support tools
yum install -y gcc openssl-devel pcre-static pcre-devel epel-release haproxy aws-cli -y

cat << EOF > /etc/haproxy/haproxy.cfg
global
        chroot /var/lib/haproxy
        stats timeout 30s
        maxconn 50000
        user haproxy
        group haproxy
        daemon
        log 127.0.0.1 local0
        stats socket /var/run/haproxy.stat mode 777
        spread-checks 5

defaults
     log global
     mode http
     option httplog
     option dontlognull
     timeout connect 5000
     timeout client 50000
     timeout server 50000

frontend http_front
     bind *:80
     stats uri /haproxy?stats
     default_backend http_web

backend http_web
     option httpchk
     option httpchk GET /health.html
     http-check expect rstatus 200
     balance roundrobin
     server web1 ${NODE1_IP}:5000 check
     server web2 ${NODE2_IP}:5000 check
EOF

chkconfig haproxy on
service haproxy start

