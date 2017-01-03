#!/bin/bash

# Add entries from the Vagrant file to the /etc/hosts file

IFS=$'\n'
cat /vagrant/Vagrantfile |egrep "hostname|network" |awk 'NR%2{printf $0;next;}1' | tr -d "\"" | awk '{printf $7" "$3"\n"}' > /tmp/hosts
for LINE in `cat /tmp/hosts`
do
  IP=`echo $LINE |awk '{printf $1}'`
  FQDN=`echo $LINE |awk '{printf $2}'`
  SHORT=`echo $LINE |awk '{printf $2}'|cut -d "." -f 1`
  echo "${IP} ${SHORT} ${FQDN}" >> /etc/hosts
done
rm -f /tmp/hosts 

#yum localinstall -y http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#yum install -y git

yum install -y openssh-server postfix cronie
service postfix start
chkconfig postfix on
lokkit -s http -s ssh

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
yum -y install gitlab-ce

gitlab-ctl reconfigure

echo "GitLab can be reached at: http://${IP}."
echo "Username: root"
echo "Password: 5iveL!fe"

exit
