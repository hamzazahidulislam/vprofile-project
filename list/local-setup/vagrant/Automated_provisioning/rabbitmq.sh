#!/bin/bash
sudo yum update -y
sudo yum install epel-release -y
sudo yum install wget -y
sudo yum install dnf -y
cd /tmp/
cd ~ && wget https://packages.erlang-solutions.com/erlang/rpm/centos/7/x86_64/esl-erlang_24.0.2-1~centos~7_amd64.rpm

sudo yum -y install esl-erlang*.rpm

wget https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.19/rabbitmq-server-3.8.19-1.el7.noarch.rpm

sudo yum -y install rabbitmq-server*.rpm
# sudo dnf -y install centos-release-rabbitmq-38
# sudo dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server
# sudo systemctl enable --now rabbitmq-server
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --add-port=5672/tcp
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --reload

sudo systemctl start rabbitmq-server.service

sudo systemctl enable rabbitmq-server.service

sudo rabbitmqctl status
# sudo systemctl start rabbitmq-server
# sudo systemctl enable rabbitmq-server
# sudo systemctl status rabbitmq-server
sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server
