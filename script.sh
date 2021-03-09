#!/usr/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install  openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
apt-get update -y
apt-get install jenkins -y
echo "Password to jenkins "
cat  /var/lib/jenkins/secrets/initialAdminPassword
#reboot
